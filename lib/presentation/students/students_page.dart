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
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32),
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
            Center(
              child: Column(
                children: [
                  const Icon(Icons.directions_bus, size: 28),
                  const SizedBox(height: 8),
                  Text(
                    'Bus Num #8900',
                    style: TextStyle(
                      color: ColorManager.primary,
                      fontSize: 18,
                      fontWeight: FontWeightManager.medium,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.person),
                const SizedBox(width: 8),
                const Text('Mahmoud'),
                const Spacer(),
                const Icon(Icons.people),
                const SizedBox(width: 8),
                const Text('20 students'),
              ],
            ),
            const SizedBox(height: 24),



            const Text(
              'Scanned: (2)',
              style: TextStyle(fontWeight: FontWeightManager.bold),
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: ColorManager.primary),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ExpansionTile(
                collapsedShape: const RoundedRectangleBorder(side: BorderSide.none),
                shape: const RoundedRectangleBorder(side: BorderSide.none),
                tilePadding: const EdgeInsets.symmetric(horizontal: 12),
                childrenPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                title: Row(
                  children: [
                    const CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage('assets/images/avatar.png'),
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
                     Icon(Icons.accessibility_new, color: ColorManager.primary),
                  ],
                ),
                children: [
                  _buildStudentDetails(),
                  const Align(
                    alignment: Alignment.bottomRight,
                    child: Icon(Icons.phone, color: Colors.green),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              'Unscanned: (18)',
              style: TextStyle(fontWeight: FontWeightManager.bold),
            ),
            const SizedBox(height: 12),

            ..._buildExpandableStudentTiles(),
          ],
        ),
      ),
    );
  }

  Widget _buildStudentDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:  [
        SizedBox(height: 8),
        Text("ID: 555555", style: TextStyle(fontSize: 14)),
        Text("Grade: 3", style: TextStyle(fontSize: 14)),
        Text("Mansoura, Gehan Street", style: TextStyle(fontSize: 14)),
        Text("Apartment number 5", style: TextStyle(fontSize: 14)),
        Text("Phone number: +201028476529", style: TextStyle(fontSize: 14)),
        Text(
          "Disability: Hearing Impairment",
          style: TextStyle(
            fontSize: 14,
            fontStyle: FontStyle.italic,
            color: ColorManager.primary,
          ),
        ),
        SizedBox(height: 8),
      ],
    );
  }

  List<Widget> _buildExpandableStudentTiles() {
    final students = [
      {'name': 'Reem', 'hasDisability': false},
      {'name': 'Omar', 'hasDisability': false},
      {'name': 'Omar', 'hasDisability': true},
    ];

    return students.map((student) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: ExpansionTile(
          collapsedShape: const RoundedRectangleBorder(side: BorderSide.none),
          shape: const RoundedRectangleBorder(side: BorderSide.none),
          tilePadding: const EdgeInsets.symmetric(horizontal: 12),
          childrenPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          title: Row(
            children: [
              const CircleAvatar(
                radius: 18,
                backgroundImage: AssetImage('assets/images/avatar.png'),
              ),
              const SizedBox(width: 12),
              Text(
                student['name'] as String,
                style: const TextStyle(fontWeight: FontWeightManager.medium),
              ),
              const Spacer(),
              if (student['hasDisability'] as bool)
                 Icon(Icons.accessibility_new, color: ColorManager.primary),
            ],
          ),
          children: [
            _buildStudentDetails(),
            const Align(
              alignment: Alignment.bottomRight,
              child: Icon(Icons.phone, color: Colors.green),
            ),
          ],
        ),
      );
    }).toList();
  }
}
