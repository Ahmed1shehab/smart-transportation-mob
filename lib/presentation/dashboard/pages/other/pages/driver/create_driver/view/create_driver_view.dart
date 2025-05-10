import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rxdart/rxdart.dart';
import 'package:smart_transportation/app/app_prefs.dart';
import 'package:smart_transportation/app/di.dart';
import 'package:smart_transportation/presentation/common/state_renderer/state_rendered.dart';
import 'package:smart_transportation/presentation/common/state_renderer/state_rendered_impl.dart'; // Import StateRenderer
import 'package:smart_transportation/presentation/dashboard/pages/other/pages/driver/create_driver/viewmodel/create_driver_viewmodel.dart';
import 'package:smart_transportation/presentation/resources/color_manager.dart'; // Import color manager
import 'package:smart_transportation/presentation/resources/route_manager.dart';
import 'package:smart_transportation/presentation/resources/strings_manager.dart'; // Import strings manager
import 'package:smart_transportation/presentation/resources/styles_manager.dart'; // Import styles manager
import 'package:smart_transportation/presentation/resources/values_manager.dart';
import 'package:intl/intl.dart'; // Import the intl package

class CreateDriverView extends StatefulWidget {
  const CreateDriverView({Key? key}) : super(key: key);

  @override
  _CreateDriverViewState createState() => _CreateDriverViewState();
}

class _CreateDriverViewState extends State<CreateDriverView> {
  final _formKey = GlobalKey<FormState>();
  final _viewModel = instance<
      CreateDiverViewModel>(); // Initialize your ViewModel using dependency injection
  final _imagePicker = ImagePicker();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _organizationIdController =
      TextEditingController();
  final TextEditingController _licenseInfoController = TextEditingController();
  final dateFormat = DateFormat("yyyy-MM-dd"); // Date formatter
  DateTime? _selectedLicenseDate;
  File? _selectedImage;

