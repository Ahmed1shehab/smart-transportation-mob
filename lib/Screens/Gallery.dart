import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class Gallery extends StatefulWidget {
  @override
  State<Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  List<DrivingImage> images = [];
  CameraController? _cameraController;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _initCamera();
    _startAutoCapture();
    _loadInitialImages();
  }

  void _loadInitialImages() {
    images.addAll([
      DrivingImage(path: 'assets/images/bad.jpg', isViolation: true),
      DrivingImage(path: 'assets/images/driver.jpg', isViolation: false),
      DrivingImage(path: 'assets/images/bad2.png', isViolation: true),
      DrivingImage(path: 'assets/images/driver.jpg', isViolation: false),
    ]);
  }

  Future<void> _initCamera() async {
    final cameras = await availableCameras();
    final camera = cameras.first;
    _cameraController = CameraController(camera, ResolutionPreset.medium);
    await _cameraController!.initialize();
    if (!mounted) return;
    setState(() {});
  }

  void _startAutoCapture() {
    _timer = Timer.periodic(Duration(minutes: 10), (_) => _captureAndAddImage());
    // _timer = Timer.periodic(Duration(seconds: 20), (_) => _captureAndAddImage());
  }

  Future<void> _captureAndAddImage() async {
    if (_cameraController == null || !_cameraController!.value.isInitialized) return;

    final directory = await getApplicationDocumentsDirectory();
    final imagePath = join(directory.path, 'image_${DateTime.now().millisecondsSinceEpoch}.jpg');

    try {
      await _cameraController!.takePicture().then((file) async {
        final savedFile = await File(file.path).copy(imagePath);

        final isViolation = DateTime.now().second % 2 == 0;

        setState(() {
          images.insert(
            0,
            DrivingImage(
              path: savedFile.path,
              isViolation: isViolation,
              isFromFile: true,
            ),
          );
        });
      });
    } catch (e) {
      print('Error capturing image: $e');
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return Scaffold(
        appBar: AppBar(title: Text('Loading Camera...')),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Driver Behavior',
          style: TextStyle(color: Color(0xff1B4965), fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: GridView.builder(
          itemCount: images.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1,
          ),
          itemBuilder: (context, index) {
            final item = images[index];
            return Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: item.isViolation ? Color(0xffB40000) : Colors.grey.shade300,
                  width: item.isViolation ? 2 : 1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: item.isFromFile
                        ? Image.file(
                      File(item.path),
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    )
                        : Image.asset(
                      item.path,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  if (item.isViolation)
                    Positioned(
                      top: 6,
                      right: 6,
                      child: Icon(
                        Icons.warning_amber_rounded,
                        color: Color(0xffB40000),
                        size: 24,
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class DrivingImage {
  final String path;
  final bool isViolation;
  final bool isFromFile;

  DrivingImage({
    required this.path,
    required this.isViolation,
    this.isFromFile = false,
  });
}
