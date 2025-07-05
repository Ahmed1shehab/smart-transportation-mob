import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../auth/login.dart';
import '../reports/reports.dart';
import 'Account Information.dart';

class ProfileManagement extends StatefulWidget {
  @override
  State<ProfileManagement> createState() => _ProfileManagementState();
}

class _ProfileManagementState extends State<ProfileManagement> {
  String? name = 'Ali Omar'; // default
  File? imageFile;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final storedName = prefs.getString('name');
    final imagePath = prefs.getString('imagePath');

    setState(() {
      name = storedName ?? 'Ali Omar';
      if (imagePath != null) {
        imageFile = File(imagePath);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: IconButton(
              icon: Icon(Icons.arrow_back, color: Color(0xff5FA8D3)),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        title: Text('Map',
            style: TextStyle(
                color: Color(0xff1B4965), fontWeight: FontWeight.w600)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Stack(
              children: [
                IconButton(
                  icon: Icon(Icons.notifications_none, color: Colors.black),
                  onPressed: () {},
                ),
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        color: Color(0xffB40000), shape: BoxShape.circle),
                    child: Text('2',
                        style: TextStyle(color: Colors.white, fontSize: 12)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
        child: Column(
          children: [
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(right: 15),
                    height: 1.5,
                    color: Color(0xff62B6CB),
                  ),
                ),
                CircleAvatar(
                  radius: 50,
                  backgroundImage: imageFile != null
                      ? FileImage(imageFile!)
                      : AssetImage('assets/images/driver.jpg')
                  as ImageProvider,
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 15),
                    height: 1.5,
                    color: Color(0xff62B6CB),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(name ?? 'Ali Omar',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Color(0xff1B4965))),
            SizedBox(height: 50),
            buildOptionTile(Icons.account_box_outlined, 'Account Information',
                  () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AccountInformation()),
                );
                _loadUserData(); // reload after editing
              },
            ),
            buildOptionTile(Icons.description_outlined, 'Reports', () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ReportsScreen()),
              );
            }),
            buildOptionTile(Icons.credit_card_outlined, 'License data', () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return Dialog(
                    backgroundColor: Color(0xffD9D9D9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: SizedBox(
                      width: 332,
                      height: 246,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
                        child: Stack(
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  'License Data',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                SizedBox(height: 10),
                                const Text(
                                  'Focus on your license availability!',
                                  style: TextStyle(fontSize: 18),
                                ),
                                SizedBox(height: 10),
                                Divider(color: Color(0xff62B6CB)),
                                SizedBox(height: 15),
                                buildLicenseTile('License Number:  7689'),
                                buildLicenseTile('Exp. Time:  2026-2-23')
                              ],
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: () => Navigator.of(context).pop(),
                                child: const Icon(Icons.dangerous_rounded,
                                    color: Color(0xff61B6CB)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
            const Spacer(),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              child: const Text(
                'Log out',
                style: TextStyle(
                    color: Color(0xffB40000),
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildOptionTile(
      IconData icon, String title, VoidCallback onTap) {
    return Column(
      children: [
        SizedBox(height: 20),
        ListTile(
          leading: Icon(icon, color: Color(0xff62B6CB)),
          title: Text(title, style: TextStyle(fontWeight: FontWeight.w600)),
          trailing: const Icon(Icons.arrow_forward_ios,
              size: 16, color: Color(0xff62B6CB)),
          onTap: onTap,
        ),
        SizedBox(height: 20),
        Divider(),
      ],
    );
  }

  Widget buildLicenseTile(String title) {
    return Column(
      children: [
        ListTile(
          leading: Icon(Icons.circle,
              color: Color(0xff62B6CB), size: 12),
          title: Text(title,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
        ),
      ],
    );
  }
}
