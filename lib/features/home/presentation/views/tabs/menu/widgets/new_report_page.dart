import 'package:flutter/material.dart';
import 'package:member/features/home/presentation/views/tabs/menu/widgets/report_sent_dialog.dart';

class NewReportPage extends StatefulWidget {
  const NewReportPage({super.key});

  @override
  State<NewReportPage> createState() => _NewReportPageState();
}

class _NewReportPageState extends State<NewReportPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String? _selectedProvider;

  final List<String> _providers = ['Security', 'Transport', 'Maintenance'];

 @override
Widget build(BuildContext context) {
  return Scaffold(
    resizeToAvoidBottomInset: true, // يسمح بتحريك المحتوى فوق الكيبورد
    appBar: AppBar(
      title: const Text("New Report"),
      leading: const BackButton(color: Colors.black),
      actions: const [
        Padding(
          padding: EdgeInsets.only(right: 16.0),
          child: Icon(Icons.mic_none_outlined, color: Colors.black),
        ),
      ],
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
        color: Colors.black,
        fontFamily: "Montserrat",
      ),
    ),
    backgroundColor: Colors.white,
    body: SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Title ---
            const Text(
              "Title:",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontFamily: "Montserrat",
              ),
            ),
            const SizedBox(height: 6),
            TextField(
              controller: _titleController,
              decoration: _inputDecoration(),
            ),
            const SizedBox(height: 20),

            // --- Service Provider ---
            const Text(
              "Service Provider:",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontFamily: "Montserrat",
              ),
            ),
            const SizedBox(height: 6),
            DropdownButtonFormField<String>(
              value: _selectedProvider,
              items: _providers
                  .map((provider) => DropdownMenuItem(
                        value: provider,
                        child: Text(provider),
                      ))
                  .toList(),
              onChanged: (value) => setState(() => _selectedProvider = value),
              decoration: _inputDecoration(),
              icon: const Icon(Icons.arrow_drop_down),
            ),
            const SizedBox(height: 20),

            // --- Description ---
            const Text(
              "Description",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontFamily: "Montserrat",
              ),
            ),
            const SizedBox(height: 6),
            TextField(
              controller: _descriptionController,
              maxLines: 5,
              decoration: _inputDecoration(),
            ),
            const SizedBox(height: 30),

            // --- Send Button ---
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => ReportSentDialog(reportId: "#125"),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF61B6CB),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "Send",
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}


  InputDecoration _inputDecoration() {
    return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.lightBlue),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.lightBlue),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.blue),
      ),
    );
  }
}