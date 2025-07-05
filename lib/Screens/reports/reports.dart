import 'package:flutter/material.dart';
import 'package:sonic_driver/Screens/NavBar.dart';
import 'package:sonic_driver/Screens/reports/new%20report.dart';
import 'package:sonic_driver/Screens/reports/Details.dart';
import '../../models/report_model.dart';

class ReportsScreen extends StatefulWidget {
  @override
  _ReportsScreenState createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  List<Report> unreviewedReports = [
    Report(id: 123, title: 'Missing Item', status: 'Unreviewed', details: 'Item was not delivered.'),
  ];

  List<Report> reviewedReports = [
    Report(id: 12, title: "Zain's mother", status: 'Reviewed', details: 'This report was reviewed.'),
    Report(id: 13, title: 'Administrative report', status: 'Reviewed', details: 'Administrative details go here.'),
    Report(id: 14, title: 'System Feedback', status: 'Reviewed', details: 'System feedback received and noted.'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xff5FA8D3)),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const NavBar()));
          }
        ),
        title: const Text(
          'Reports',
          style: TextStyle(
            color: Color(0xff5FA8D3),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Center(
                child: SizedBox(
                  width: 148,
                  height: 51,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NewReportScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      backgroundColor: Color(0xffCAF0F8),
                      elevation: 8,
                      shadowColor: Colors.black,
                    ),
                    child: const Text(
                      'New Report',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    const Text('Unreviewed Reports', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    ...unreviewedReports.map((report) => _buildReportCard(report, const Color(0xffFFBB3E))),
                    const SizedBox(height: 24),
                    const Text('Previewed Reports', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    ...reviewedReports.map((report) => _buildReportCard(report, const Color(0xff00B4D8))),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReportCard(Report report, Color sideColor) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        width: 355,
        height: 120,
        decoration: const BoxDecoration(
          color: Color(0xffD9D9D9),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 4,
              margin: const EdgeInsets.only(left: 12, top: 15, bottom: 15),
              decoration: BoxDecoration(
                color: sideColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15, right: 50, bottom: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Report Number: #${report.id}', style: TextStyle(color: Colors.black)),
                        const SizedBox(height: 15),
                        Text('Report title: ${report.title}', style: TextStyle(color: Colors.black)),
                        const SizedBox(height: 15),
                        Text('Status: ${report.status}', style: TextStyle(color: Colors.black)),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 8,
                    right: 10,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ReportDetailScreen(report: report),
                          ),
                        );
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size(50, 50),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: const Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.description_outlined, color: Colors.black, size: 24),
                          SizedBox(height: 4),
                          Text('Details', style: TextStyle(color: Colors.black, fontSize: 12)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
