import 'package:flutter/material.dart';
import 'package:member/core/helper/colors_manager.dart';

class ReportSentDialog extends StatelessWidget {
  final String reportId;

  const ReportSentDialog({super.key, required this.reportId});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Close button
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: const Icon(Icons.close, size: 20,  color: ColorsManager.primary),
              ),
            ),

            const SizedBox(height: 10),
            const Text(
              "Your report have been sent!",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: "Montserrat",
                color: Color(0xFF61B6CB),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "You will receive the response through your E-mail",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                fontFamily: "Montserrat",
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Your Report ID is:\n$reportId",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: "Montserrat",
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close dialog
                  Navigator.of(context).pop(); // Go back to previous screen
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF61B6CB),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Done",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: "Montserrat",
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