  // Function to show a date picker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedLicenseDate) {
      _selectedLicenseDate = picked;
      _viewModel.setLicenseDate(picked); // Update the ViewModel
    }
  }

  // Function to select image
  Future<void> _pickImage() async {
    final pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _selectedImage = File(pickedFile.path);
      _viewModel.setImage(_selectedImage!); // Update the ViewModel
    }
  }

  @override
  void initState() {
    super.initState();
// Start the ViewModel
    _bind();
  }

  @override
  void dispose() {
    _viewModel.dispose(); // Dispose the ViewModel
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _passwordController.dispose();
    _organizationIdController.dispose();
    _licenseInfoController.dispose();
    super.dispose();
  }

  void _bind() {
    _viewModel.start();

    // Schedule owner ID fetch after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _viewModel.getActiveOwnerId().then((ownerId) {
        if (ownerId != null && mounted) {
          _organizationIdController.text = ownerId;
          _viewModel.setOrganizationId(ownerId);
        }
      });
    });

    _firstNameController.addListener(() {
      _viewModel.setFirstName(_firstNameController.text);
    });

    _lastNameController.addListener(() {
      _viewModel.setLastName(_lastNameController.text);
    });

    _emailController.addListener(() {
      _viewModel.setEmail(_emailController.text);
    });

    _phoneNumberController.addListener(() {
      _viewModel.setPhoneNumber(_phoneNumberController.text);
    });

    _passwordController.addListener(() {
      _viewModel.setPassword(_passwordController.text);
    });

    _organizationIdController.addListener(() {
      _viewModel.setOrganizationId(_organizationIdController.text);
    });

    _licenseInfoController.addListener(() {
      _viewModel.setLicenseInfo(_licenseInfoController.text);
    });

    /// Listen for state changes
    _viewModel.outputState.listen((flowState) {
      if (mounted) {
        setState(() {});
      }
    });

    /// Listen for registration success and navigate to dashboard
    _viewModel.outputIsDriverRegisteredSuccessfully.listen((isRegistered) {
      if (isRegistered && mounted) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.pushReplacementNamed(context, Routes.dashboard);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        title: const Text(AppStrings.createDriver),
        backgroundColor: ColorManager.primary,
      ),
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
          return _getContentWidget();
        },
      ),
    );
  }

  Widget _getContentWidget() {
    return Container(
      padding: const EdgeInsets.all(AppPadding.p20),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Picture
              StreamBuilder<File?>(
                stream: _viewModel.outputImage,
                builder: (context, snapshot) {
                  return Center(
                    child: Stack(
                      children: [
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: ColorManager.primary,
                              width: 2,
                            ),
                            // If there is an image show it, otherwise show a placeholder
                            image: _selectedImage != null
                                ? DecorationImage(
                                    image: FileImage(_selectedImage!),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                          ),
                          // Show a default icon if no image is selected.
                          child: _selectedImage == null
                              ? Icon(
                                  Icons.person,
                                  size: 60,
                                  color: ColorManager.primary,
                                )
                              : null, // Don't show icon if image exists.
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: _pickImage,
                            child: Container(
                              decoration: BoxDecoration(
                                color: ColorManager.primary,
                                shape: BoxShape.circle,
                              ),
                              padding: const EdgeInsets.all(8),
                              child: Icon(
                                Icons.camera_alt,
                                color: ColorManager.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: AppSize.s20),

              // First Name
              StreamBuilder<String?>(
                stream: _viewModel.outputFirstNameError,
                builder: (context, snapshot) {
                  return TextFormField(
                    controller: _firstNameController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      labelText: AppStrings.firstName,
                      errorText: snapshot.data,
                    ),
                    onChanged: _viewModel.setFirstName,
                  );
                },
              ),
              const SizedBox(height: AppSize.s16),

              // Last Name
              StreamBuilder<String?>(
                stream: _viewModel.outputLastNameError,
                builder: (context, snapshot) {
                  return TextFormField(
                    controller: _lastNameController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      labelText: AppStrings.lastName,
                      errorText: snapshot.data,
                    ),
                    onChanged: _viewModel.setLastName,
                  );
                },
              ),
              const SizedBox(height: AppSize.s16),

              // Email
              StreamBuilder<String?>(
                stream: _viewModel.outputEmailError,
                builder: (context, snapshot) {
                  return TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: AppStrings.email,
                      errorText: snapshot.data,
                    ),
                    onChanged: _viewModel.setEmail,
                  );
                },
              ),
              const SizedBox(height: AppSize.s16),

              // Phone Number
              StreamBuilder<String?>(
                stream: _viewModel.outputPhoneNumberError,
                builder: (context, snapshot) {
                  return TextFormField(
                    controller: _phoneNumberController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: AppStrings.phoneNumber,
                      errorText: snapshot.data,
                    ),
                    onChanged: _viewModel.setPhoneNumber,
                  );
                },
              ),
              const SizedBox(height: AppSize.s16),

              // Password
              StreamBuilder<String?>(
                stream: _viewModel.outputPasswordError,
                builder: (context, snapshot) {
                  return TextFormField(
                    controller: _passwordController,
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: AppStrings.password,
                      errorText: snapshot.data,
                    ),
                    onChanged: _viewModel.setPassword,
                  );
                },
              ),
              const SizedBox(height: AppSize.s16),

              // Organization ID
              StreamBuilder<String?>(
                stream: _viewModel.outputOrganizationIdError,
                builder: (context, snapshot) {
                  return AbsorbPointer(
                    absorbing: true, // This prevents all pointer interactions
                    child: TextFormField(
                      controller: _organizationIdController,
                      keyboardType: TextInputType.text,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: AppStrings.organizationId,
                        errorText: snapshot.data,
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                      // Remove any onTap callbacks if present
                    ),
                  );
                },
              ),
              const SizedBox(height: AppSize.s16),

              // License Info
              StreamBuilder<String?>(
                stream: _viewModel.outputLicenseInfoError,
                builder: (context, snapshot) {
                  return TextFormField(
                    controller: _licenseInfoController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: AppStrings.licenseInfo,
                      errorText: snapshot.data,
                    ),
                    onChanged: _viewModel.setLicenseInfo,
                  );
                },
              ),
              const SizedBox(height: AppSize.s16),

              // License Date
              // License Date
              StreamBuilder<String?>(
                stream: _viewModel.outputLicenseDateError,
                builder: (context, errorSnapshot) {
                  return StreamBuilder<DateTime?>(
                    stream: _viewModel.outputLicenseDate,
                    builder: (context, snapshot) {
                      return InkWell(
                        onTap: () => _selectDate(context),
                        child: InputDecorator(
                          decoration: InputDecoration(
                            labelText: AppStrings.licenseDate,
                            errorText: errorSnapshot.data,
                          ),
                          child: Text(
                            _selectedLicenseDate != null
                                ? dateFormat.format(_selectedLicenseDate!)
                                : AppStrings.selectDate,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),

              SizedBox(height: AppSize.s28),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() == true) {
                      _viewModel.register();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorManager.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSize.s8),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: AppPadding.p12), //make button taller
                  ),
                  child: Text(
                    AppStrings.register,
                    style: TextStyle(
                      color: ColorManager.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to show popup
  void showPopUp(
      BuildContext context, StateRendererType stateRendererType, String message,
      {String title = AppStrings.appName}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StateRenderer(
          stateRendererType: stateRendererType,
          message: message,
          title: title,
          retryActionFunction: () {
            // Retry Function
            if (stateRendererType == StateRendererType.popUpErrorState) {
              _viewModel.register();
            }
          },
        );
      },
    );
  }
}
