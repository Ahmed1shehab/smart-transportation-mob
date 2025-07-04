import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../dashboard/dashboard_viewmodel.dart';
import 'students_viewmodel.dart';

class StudentsPage extends StatefulWidget {
  final String tripId;

  const StudentsPage({super.key, required this.tripId});

  @override
  State<StudentsPage> createState() => _StudentsPageState();
}

class _StudentsPageState extends State<StudentsPage> {
  bool imageVisible = false;
  String imageUrl = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final vm = Provider.of<StudentsViewModel>(context, listen: false);
      vm.fetchStudents(widget.tripId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<StudentsViewModel>(
      builder: (context, vm, _) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            automaticallyImplyLeading: false,
            centerTitle: false,
            title: Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                'students_list_title'.tr(),
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ),
          ),
          body: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 15),
                child: vm.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : vm.error != null
                    ? Center(child: Text(vm.error!))
                    : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    if (vm.students.isEmpty)
                      Expanded(
                        child: Center(
                          child: Text(
                            'no_upcoming_trip'.tr(),
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    else
                      Expanded(
                        child: ListView(
                          children: [
                            _buildTripHeader(),
                            const SizedBox(height: 24),
                            Text(
                              '${'scanned'.tr()}: (${vm.scannedCount})',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeightManager.semiBold,
                                color: ColorManager.secondary,
                              ),
                            ),
                            const SizedBox(height: 11),
                            ...vm.students.map(_buildStudentCard).toList(),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              if (imageVisible) fullImage(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTripHeader() {
    final tripVm = Provider.of<DashboardViewModel>(context, listen: false);
    final bus = tripVm.busModel ?? "-";
    final driver = tripVm.driverName ?? "-";
    final total = tripVm.totalStudents.toString();

    return Column(
      children: [
        const Icon(Icons.directions_bus, size: 34),
        const SizedBox(height: 8),
        Text(
          '${'bus_model'.tr()}: $bus',
          style: TextStyle(
            color: ColorManager.primary,
            fontSize: 20,
            fontWeight: FontWeightManager.semiBold,
          ),
        ),
        const SizedBox(height: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.person),
                const SizedBox(width: 8),
                Text(
                  driver,
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
                  '$total ${'students'.tr()}',
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
      ],
    );
  }

  Widget _buildStudentCard(student) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
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
          childrenPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
          title: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      imageUrl = student.image;
                      imageVisible = true;
                    });
                  },
                  child: ClipOval(
                    child: Image.network(
                      student.image,
                      width: 45,
                      height: 45,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                      const Icon(Icons.person, size: 45),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    student.name,
                    style: TextStyle(
                      fontWeight: FontWeightManager.semiBold,
                      fontSize: 16,
                      color: ColorManager.dark_blue,
                      letterSpacing: 2,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      )
                    ],
                  ),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: const Icon(Icons.nfc, size: 26),
                    color: ColorManager.primary,
                    onPressed: () async {
                      try {
                        final tag = await FlutterNfcKit.poll();
                        debugPrint('NFC tapped for ${student.name}');
                        debugPrint('NFC Tag ID: ${tag.id}');
                        await FlutterNfcKit.finish();

                      
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Scanned NFC for ${student.name}: ${tag.id}')),
                        );
                      } catch (e) {
                        debugPrint('NFC Error: $e');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('NFC Error: $e')),
                        );
                      }
                    },
                  ),

                ),
                const SizedBox(width: 8),
                if (student.disabilities.isNotEmpty)
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: ColorManager.dark_blue.withOpacity(0.5),
                        width: 2,
                      ),
                    ),
                    child: Icon(
                      Icons.accessibility_new,
                      size: 24,
                      color: ColorManager.primary,
                    ),
                  ),
              ],
            ),
          ),
          children: [
            studentDetails(student),
          ],
        ),
      ),
    );
  }

  Widget studentDetails(student) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          details('id'.tr(), student.ssn),
          const SizedBox(height: 8),
          details_phone('phone'.tr(), student.phone, student.phone != '-' ? Icons.phone : null),
          const SizedBox(height: 8),
          details('address'.tr(), student.address),
          const SizedBox(height: 8),
          disability(student),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget details(String title, String value) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          color: ColorManager.dark_blue,
          fontSize: 16,
          letterSpacing: 1,
        ),
        children: [
          TextSpan(
            text: "$title: ",
            style: TextStyle(fontWeight: FontWeightManager.semiBold),
          ),
          TextSpan(text: value),
        ],
      ),
    );
  }

  Widget details_phone(String title, String value, IconData? icon) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "$title: ",
          style: TextStyle(
            fontWeight: FontWeightManager.semiBold,
            color: ColorManager.dark_blue,
            fontSize: 16,
            letterSpacing: 1,
          ),
        ),
        if (icon != null) ...[
          Icon(icon, size: 18, color: ColorManager.dark_blue),
          const SizedBox(width: 4),
        ],
        Text(
          value,
          style: TextStyle(
            color: ColorManager.dark_blue,
            fontSize: 16,
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }

  Widget disability(student) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '${'disability'.tr()}: ',
          style: TextStyle(
            fontWeight: FontWeightManager.semiBold,
            color: ColorManager.secondary,
            fontSize: 16,
            letterSpacing: 1,
          ),
        ),
        if (student.disabilities.isNotEmpty) ...[
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: ColorManager.secondary.withOpacity(0.5),
                width: 2,
              ),
            ),
            child: Icon(Icons.accessibility_new, size: 24, color: ColorManager.primary),
          ),
          const SizedBox(width: 8),
          Text(
            student.disabilities.join(', '),
            style: TextStyle(
              color: ColorManager.secondary,
              fontSize: 16,
              letterSpacing: 1,
            ),
          ),
        ] else ...[
          Text(
            "-",
            style: TextStyle(
              color: ColorManager.dark_blue,
              fontSize: 16,
              letterSpacing: 1,
            ),
          ),
        ],
      ],
    );
  }

  Widget fullImage() {
    return Container(
      color: Colors.black.withOpacity(0.5),
      child: Center(
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.person, size: 100),
                ),
              ),
            ),
            Positioned(
              top: -3,
              right: -4,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white, size: 30),
                onPressed: () {
                  setState(() {
                    imageVisible = false;
                    imageUrl = '';
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
