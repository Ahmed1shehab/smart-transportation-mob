import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../presentation/resources/color_manager.dart';
import '../../presentation/resources/font_manager.dart';
import 'new_report_viewmodel.dart';

class NewReportPage extends StatelessWidget {
  const NewReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<NewReportViewModel>(context);

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
          'New Report',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeightManager.semiBold,
            fontSize: 22.0,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: ListView(
          children: [
            const SizedBox(height: 30),
            const Text(
              'Title:',
              style: TextStyle(
                fontWeight: FontWeightManager.semiBold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: viewModel.titleController,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide:  BorderSide(color: ColorManager.secondary),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide:  BorderSide(color: ColorManager.secondary),
                ),
                contentPadding: const EdgeInsets.all(14),
              ),
            ),

            const SizedBox(height: 24),
            const Text(
              'Description',
              style: TextStyle(
                fontWeight: FontWeightManager.semiBold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: viewModel.descriptionController,
              maxLines: 10,
              textAlignVertical: TextAlignVertical.top,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide:  BorderSide(color: ColorManager.secondary),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide:  BorderSide(color: ColorManager.secondary),
                ),
                contentPadding: const EdgeInsets.all(14),
              ),
            ),

            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  viewModel.sendReport();
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return Dialog(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        backgroundColor: Colors.white,
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(height: 10),
                                  Text(
                                    'Your report have been sent!',
                                    style: TextStyle(
                                      fontWeight: FontWeightManager.semiBold,
                                      fontSize: 16,
                                      color: ColorManager.secondary,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 16),
                                  const Text(
                                    'Your Report ID is:\n#125',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeightManager.semiBold,
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: ColorManager.secondary,
                                        padding: const EdgeInsets.symmetric(vertical: 12),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                      ),
                                      child: const Text(
                                        'Done',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeightManager.semiBold,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Positioned(
                              top: 8,
                              right: 8,
                              child: GestureDetector(
                                onTap: () => Navigator.pop(context),
                                child: const Icon(Icons.close, size: 20, color: Colors.black54),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },

                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorManager.secondary,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text(
                  'Send',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeightManager.semiBold,
                    fontSize: 16,
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
