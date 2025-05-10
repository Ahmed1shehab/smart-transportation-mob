import 'dart:async';
import 'dart:io';
import 'package:smart_transportation/domain/usecase/create_organizer_usecase.dart';
import 'package:smart_transportation/presentation/base/baseviewmodel.dart';
import 'package:smart_transportation/presentation/common/freezed_data_classes.dart';
import 'package:smart_transportation/presentation/common/state_renderer/state_rendered.dart';
import 'package:smart_transportation/presentation/common/state_renderer/state_rendered_impl.dart';
import 'package:smart_transportation/presentation/resources/strings_manager.dart';

class OrganizationDetailsViewmodel extends BaseViewModel
    implements
        OrganizationDetailsViewmodelInputs,
        OrganizationDetailsViewmodelOutputs {
  // Stream controllers for each input field
  final StreamController<String> _organizationNameStreamController =
      StreamController<String>.broadcast();
  final StreamController<String> _organizationTypeStreamController =
      StreamController<String>.broadcast();
  final StreamController<String> _phoneNumberStreamController =
      StreamController<String>.broadcast();
  final StreamController<String> _descriptionStreamController =
      StreamController<String>.broadcast();
  final StreamController<File> _imageStreamController =
      StreamController<File>.broadcast(); // Changed from MultipartFile to File
  final StreamController<String> _streetStreamController =
      StreamController<String>.broadcast();
  final StreamController<String> _cityStreamController =
      StreamController<String>.broadcast();
  final StreamController<String> _stateStreamController =
      StreamController<String>.broadcast();
  final StreamController<String> _postalCodeStreamController =
      StreamController<String>.broadcast();
  final StreamController<bool> _areAllInputsValidStreamController =
      StreamController<bool>.broadcast();
  final StreamController<bool> _isOrganizationCreatedSuccessfullyController =
      StreamController<bool>.broadcast();
  final StreamController<String?> _imagePathController =
      StreamController<String?>.broadcast();

  // Data object holding all form values
  CreateOrganizerObject createOrganizerObject = CreateOrganizerObject(
    "",
    "",
    "",
    "",
    File(""),
    "",
    "",
    "",
    "",
  );

  final CreateOrganizerUsecase _createOrganizerUsecase;

  OrganizationDetailsViewmodel(this._createOrganizerUsecase);

  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  void dispose() {
    _organizationNameStreamController.close();
    _organizationTypeStreamController.close();
    _phoneNumberStreamController.close();
    _descriptionStreamController.close();
    _imageStreamController.close();
    _streetStreamController.close();
    _cityStreamController.close();
    _stateStreamController.close();
    _postalCodeStreamController.close();
    _areAllInputsValidStreamController.close();
    _isOrganizationCreatedSuccessfullyController.close();
    _imagePathController.close();
    super.dispose();
  }

  @override
  Future<void> createOrganizer() async {
    if (!_areAllInputsValid()) {
      inputState.add(ErrorState(StateRendererType.popUpErrorState,
          "Please fill all required fields correctly"));
      return;
    }

    inputState.add(
        LoadingState(stateRendererType: StateRendererType.popUpLoadingState));

    final result = await _createOrganizerUsecase.execute(
      CreateOrganizerInput(
        name: createOrganizerObject.name,
        type: createOrganizerObject.type,
        phoneNumber: createOrganizerObject.phoneNumber,
        description: createOrganizerObject.description,
        imageFile: createOrganizerObject.image,
        street: createOrganizerObject.street,
        city: createOrganizerObject.city,
        state: createOrganizerObject.state,
        postalCode: createOrganizerObject.postalCode,
      ),
    );

    result.fold(
      (failure) {
        inputState.add(
            ErrorState(StateRendererType.popUpErrorState, failure.message));
      },
      (organizer) {
        inputState.add(ContentState());
        _isOrganizationCreatedSuccessfullyController.add(true);
      },
    );
  }

  // Inputs
  @override
  Sink get inputOrganizationName => _organizationNameStreamController.sink;

  @override
  Sink get inputOrganizationType => _organizationTypeStreamController.sink;

  @override
  Sink get inputPhoneNumber => _phoneNumberStreamController.sink;

  @override
  Sink get inputDescription => _descriptionStreamController.sink;

  @override
  Sink get inputImage => _imageStreamController.sink;

  @override
  Sink get inputStreet => _streetStreamController.sink;

  @override
  Sink get inputCity => _cityStreamController.sink;

  @override
  Sink get inputPostalCode => _postalCodeStreamController.sink;

  @override
  Sink get inputAreAllInputsValid => _areAllInputsValidStreamController.sink;

  // Outputs
  @override
  Stream<bool> get outputAreAllInputsValid =>
      _areAllInputsValidStreamController.stream
          .map((_) => _areAllInputsValid());

  @override
  Stream<String> get outputOrganizationName =>
      _organizationNameStreamController.stream;

  @override
  Stream<String> get outputOrganizationType =>
      _organizationTypeStreamController.stream;

  @override
  Stream<String> get outputPhoneNumber => _phoneNumberStreamController.stream;

  @override
  Stream<String> get outputDescription => _descriptionStreamController.stream;

  @override
  Stream<File> get outputImage => _imageStreamController.stream;

  @override
  Stream<String> get outputStreet => _streetStreamController.stream;

  @override
  Stream<String> get outputCity => _cityStreamController.stream;

  @override
  Stream<String> get outputPostalCode => _postalCodeStreamController.stream;

  @override
  Stream<bool> get isOrganizationCreatedSuccessfullyStream =>
      _isOrganizationCreatedSuccessfullyController.stream;

  @override
  Stream<String?> get outputErrorOrganizationName =>
      _organizationNameStreamController.stream.map((name) {
        if (name.isEmpty) return AppStrings.organizationNameEmpty;
        if (name.length < 3) return AppStrings.organizationNameTooShort;
        return null;
      });

  @override
  Stream<String?> get outputErrorOrganizationType =>
      _organizationTypeStreamController.stream.map((type) {
        if (type.isEmpty) return AppStrings.organizationTypeEmpty;
        return null;
      });

  @override
  Stream<String?> get outputErrorPhoneNumber =>
      _phoneNumberStreamController.stream.map((phoneNumber) {
        if (phoneNumber.isEmpty) return AppStrings.phoneNumberEmpty;
        if (!RegExp(r'^\+?[0-9]{10,15}$').hasMatch(phoneNumber)) {
          return AppStrings.phoneNumberInvalid;
        }
        return null;
      });

  @override
  Stream<String?> get outputErrorDescription =>
      _descriptionStreamController.stream.map((description) {
        if (description.isEmpty) return AppStrings.descriptionEmpty;
        if (description.length < 20) return AppStrings.descriptionTooShort;
        return null;
      });

  @override
  Stream<String?> get outputImagePath => _imagePathController.stream;

  // Setters
  @override
  setOrganizationName(String name) {
    inputOrganizationName.add(name);
    createOrganizerObject = createOrganizerObject.copyWith(name: name);
    _validate();
  }

  @override
  setType(String type) {
    inputOrganizationType.add(type);
    createOrganizerObject = createOrganizerObject.copyWith(type: type);
    _validate();
  }

  @override
  setPhoneNumber(String phoneNumber) {
    inputPhoneNumber.add(phoneNumber);
    createOrganizerObject =
        createOrganizerObject.copyWith(phoneNumber: phoneNumber);
    _validate();
  }

  @override
  setDescription(String description) {
    inputDescription.add(description);
    createOrganizerObject =
        createOrganizerObject.copyWith(description: description);
    _validate();
  }

  @override
  setImage(File image) {
    inputImage.add(image);
    createOrganizerObject = createOrganizerObject.copyWith(image: image);
    _validate();
  }

  @override
  setStreet(String street) {
    inputStreet.add(street);
    createOrganizerObject = createOrganizerObject.copyWith(street: street);
    _validate();
  }

  @override
  setCity(String city) {
    inputCity.add(city);
    createOrganizerObject = createOrganizerObject.copyWith(city: city);
    _validate();
  }

  @override
  setPostalCode(String postalCode) {
    inputPostalCode.add(postalCode);
    createOrganizerObject =
        createOrganizerObject.copyWith(postalCode: postalCode);
    _validate();
  }

  void setImagePath(String? path) {
    _imagePathController.add(path);
  }

  // Private methods
  bool _areAllInputsValid() {
    return createOrganizerObject.name.isNotEmpty &&
        createOrganizerObject.type.isNotEmpty &&
        createOrganizerObject.phoneNumber.isNotEmpty &&
        createOrganizerObject.description.isNotEmpty &&
        createOrganizerObject.image.path.isNotEmpty &&
        createOrganizerObject.street.isNotEmpty &&
        createOrganizerObject.city.isNotEmpty &&
        createOrganizerObject.state.isNotEmpty &&
        createOrganizerObject.postalCode.isNotEmpty;
  }

  void _validate() {
    inputAreAllInputsValid.add(_areAllInputsValid());
  }

  @override
  void setState(String state) {
    _stateStreamController.add(state);
    createOrganizerObject = createOrganizerObject.copyWith(state: state);
    _validate();
  }
}

