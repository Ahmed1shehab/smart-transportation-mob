import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class AccountInformation extends StatefulWidget {
  @override
  _AccountInformationState createState() => _AccountInformationState();
}

class _AccountInformationState extends State<AccountInformation> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  File? _selectedImage;
  File? _tempImage;

  bool isNameEditing = false;
  bool isPhoneEditing = false;
  bool isPasswordEditing = false;
  bool showPassword = false;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    nameController.text = prefs.getString('name') ?? 'Ahmed Emad';
    phoneController.text = prefs.getString('phone') ?? '+201017078859';
    passwordController.text = prefs.getString('password') ?? 'password';

    String? imagePath = prefs.getString('imagePath');
    if (imagePath != null) {
      setState(() {
        _selectedImage = File(imagePath);
      });
    }
  }

  Future<void> _saveUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', nameController.text);
    await prefs.setString('phone', phoneController.text);
    await prefs.setString('password', passwordController.text);
    if (_selectedImage != null) {
      await prefs.setString('imagePath', _selectedImage!.path);
    }
  }

  void _showUploadDialog() {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Upload new photo", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: () => _pickImage(ImageSource.gallery),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(25),
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xff62B6CB), width: 2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.image_outlined, size: 50, color: Color(0xff62B6CB)),
                        ),
                        const SizedBox(height: 10),
                        const Text("Select Photo", style: TextStyle(fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text("or"),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () => _pickImage(ImageSource.camera),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffCAF0F8),
                    ),
                    child: const Text("Open Camera & Take Photo"),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_tempImage != null) {
                        setState(() {
                          _selectedImage = _tempImage;
                        });
                        _saveUserData();
                      }
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff62B6CB),
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text("Save", style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
              Positioned(
                top: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: const Icon(Icons.dangerous_rounded, color: Color(0xff61B6CB)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _tempImage = File(pickedFile.path);
      });
    }
  }

  Widget buildEditableField({
    required String label,
    required TextEditingController controller,
    required bool isEditing,
    required VoidCallback onEdit,
    required VoidCallback onSave,
    bool isPassword = false,
    bool showPassword = false,
    VoidCallback? onTogglePassword,
  }) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          Row(
            children: [
              Expanded(
                child: isEditing
                    ? TextField(
                  controller: controller,
                  obscureText: isPassword && !showPassword,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xffF1F1F1),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: isPassword
                        ? IconButton(
                      icon: Icon(
                        showPassword ? Icons.visibility_off : Icons.visibility,
                        color: const Color(0xff62B6CB),
                      ),
                      onPressed: onTogglePassword,
                    )
                        : null,
                  ),
                )
                    : Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  decoration: BoxDecoration(
                    color: const Color(0xffF1F1F1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    isPassword && !showPassword
                        ? '•' * controller.text.length
                        : controller.text,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              IconButton(
                icon: Icon(isEditing ? Icons.check : Icons.edit),
                onPressed: () {
                  if (isEditing) {
                    onSave();
                    _saveUserData(); // ← نحفظ التغيير فقط عند الضغط على ✅
                  } else {
                    onEdit();
                  }
                },
                color: const Color(0xff62B6CB),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account Info.', style: TextStyle(color: Color(0xff1B4965), fontWeight: FontWeight.bold)),
        elevation: 0,
        leading: const BackButton(color: Color(0xff1B4965)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Center(
              child: CircleAvatar(
                radius: 70,
                backgroundImage: _selectedImage != null
                    ? FileImage(_selectedImage!)
                    : const AssetImage("assets/images/driver.jpg") as ImageProvider,
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.file_download_outlined),
                    color: const Color(0xff62B6CB),
                    onPressed: _showUploadDialog,
                  ),
                  const Text(
                    'Upload new photo',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Color(0xff1B4965)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            buildEditableField(
              label: "Name",
              controller: nameController,
              isEditing: isNameEditing,
              onEdit: () => setState(() => isNameEditing = true),
              onSave: () => setState(() => isNameEditing = false),
            ),
            buildEditableField(
              label: "Phone Number",
              controller: phoneController,
              isEditing: isPhoneEditing,
              onEdit: () => setState(() => isPhoneEditing = true),
              onSave: () => setState(() => isPhoneEditing = false),
            ),
            buildEditableField(
              label: "Password",
              controller: passwordController,
              isEditing: isPasswordEditing,
              isPassword: true,
              showPassword: showPassword,
              onTogglePassword: () => setState(() => showPassword = !showPassword),
              onEdit: () => setState(() => isPasswordEditing = true),
              onSave: () => setState(() => isPasswordEditing = false),
            ),
          ],
        ),
      ),
    );
  }
}
