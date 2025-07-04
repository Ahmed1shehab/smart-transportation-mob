import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../presentation/resources/color_manager.dart';
import '../../presentation/resources/font_manager.dart';
import '../../presentation/account_info/account_info_viewmodel.dart';

class AccountInfo extends StatelessWidget {
  const AccountInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<AccountInfoViewModel>(context, listen: false);

    return FutureBuilder(
      future: viewModel.init(),
      builder: (context, snapshot) {
        return _buildUI(context, viewModel);
      },
    );
  }

  Widget _buildUI(BuildContext context, AccountInfoViewModel viewModel) {
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
          'Account Info',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeightManager.semiBold,
            fontSize: 22.0,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.mic_none_outlined, color: Colors.black),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),

              /// Profile Picture
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 140,
                      height: 140,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: viewModel.pickedImage != null
                              ? FileImage(viewModel.pickedImage!) as ImageProvider
                              : const AssetImage('assets/images/supervisor/Reem.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextButton.icon(
                      onPressed: () {
                        viewModel.pickImage(context);
                      },
                      icon: const Icon(Icons.upload, size: 20, color: Colors.black),
                      label: const Text(
                        'Upload new photo',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeightManager.semiBold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              /// Form Fields
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    fieldTitle('Name:'),
                    const SizedBox(height: 15),
                    disabledField(viewModel.userName),

                    const SizedBox(height: 20),
                    fieldTitle('Phone Number:'),
                    const SizedBox(height: 15),
                    disabledField(viewModel.phoneNumber),

                    const SizedBox(height: 20),
                    fieldTitle('E-mail:'),
                    const SizedBox(height: 15),
                    disabledField(viewModel.email),

                    const SizedBox(height: 20),
                    fieldTitle('Password:'),
                    const SizedBox(height: 15),
                    passwordField(viewModel),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget fieldTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 16,
        color: ColorManager.dark_blue,
        fontWeight: FontWeightManager.semiBold,
        letterSpacing: 1,
      ),
    );
  }

  Widget disabledField(String value) {
    return TextFormField(
      initialValue: value,
      enabled: false,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeightManager.regular,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[200],
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }

  Widget passwordField(AccountInfoViewModel viewModel) {
    return TextFormField(
      initialValue: viewModel.password,
      obscureText: viewModel.obscurePassword,
      readOnly: true,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeightManager.regular,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        suffixIcon: IconButton(
          onPressed: viewModel.togglePasswordVisibility,
          icon: Icon(
            viewModel.obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
            color: Colors.black,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }
}