abstract class OrganizationDetailsViewmodelInputs {
  void setOrganizationName(String organizationName);

  void setType(String organizationType);

  void setPhoneNumber(String phoneNumber);

  void setDescription(String description);

  void setImage(File image);

  void setStreet(String street);

  void setCity(String city);

  void setState(String state);

  void setPostalCode(String postalCode);

  Future<void> createOrganizer();

  Sink get inputOrganizationName;

  Sink get inputOrganizationType;

  Sink get inputPhoneNumber;

  Sink get inputDescription;

  Sink get inputImage;

  Sink get inputStreet;

  Sink get inputCity;

  Sink get inputPostalCode;

  Sink get inputAreAllInputsValid;

  Sink<FlowState> get inputState;
}

abstract class OrganizationDetailsViewmodelOutputs {
  Stream<String> get outputOrganizationName;

  Stream<String?> get outputErrorOrganizationName;

  Stream<String> get outputOrganizationType;

  Stream<String?> get outputErrorOrganizationType;

  Stream<String> get outputPhoneNumber;

  Stream<String?> get outputErrorPhoneNumber;

  Stream<String> get outputDescription;

  Stream<String?> get outputErrorDescription;

  Stream<File> get outputImage;

  Stream<String> get outputStreet;

  Stream<String> get outputCity;

  Stream<String> get outputPostalCode;

  Stream<bool> get outputAreAllInputsValid;

  Stream<bool> get isOrganizationCreatedSuccessfullyStream;

  Stream<String?> get outputImagePath;

  Stream<FlowState> get outputState; // Add this lin
}
