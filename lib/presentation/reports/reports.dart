import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supervisor_app/presentation/reports/report_details.dart';
import '../../presentation/reports/reports_viewmodel.dart';
import '../../presentation/resources/color_manager.dart';
import '../../presentation/resources/font_manager.dart';
import 'new_report.dart';
import 'new_report_viewmodel.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ReportsViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: false,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        title: Text(
          'Reports',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeightManager.semiBold,
            fontSize: 22.0,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: ListView(
          children: [
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChangeNotifierProvider(
                        create: (_) => NewReportViewModel(),
                        child: const NewReportPage(),
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorManager.secondary,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text(
                  '+ New Report',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeightManager.semiBold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Text(
              'Current Report',
              style: TextStyle(
                fontWeight: FontWeightManager.bold,
                fontSize: 16,
                color: ColorManager.dark_blue,
              ),
            ),
            const SizedBox(height: 10),
            _buildReportCard(context, viewModel.currentReport!, isCurrent: true),
            const SizedBox(height: 20),
            Text(
              'Previous Reports',
              style: TextStyle(
                fontWeight: FontWeightManager.bold,
                fontSize: 16,
                color: ColorManager.dark_blue,
              ),
            ),
            const SizedBox(height: 10),
            ...viewModel.previousReports
                .map((report) => _buildReportCard(context, report, isCurrent: false))
                .toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildReportCard(BuildContext context, Report report, {required bool isCurrent}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          width: 4,
          height: double.infinity,
          decoration: BoxDecoration(
            color: isCurrent ? Colors.orange : Colors.green,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Report ID: ${report.id}', style: const TextStyle(fontSize: 14)),
            const SizedBox(height: 4),
            Text('Report title: ${report.title}', style: const TextStyle(fontSize: 14)),
            const SizedBox(height: 4),
            Text('Status: ${report.status}', style: const TextStyle(fontSize: 14)),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ReportDetailsPage(
                      id: report.id,
                      title: report.title,
                      status: report.status,
                    ),
                  ),
                );
              },
              child: const Icon(Icons.description_outlined, size: 24),
            ),
            const SizedBox(height: 2),
            const Text('Details', style: TextStyle(fontSize: 10)),
          ],
        ),
      ),
    );
  }
}
