import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_transportation/app/constants.dart';
import 'package:smart_transportation/app/di.dart';
import 'package:smart_transportation/presentation/common/state_renderer/state_rendered_impl.dart';
import 'package:smart_transportation/presentation/dashboard/pages/other/pages/new_organization/viewmodel/new_organization_viewmodel.dart';
import 'package:smart_transportation/presentation/resources/color_manager.dart';
import 'package:smart_transportation/presentation/resources/constants_manager.dart';
import 'package:smart_transportation/presentation/resources/strings_manager.dart';
import 'package:smart_transportation/presentation/resources/values_manager.dart';
import 'package:smart_transportation/presentation/resources/font_manager.dart';

class NewOrganizationView extends StatefulWidget {
  const NewOrganizationView({Key? key}) : super(key: key);

  @override
  State<NewOrganizationView> createState() => _NewOrganizationViewState();
}

class _NewOrganizationViewState extends State<NewOrganizationView> {
  final NewOrganizationViewmodel _viewModel = instance<NewOrganizationViewmodel>();
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _addressIdController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _bind();
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
    _addressIdController.addListener(() {
      _viewModel.inputAddressId.add(_addressIdController.text);
    });
  }

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: AppConstants.maxImageWidth,
        maxHeight: AppConstants.maxImageHeight,
        imageQuality: AppConstants.imageQuality,
      );

      if (image != null) {
        final file = File(image.path);
        final sizeInBytes = await file.length();
        final sizeInMb = sizeInBytes / (1024 * 1024);

        if (sizeInMb > AppConstants.maxImageSizeMB) {
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
        SnackBar(content: Text('${AppStrings.failedToPickImage} ${e.toString()}')),
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _typeController.dispose();
    _phoneController.dispose();
    _descController.dispose();
    _addressIdController.dispose();
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.createNewOrganization),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
          return snapshot.data?.getScreenWidget(
            context,
            _buildContent(),
            () => _viewModel.createOrganizer(),
          ) ?? _buildContent();
        },
      ),
    );
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppPadding.p16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Organization Logo Section
            _buildLogoSection(),
            const SizedBox(height: AppSize.s24),

            // Organization Information Section
            Text(
              AppStrings.organizationInformation,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeightManager.bold,
                color: ColorManager.darkGrey,
              ),
            ),
            const SizedBox(height: AppSize.s12),

            _buildLabel(AppStrings.organizationName),
            _buildTextFormField(
              controller: _nameController,
              hintText: AppStrings.organizationName,
              errorStream: _viewModel.outputErrorOrganizationName,
            ),
            
            _buildLabel(AppStrings.organizationType),
            _buildTextFormField(
              controller: _typeController,
              hintText: AppStrings.organizationType,
              errorStream: _viewModel.outputErrorOrganizationType,
            ),
            
            _buildLabel(AppStrings.phoneNumber),
            _buildTextFormField(
              controller: _phoneController,
              hintText: AppStrings.phoneNumber,
              keyboardType: TextInputType.phone,
              errorStream: _viewModel.outputErrorPhoneNumber,
            ),
            
            _buildLabel(AppStrings.organizerDescription),
            _buildTextFormField(
              controller: _descController,
              hintText: AppStrings.organizerDescription,
              maxLines: 3,
              errorStream: _viewModel.outputErrorDescription,
            ),
            
            _buildLabel(AppStrings.addAddress),
            _buildTextFormField(
              controller: _addressIdController,
              hintText: AppStrings.enterAddressId,
            ),

            const SizedBox(height: AppSize.s32),

            // Submit Button
            _buildSubmitButton(),

            // Success Message
            _buildSuccessMessage(),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.uploadYourLogo,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeightManager.semiBold,
          ),
        ),
        const SizedBox(height: AppSize.s8),
        StreamBuilder<String?>(
          stream: _viewModel.outputImagePath,
          builder: (context, snapshot) {
            return GestureDetector(
              onTap: _pickImage,
              child: Container(
                height: AppSize.s150,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: ColorManager.grey,
                  borderRadius: BorderRadius.circular(AppSize.s12),
                  border: Border.all(
                    color: ColorManager.primary,
                    width: AppSize.s1,
                  ),
                ),
                child: snapshot.data != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(AppSize.s12),
                        child: Image.file(
                          File(snapshot.data!),
                          fit: BoxFit.cover,
                        ),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.camera_alt,
                            size: AppSize.s40,
                            color: ColorManager.primary,
                          ),
                          const SizedBox(height: AppSize.s8),
                          Text(
                            AppStrings.uploadYourLogo,
                            style: TextStyle(color: ColorManager.primary),
                          ),
                        ],
                      ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: AppPadding.p12, bottom: AppPadding.p4),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeightManager.medium,
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String hintText,
    TextInputType? keyboardType,
    int? maxLines = 1,
    Stream<String?>? errorStream,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSize.s8),
            ),
            contentPadding: const EdgeInsets.all(AppPadding.p12),
          ),
          keyboardType: keyboardType,
          maxLines: maxLines,
        ),
        if (errorStream != null)
          StreamBuilder<String?>(
            stream: errorStream,
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? Padding(
                      padding: const EdgeInsets.only(top: AppPadding.p4),
                      child: Text(
                        snapshot.data ?? '',
                        style: TextStyle(
                          color: ColorManager.red,
                          fontSize: FontSize.s12,
                        ),
                      ),
                    )
                  : const SizedBox();
            },
          ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return StreamBuilder<bool>(
      stream: _viewModel.outputAreAllInputsValid,
      builder: (context, snapshot) {
        return SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: (snapshot.data ?? false)
                ? () {
                    if (_formKey.currentState?.validate() ?? false) {
                      _viewModel.createOrganizer();
                    }
                  }
                : null,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: AppPadding.p16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSize.s8),
              ),
            ),
            child: Text(
              AppStrings.createOrganization,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: ColorManager.white,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSuccessMessage() {
    return StreamBuilder<bool>(
      stream: _viewModel.isOrganizationCreatedSuccessfullyStream,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data == true) {
          return Padding(
            padding: const EdgeInsets.only(top: AppPadding.p16),
            child: Text(
              AppStrings.organizationCreatedSuccessfully,
              style: TextStyle(
                color: ColorManager.primary,
                fontSize: FontSize.s14,
                fontWeight: FontWeightManager.medium,
              ),
              textAlign: TextAlign.center,
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}