import 'package:flutter/material.dart';
import '../../presentation/resources/color_manager.dart';
import '../../presentation/resources/font_manager.dart';

class ReportDetailsPage extends StatelessWidget {
  final String id;
  final String title;
  final String status;

  const ReportDetailsPage({
    super.key,
    required this.id,
    required this.title,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
          'Report Details',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeightManager.semiBold,
            fontSize: 22.0,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
        child: ListView(
          children: [
            Center(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Text(
                    'Report ID',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeightManager.bold,
                      color: ColorManager.secondary,
                    ),
                  ),
                  Text(
                    '#$id',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeightManager.bold,
                      color: ColorManager.secondary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            FieldLabel('Title:'),
            FieldBox(title),
            const SizedBox(height: 25),
            FieldLabel('Status:'),
            FieldBox(status),
            const SizedBox(height: 25),
            FieldLabel('Description'),
            FieldBox('', height: 180),
            const SizedBox(height: 25),
            FieldLabel('Response:'),
            FieldBox('', height: 100),
          ],
        ),
      ),
    );
  }

  Widget FieldLabel(String label) {
    return Text(
      label,
      style: const TextStyle(
        fontWeight: FontWeightManager.semiBold,
        fontSize: 14,
        color: Colors.black,
      ),
    );
  }

  Widget FieldBox(String value, {double height = 40}) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      width: double.infinity,
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          value.isNotEmpty ? value : '',
          style: const TextStyle(fontSize: 14),
        ),
      ),
    );
  }
}
