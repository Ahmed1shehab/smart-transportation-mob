import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:supervisor_app/presentation/resources/color_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AccountInfoViewModel extends ChangeNotifier {
  bool _obscurePassword = true;
  File? _pickedImage;

  String _userName = 'Maryam';
  String _phoneNumber = '+20 99999999';
  String _email = 'aaaaa@gmail.com';
  String _password = '*******';

  bool get obscurePassword => _obscurePassword;
  File? get pickedImage => _pickedImage;

  String get userName => _userName;
  String get phoneNumber => _phoneNumber;
  String get email => _email;
  String get password => _password;

  /// Toggle password visibility
  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  /// Pick image from gallery and show preview dialog
  Future<void> pickImage(BuildContext context) async {
    final status = await Permission.photos.request();

    if (status.isGranted) {
      final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        File tempImage = File(pickedFile.path);
        await showPreviewDialog(context, tempImage);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Permission denied to access gallery')),
      );
    }
  }

  Future<void> showPreviewDialog(BuildContext context, File tempImage) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            width: 300,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 250,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.file(tempImage, fit: BoxFit.cover),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      child: IconButton(
                        icon: const Icon(Icons.close, color: Colors.red),
                        onPressed: () {
                          Navigator.of(context).pop(); // Close dialog
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    _pickedImage = tempImage;
                    _saveImagePath(tempImage.path); // Save path persistently
                    notifyListeners();
                    Navigator.of(context).pop(); // Save and close

                  },
                  child: const Text(
                    'Save',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorManager.primary,
                    minimumSize: const Size(double.infinity, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

  }

  /// Future usage: Update from API
  void updateUserInfo({
    required String name,
    required String phone,
    required String emailAddress,
    required String userPassword,
  }) {
    _userName = name;
    _phoneNumber = phone;
    _email = emailAddress;
    _password = userPassword;
    notifyListeners();
  }

  Future<void> _saveImagePath(String path) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('profileImagePath', path);
  }

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final savedPath = prefs.getString('profileImagePath');
    if (savedPath != null && File(savedPath).existsSync()) {
      _pickedImage = File(savedPath);
      notifyListeners();
    }
  }


}
