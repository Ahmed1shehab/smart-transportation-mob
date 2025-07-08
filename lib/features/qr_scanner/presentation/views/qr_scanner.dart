import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRScannerScreen extends StatelessWidget {
  const QRScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: Colors.white),
      ),
      body: Stack(
        children: [
          // الكاميرا
          MobileScanner(
            controller: MobileScannerController(
              detectionSpeed: DetectionSpeed.normal,
              facing: CameraFacing.back,
              torchEnabled: false,
            ),
        onDetect: (BarcodeCapture capture) {
  final List<Barcode> barcodes = capture.barcodes;
  for (final barcode in barcodes) {
    final String? code = barcode.rawValue;
    if (code != null) {
      debugPrint('QR Code Found: $code');
      Navigator.of(context).pop(code);
      break;
    }
  }
},

          ),

          // Overlay
          Column(
            children: [
              const SizedBox(height: 60),
              Center(
                child: Text(
                  'Scan QR Code',
                  style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 60),

              // Frame
              Center(
                child: Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Icon(Icons.qr_code_scanner, color: Colors.white38, size: 80),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Place QR code within the frame to scan',
                style: TextStyle(color: Colors.white60, fontSize: 14),
              ),
              const Spacer(),

              // Upload QR button
              Padding(
                padding: const EdgeInsets.only(bottom: 32),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white10,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () {
                    // TODO: Handle picking QR image from gallery
                  },
                  icon: const Icon(Icons.image, color: Colors.white),
                  label: const Text("Upload QR code", style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
