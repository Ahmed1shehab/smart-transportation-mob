import 'package:flutter/material.dart';
import 'package:member/core/helper/on_generate_route.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // تم تغييرها إلى false
      appBar: AppBar(
        title: const Text("Reports"),
        leading: const BackButton(color: Colors.black),
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
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                  maxWidth: constraints.maxWidth,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --- New Report Button ---
                    Center(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pushNamed(context, OnGenerateRoute.newReportPage);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF61B6CB),
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        icon: const Icon(Icons.add, color: Colors.white, size: 14),
                        label: const Text(
                          "New Report",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: "Montserrat",
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),

                    // --- Current Report ---
                    const Text(
                      "Current Report",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        fontFamily: "Montserrat",
                        color: Color(0xFF1B4865),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ReportCard(
                      color: Colors.orange,
                      reportId: "001",
                      title: "Bus Incident",
                      status: "In Progress",
                    ),

                    const SizedBox(height: 30),

                    // --- Previous Reports ---
                    const Text(
                      "Previous Reports",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        fontFamily: "Montserrat",
                        color: Color(0xFF1B4865),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Column(
                      children: [
                        ReportCard(
                          color: Colors.green,
                          reportId: "000",
                          title: "Security Alert",
                          status: "Resolved",
                        ),
                        const SizedBox(height: 10),
                        ReportCard(
                          color: Colors.blue,
                          reportId: "002",
                          title: "Driver Behavior",
                          status: "Closed",
                        ),
                      ],
                    ),
                    // مساحة إضافية في الأسفل لمنع الـ overflow
                    SizedBox(height: MediaQuery.of(context).padding.bottom),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class ReportCard extends StatelessWidget {
  final Color color;
  final String reportId;
  final String title;
  final String status;

  const ReportCard({
    super.key,
    required this.color,
    required this.reportId,
    required this.title,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      margin: const EdgeInsets.only(bottom: 10), // إضافة هامش سفلي
      decoration: BoxDecoration(
        color: const Color(0XFFD4DBE0).withOpacity(.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // --- Colored Line ---
          Container(
            width: 4,
            height: 70,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 12),

          // --- Report Info ---
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    text: "Report ID: ",
                    style: const TextStyle(
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                        text: reportId,
                        style: const TextStyle(
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Text.rich(
                  TextSpan(
                    text: "Report title: ",
                    style: const TextStyle(
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                        text: title,
                        style: const TextStyle(fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Text.rich(
                  TextSpan(
                    text: "Status: ",
                    style: const TextStyle(
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                        text: status,
                        style: const TextStyle(fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // --- Details Icon ---
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                'ReportDetailsPage',
                arguments: {
                  "reportId": reportId,
                  "title": title,
                  "status": status,
                  "recipient": "Delta Modern Language School",
                  "description": "Detailed description for report $reportId",
                },
              );
            },
            child: Column(
              children: const [
                Icon(Icons.description_outlined, color: Colors.black54),
                Text("Details",
                    style: TextStyle(fontSize: 10, fontFamily: "Montserrat")),
              ],
            ),
          ),
        ],
      ),
    );
  }
}