import 'package:flutter/material.dart';
import '../resources/color_manager.dart';
import '../resources/font_manager.dart';

class StudentsPage extends StatelessWidget {
  const StudentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 15),
        child: ListView(
          children: [
            const Text(
              'Students List',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeightManager.bold,
              ),
            ),
            const SizedBox(height: 20),

            // Bus Header
            Center(
              child: Column(
                children: [
                  const Icon(Icons.directions_bus, size: 34),
                  const SizedBox(height: 8),
                  Text(
                    'Bus Num #8900',
                    style: TextStyle(
                      color: ColorManager.primary,
                      fontSize: 20,
                      fontWeight: FontWeightManager.semiBold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Driver Info
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.person),
                    const SizedBox(width: 8),
                    Text(
                      'Mahmoud',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeightManager.semiBold,
                        color: ColorManager.dark_blue,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.people),
                    const SizedBox(width: 8),
                    Text(
                      '20 students',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeightManager.semiBold,
                        color: ColorManager.dark_blue,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Scanned Section
            Text(
              'Scanned: (2)',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeightManager.bold,
                color: ColorManager.secondary,
              ),
            ),
            const SizedBox(height: 20),

            // Gradient Border Box
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    ColorManager.dark_blue.withOpacity(0.5),
                    ColorManager.secondary.withOpacity(0.5)
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(1.5),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ExpansionTile(
                  collapsedShape: const RoundedRectangleBorder(side: BorderSide.none),
                  shape: const RoundedRectangleBorder(side: BorderSide.none),
                  tilePadding: const EdgeInsets.symmetric(horizontal: 12),
                  childrenPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                  title: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: ColorManager.primary, width: 2),
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Omar',
                        style: TextStyle(
                          fontWeight: FontWeightManager.bold,
                          fontSize: 16,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: ColorManager.dark_blue.withOpacity(0.5), width: 2),
                        ),
                        child:  Icon(
                          Icons.accessibility_new,
                          size: 24,
                          color: ColorManager.primary,
                        ),
                      ),
                    ],
                  ),
                  children: [
                    studentDetails(),
                    const Align(
                      alignment: Alignment.bottomRight,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 32),

            // Unscanned Section Title Only
            const Text(
              'Unscanned: (18)',
              style: TextStyle(fontWeight: FontWeightManager.bold),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  Widget studentDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:  [
        SizedBox(height: 2),
        Text("ID: 555555", style: TextStyle(fontSize: 16)),
        Text("Grade: 3", style: TextStyle(fontSize: 16)),
        Text("Mansoura, Gehan Street", style: TextStyle(fontSize: 16)),
        Text("Apartment number 5", style: TextStyle(fontSize: 16)),
        Text("Phone number: +201028476529", style: TextStyle(fontSize: 16)),
        Text(
          "Disability: Hearing Impairment",
          style: TextStyle(
            fontSize: 16,
            fontStyle: FontStyle.italic,
            color: ColorManager.primary,
          ),
        ),
        SizedBox(height: 8),
      ],
    );
  }
}
