import 'package:flutter/material.dart';

class NewReportViewModel extends ChangeNotifier {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  void sendReport() {
    final title = titleController.text.trim();
    final description = descriptionController.text.trim();

    if (title.isNotEmpty && description.isNotEmpty) {

      debugPrint('Report sent: Title - $title, Description - $description');
    } else {
      debugPrint('Please fill all fields');
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}
