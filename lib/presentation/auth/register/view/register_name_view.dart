import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_transportation/presentation/auth/register/viewmodel/register_viewmodel.dart';
import 'package:smart_transportation/presentation/auth/register/widgets/already_have_account_widget.dart';
import 'package:smart_transportation/presentation/common/widgets/background_image.dart';
import 'package:smart_transportation/presentation/resources/asset_manager.dart';
import 'package:smart_transportation/presentation/resources/color_manager.dart';
import 'package:smart_transportation/presentation/resources/strings_manager.dart';
import 'package:smart_transportation/presentation/resources/values_manager.dart';

import '../../../common/widgets/auth/register_custom_text_field.dart';

class RegisterNameScreen extends StatefulWidget {
  final RegisterViewModel viewModel;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final GlobalKey<FormState> formKey;
  final VoidCallback onNext;

  const RegisterNameScreen({
    Key? key,
    required this.viewModel,
    required this.firstNameController,
    required this.lastNameController,
    required this.formKey,
    required this.onNext,
  }) : super(key: key);

  @override
  State<RegisterNameScreen> createState() => _RegisterNameScreenState();
}

class _RegisterNameScreenState extends State<RegisterNameScreen> {
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      setState(() {
        _profileImage = File(image.path);
        widget.viewModel.setProfilePicture(_profileImage);
      });
    }
  }

  void _showImageSourceDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text(AppStrings.gallery),
                  onTap: () {
                    _pickImage(ImageSource.gallery);
                    Navigator.of(context).pop();
                  }),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text(AppStrings.camera),
                onTap: () {
                  _pickImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( // Changed Stack to Scaffold
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Default back navigation
          },
        ),
      ),
      extendBodyBehindAppBar: true, // Make body extend behind app bar
      body: Stack(
        children: [
          const BackgroundImage(),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(AppPadding.p16),
              child: Form(
                key: widget.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        height: MediaQuery.of(context).size.width * AppSize.s0_5),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: AppSize.s24, top: AppSize.s24),
                      child: Text(
                        AppStrings.step1PersonalData,
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppHeight.h28, vertical: AppSize.s24),
                        child: Image.asset(
                          ImageAssets.step1,
                        )),
                    const SizedBox(height: AppPadding.p12),
                    Center(
                      child: GestureDetector(
                        onTap: () => _showImageSourceDialog(context),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(AppSize.s12),
                            border: Border.all(
                                color: ColorManager.borderColorOrg,
                                width: AppSize.s2),
                          ),
                          padding: const EdgeInsets.all(AppPadding.p16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                AppStrings.uploadYourPhoto,
                                style: Theme.of(context).textTheme.headlineMedium,
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: AppSize.s8),
                              Container(
                                width: double.infinity,
                                height: AppSize.s100,
                                decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.circular(AppSize.s12),
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Theme.of(context).primaryColor,
                                      width: AppSize.s1_5),
                                ),
                                child: _profileImage != null
                                    ? ClipRRect(
                                  borderRadius:
                                  BorderRadius.circular(AppSize.s12),
                                  child: Image.file(
                                    _profileImage!,
                                    width: double.infinity,
                                    height: AppSize.s150,
                                    fit: BoxFit.cover,
                                  ),
                                )
                                    : Center(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.image,
                                          size: AppSize.s40,
                                          color: ColorManager.primary2),
                                      const SizedBox(height: AppSize.s4),
                                      Text(
                                        AppStrings.selectPhoto,
                                        style: TextStyle(
                                          fontSize: AppSize.s14,
                                          color: ColorManager.primary2,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: AppPadding.p28),
                    buildTextField(
                      context,
                      controller: widget.firstNameController,
                      labelText: AppStrings.firstName,
                      hintText: AppStrings.firstNameHint,
                      validationStream: widget.viewModel.outputIsFirstNameValid,
                      errorStream: widget.viewModel.outputErrorFirstName,
                      keyboardType: TextInputType.name,
                    ),
                    const SizedBox(height: AppPadding.p28),
                    buildTextField(
                      context,
                      controller: widget.lastNameController,
                      labelText: AppStrings.lastName,
                      hintText: AppStrings.lastNameHint,
                      validationStream: widget.viewModel.outputIsLastNameValid,
                      errorStream: widget.viewModel.outputErrorLastName,
                      keyboardType: TextInputType.name,
                    ),
                    const SizedBox(height: AppPadding.p40),
                    StreamBuilder<bool>(
                      stream: widget.viewModel.outputIsNameValid,
                      builder: (context, snapshot) {
                        final isImageSelected = _profileImage != null;
                        return SizedBox(
                          width: double.infinity,
                          height: AppSize.s43,
                          child: ElevatedButton(
                            onPressed: snapshot.data == true && isImageSelected
                                ? widget.onNext
                                : null,
                            child: const Text(
                              AppStrings.next,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      },
                    ),
                    const AlreadyHaveAccountWidget(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}