import 'package:flutter/material.dart';

class ReportDetailsPage extends StatelessWidget {
  final String reportId;
  final String title;
  final String status;
  final String recipient;
  final String description;

  const ReportDetailsPage({
    super.key,
    required this.reportId,
    required this.title,
    required this.status,
    required this.recipient,
    required this.description,
  });


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Report Details"),
        leading: const BackButton(color: Colors.black),
      actions: [
  Padding(
    padding: const EdgeInsets.only(right: 16),
    child: Transform(
      alignment: Alignment.center,
      transform: Matrix4.rotationY(3.1416),
      child: const Icon(Icons.hearing, color: Colors.black),
    ),
  ),
],

        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 0,
        titleTextStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Colors.black,
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ListView(
          children: [
            const SizedBox(height: 10),

            // --- Report ID Title ---
            Center(
              child: Column(
                children: [
                  const Text(
                    "Report ID",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                   
                      fontFamily: "Montserrat",
                               color: Color(0xFF61B6CB),
                    ),
                  ),
                  Text(
                    "#$reportId",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Montserrat",
                      color: Color(0xFF61B6CB),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // --- Title ---
            const Text("Title:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: "Montserrat",
                )),
            const SizedBox(height: 6),
            _readonlyField(title),

            const SizedBox(height: 20),

            // --- Status ---
            const Text("Status:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: "Montserrat",
                )),
            const SizedBox(height: 6),
            _readonlyField(status),

            const SizedBox(height: 20),

            // --- To ---
            const Text("To:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: "Montserrat",
                )),
            const SizedBox(height: 6),
            _readonlyField(recipient),

            const SizedBox(height: 20),

            // --- Description ---
            const Text("Description",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: "Montserrat",
                )),
            const SizedBox(height: 6),
            Container(
              height: 130,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFECECEC),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                description.isNotEmpty ? description : "No description provided",
                style: const TextStyle(fontFamily: "Montserrat"),
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              "You will receive the response through your E-mail",
              style: TextStyle(
                fontSize: 12,
                fontFamily: "Montserrat",
               color: Color(0XFF000000)
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  // Widget for read-only fields
  Widget _readonlyField(String value) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0XFFEAEAEA),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        value,
        style: const TextStyle(fontFamily: "Montserrat",color: Color(0XFF000000)),
      ),
    );
  }
}
