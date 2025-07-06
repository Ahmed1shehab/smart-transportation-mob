import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_transportation/app/constants.dart';
import 'package:smart_transportation/app/di.dart';
import 'package:smart_transportation/presentation/common/state_renderer/state_rendered_impl.dart';
import 'package:smart_transportation/presentation/on_boarding_organizer/viewmodel/organization_details_viewmodel.dart';
import 'package:smart_transportation/presentation/resources/color_manager.dart';
import 'package:smart_transportation/presentation/resources/route_manager.dart';
import 'package:smart_transportation/presentation/resources/strings_manager.dart';
import 'package:smart_transportation/presentation/resources/values_manager.dart';

import '../../resources/constants_manager.dart';
import '../../resources/font_manager.dart';

class OrganizationDetailsView extends StatefulWidget {
  const OrganizationDetailsView({super.key});

  @override
  State<OrganizationDetailsView> createState() =>
      _OrganizationDetailsViewState();
}

class _OrganizationDetailsViewState extends State<OrganizationDetailsView> {
  late OrganizationDetailsViewmodel _viewModel;
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _postalController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _viewModel = instance<OrganizationDetailsViewmodel>();
    _bind();
    _listenToNavigationEvents();
  }

  void _bind() {
    _nameController.addListener(() {
      _viewModel.setOrganizationName(_nameController.text);
    });
    _typeController.addListener(() {
      _viewModel.setType(_typeController.text);
    });
    _phoneController.addListener(() {
      _viewModel.setPhoneNumber(_phoneController.text);
    });
    _descController.addListener(() {
      _viewModel.setDescription(_descController.text);
    });
    _streetController.addListener(() {
      _viewModel.setStreet(_streetController.text);
    });
    _cityController.addListener(() {
      _viewModel.setCity(_cityController.text);
    });
    _stateController.addListener(() {
      _viewModel.setState(_stateController.text);
    });
    _postalController.addListener(() {
      _viewModel.setPostalCode(_postalController.text);
    });
  }

  void _listenToNavigationEvents() {
    _viewModel.isOrganizationCreatedSuccessfullyStream.listen((isSuccess) {
      if (isSuccess) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          debugPrint('[LoginView] Navigating to Main');
        
          Navigator.of(context).pushReplacementNamed(Routes.dashboard);
        });
      }
    });
  }

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: AppHeight.h800,
        maxHeight: AppHeight.h800,
        imageQuality: AppConstants.eightyFive,
      );

      if (image != null) {
        final file = File(image.path);
        final sizeInBytes = await file.length();
        final sizeInMb = sizeInBytes / (AppConstants.imageRatio * AppConstants.imageRatio);

        if (sizeInMb > AppConstants.five) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text(AppStrings.imageSizeShouldBe)),
          );
          return;
        }

        _viewModel.setImage(file);
        _viewModel.setImagePath(image.path);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('$AppStrings.failedToPickImage ${e.toString()}')),
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _typeController.dispose();
    _phoneController.dispose();
    _descController.dispose();
    _streetController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _postalController.dispose();
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.white,
        elevation: Constants.zeroDouble,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: ColorManager.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          AppStrings.orgDetails,
          style: Theme.of(context).textTheme.labelLarge,
        ),
        centerTitle: false,
      ),
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
          return snapshot.data?.getScreenWidget(context, _buildContent(), () {
                _viewModel.createOrganizer();
              }) ??
              _buildContent();
        },
      ),
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p12),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppSize.s12),
          border:
              Border.all(color: ColorManager.borderColorOrg, width: AppSize.s2),
        ),
        padding: const EdgeInsets.all(AppPadding.p16),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Organization Logo
                StreamBuilder<String?>(
                  stream: _viewModel.outputImagePath,
                  builder: (context, snapshot) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppPadding.p18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.uploadYourLogo,
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          const SizedBox(height: AppSize.s8),
                          // Clickable Logo Container
                          GestureDetector(
                            onTap: _pickImage,
                            child: Container(
                              width: double.infinity,
                              height: AppSize.s180,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(AppSize.s12),
                                color: Colors.white,
                                border: Border.all(
                                    color: Theme.of(context).primaryColor,
                                    width: AppSize.s1_5),
                              ),
                              child: snapshot.hasData && snapshot.data != null
                                  ? ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(AppSize.s12),
                                      child: Image.file(
                                        File(snapshot.data!),
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
                          ),
                        ],
                      ),
                    );
                  },
                ),

                const SizedBox(height: AppHeight.h70),

                // Organization Info Section
                Padding(
                    padding: const EdgeInsets.only(left: AppConstants.ten, bottom: AppConstants.five,),
                    child: Text(
                      '${AppStrings.organizationName} :',
                      style: Theme.of(context).textTheme.titleSmall,
                    )),
                _buildTextFormField(
                  controller: _nameController,
                  label: AppStrings.organizationName,
                  stream: _viewModel.outputErrorOrganizationName,
                ),
                Padding(
                    padding:const EdgeInsets.only(left: AppConstants.ten, bottom: AppConstants.five,),
                    child: Text(
                      '${AppStrings.organizationType} :',
                      style: Theme.of(context).textTheme.titleSmall,
                    )),
                _buildTextFormField(
                  controller: _typeController,
                  label: AppStrings.organizationType,
                  stream: _viewModel.outputErrorOrganizationType,
                ),
                Padding(
                    padding:const EdgeInsets.only(left: AppConstants.ten, bottom: AppConstants.five,),
                    child: Text(
                      '${AppStrings.phoneNumber} :',
                      style: Theme.of(context).textTheme.titleSmall,
                    )),
                _buildTextFormField(
                  controller: _phoneController,
                  label: AppStrings.phoneNumber,
                  keyboardType: TextInputType.phone,
                  stream: _viewModel.outputErrorPhoneNumber,
                ),
                Padding(
                    padding: const EdgeInsets.only(left: AppConstants.ten, bottom: AppConstants.five,),
                    child: Text(
                      '${AppStrings.descriptionOfService} :',
                      style: Theme.of(context).textTheme.titleSmall,
                    )),
                _buildTextFormField(
                  controller: _descController,
                  label: AppStrings.descriptionOfService,
                  maxLines: 3,
                  stream: _viewModel.outputErrorDescription,
                ),

                // Address Section
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: AppSize.s16),
                  child: Text(AppStrings.addressInformation,
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(color: ColorManager.darkGrey)),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: AppConstants.ten, bottom: AppConstants.five,),
                  child: Text(
                    "${AppStrings.streetAddress} :",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                _buildTextFormField(
                  controller: _streetController,
                  label: AppStrings.streetAddress,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: AppConstants.ten, bottom: AppConstants.five, top: AppConstants.ten),
                  child: Text(
                    "${AppStrings.city} :",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                _buildTextFormField(
                  controller: _cityController,
                  label: AppStrings.city,
                ),
                Padding(
                  padding:const EdgeInsets.only(left: AppConstants.ten, bottom: AppConstants.five, top: AppConstants.ten),
                  child: Text(
                    "${AppStrings.state} :",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                _buildTextFormField(
                  controller: _stateController,
                  label: AppStrings.state,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: AppConstants.ten, bottom: AppConstants.five, top: AppConstants.ten),
                  child: Text(
                    "${AppStrings.postalCode} :",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                _buildTextFormField(
                  controller: _postalController,
                  label: AppStrings.postalCode,
                  keyboardType: TextInputType.number,
                ),

// Submit Button
                const SizedBox(height: AppSize.s30),
                StreamBuilder<bool>(
                  stream: _viewModel.outputAreAllInputsValid,
                  builder: (context, snapshot) {
                    return ElevatedButton(
                      onPressed: (snapshot.data ?? false)
                          ? () {
                              if (_formKey.currentState!.validate()) {
                                _viewModel.createOrganizer();
                              }
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: AppSize.s16),
                        backgroundColor: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppConstants.eight),
                        ),
                      ),
                      child: const Text(
                        AppStrings.createOrganization,
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  },
                ),

// Success Message (Optional - you might want to remove this since we're navigating away)
                StreamBuilder<bool>(
                  stream: _viewModel.isOrganizationCreatedSuccessfullyStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data!) {
                      return const Padding(
                        padding:  EdgeInsets.only(top: AppConstants.ten),
                        child: Text(
                          AppStrings.organizationSuccess,
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: FontSize.s16,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String label,
    TextInputType? keyboardType,
    int? maxLines = AppConstants.one,
    Stream<String?>? stream,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppPadding.p16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: controller,
            decoration: InputDecoration(
              labelText: label,
              labelStyle: TextStyle(
                color: ColorManager.primary2,
                fontSize: AppSize.s16,
              ),
              floatingLabelStyle: TextStyle(
                color: ColorManager.primary2,
                fontSize: AppSize.s0, // Hide when active
              ),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSize.s10),
                borderSide: BorderSide(color: ColorManager.primary),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSize.s10),
                borderSide: BorderSide(color: ColorManager.primary),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSize.s10),
                borderSide: BorderSide(
                    color: ColorManager.primary2, width: AppSize.s1_2),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSize.s10),
                borderSide: const BorderSide(color: Colors.red),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSize.s10),
                borderSide: const BorderSide(color: Colors.red),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppPadding.p16,
                vertical: AppPadding.p14,
              ),
            ),
            keyboardType: keyboardType,
            maxLines: maxLines,
            style: const TextStyle(fontSize: AppSize.s16),
          ),
          if (stream != null)
            StreamBuilder<String?>(
              stream: stream,
              builder: (context, snapshot) {
                return snapshot.hasData
                    ? Padding(
                        padding: const EdgeInsets.only(top: AppPadding.p4),
                        child: Text(
                          snapshot.data ?? Constants.empty,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: AppSize.s12,
                          ),
                        ),
                      )
                    : const SizedBox();
              },
            ),
        ],
      ),
    );
  }
}