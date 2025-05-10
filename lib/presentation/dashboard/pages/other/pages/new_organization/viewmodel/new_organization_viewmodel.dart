import 'dart:async';
import 'dart:io';

import 'package:rxdart/rxdart.dart';
import 'package:smart_transportation/data/network/requests.dart';
import 'package:smart_transportation/domain/usecase/create_new_organization.dart';
import 'package:smart_transportation/presentation/base/baseviewmodel.dart';
import 'package:smart_transportation/presentation/common/freezed_data_classes.dart';
import 'package:smart_transportation/presentation/common/state_renderer/state_rendered.dart';
import 'package:smart_transportation/presentation/common/state_renderer/state_rendered_impl.dart';


class NewOrganizationViewmodel extends BaseViewModel 
    implements OrganizationDetailsViewmodelInputs, OrganizationDetailsViewmodelOutputs {
  
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
      StreamController<File>.broadcast();
  final StreamController<String> _addressIdStreamController =
      StreamController<String>.broadcast();
  final StreamController<bool> _areAllInputsValidStreamController =
      StreamController<bool>.broadcast();
  final StreamController<bool> _isOrganizationCreatedSuccessfullyController =
      StreamController<bool>.broadcast();
  final StreamController<String?> _imagePathController =
      StreamController<String?>.broadcast();
final StreamController<bool> _isNameValidController = StreamController<bool>.broadcast();
final StreamController<bool> _isTypeValidController = StreamController<bool>.broadcast();
final StreamController<bool> _isPhoneValidController = StreamController<bool>.broadcast();
final StreamController<bool> _isDescValidController = StreamController<bool>.broadcast();
final StreamController<bool> _isImageValidController = StreamController<bool>.broadcast();
final StreamController<bool> _isAddressValidController = StreamController<bool>.broadcast();
  // Data object holding all form values
  CreateNewOrganizerObject createOrganizationObject = CreateNewOrganizerObject(
    "",
    "",
    "",
    "",
    File(""),
    "",
  );

  final CreateNewOrganizerUsecase _createOrganizationUsecase;

  NewOrganizationViewmodel(this._createOrganizationUsecase);

  @override
void start() {
  inputState.add(ContentState());
  
  // Combine all validation streams
  _areAllInputsValidStreamController.addStream(
    Rx.combineLatest6(
      _isNameValidController.stream,
      _isTypeValidController.stream,
      _isPhoneValidController.stream,
      _isDescValidController.stream,
      _isImageValidController.stream,
      _isAddressValidController.stream,
      (bool nameValid, bool typeValid, bool phoneValid, 
       bool descValid, bool imageValid, bool addressValid) {
        return nameValid && typeValid && phoneValid && 
               descValid && imageValid && addressValid;
      },
    ),
  );
}

  @override
  void dispose() {
    _organizationNameStreamController.close();
    _organizationTypeStreamController.close();
    _phoneNumberStreamController.close();
    _descriptionStreamController.close();
    _imageStreamController.close();
    _addressIdStreamController.close();
    _areAllInputsValidStreamController.close();
    _isOrganizationCreatedSuccessfullyController.close();
    _imagePathController.close();
    super.dispose();
  }

 @override
Future<void> createOrganizer() async {
  if (!_areAllInputsValid()) {
    inputState.add(ErrorState(
      StateRendererType.popUpErrorState,
      "Please fill all required fields correctly"
    ));
    return;
  }

  inputState.add(
    LoadingState(stateRendererType: StateRendererType.popUpLoadingState)
  );

  final result = await _createOrganizationUsecase.execute(
    CreateNewOrganizerInput(
      name: createOrganizationObject.name,
      type: createOrganizationObject.type,
      phoneNumber: createOrganizationObject.phoneNumber,
      description: createOrganizationObject.description,
      imageFile: createOrganizationObject.image,
      addressId: createOrganizationObject.addressId,
    ),
  );

  result.fold(
    (failure) {
      inputState.add(
        ErrorState(StateRendererType.popUpErrorState, failure.message)
      );
    },
    (organization) {
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
  Sink get inputAddressId => _addressIdStreamController.sink;

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
  Stream<String?> get outputAddressId => _addressIdStreamController.stream;

  @override
  Stream<bool> get isOrganizationCreatedSuccessfullyStream =>
      _isOrganizationCreatedSuccessfullyController.stream;

  @override
  Stream<String?> get outputErrorOrganizationName =>
      _organizationNameStreamController.stream.map((name) {
        if (name.isEmpty) return "Organization name cannot be empty";
        if (name.length < 3) return "Organization name too short";
        return null;
      });

  @override
  Stream<String?> get outputErrorOrganizationType =>
      _organizationTypeStreamController.stream.map((type) {
        if (type.isEmpty) return "Organization type cannot be empty";
        return null;
      });

  @override
  Stream<String?> get outputErrorPhoneNumber =>
      _phoneNumberStreamController.stream.map((phoneNumber) {
        if (phoneNumber.isEmpty) return "Phone number cannot be empty";
        if (!RegExp(r'^\+?[0-9]{10,15}$').hasMatch(phoneNumber)) {
          return "Invalid phone number format";
        }
        return null;
      });

  @override
  Stream<String?> get outputErrorDescription =>
      _descriptionStreamController.stream.map((description) {
        if (description.isEmpty) return "Description cannot be empty";
        if (description.length < 20) return "Description too short";
        return null;
      });

  @override
  Stream<String?> get outputImagePath => _imagePathController.stream;

  // Setters
@override
void setOrganizationName(String organizationName) {
  inputOrganizationName.add(organizationName);
  createOrganizationObject = createOrganizationObject.copyWith(name: organizationName);
  _isNameValidController.add(organizationName.isNotEmpty && organizationName.length >= 3);
  _validate();
}

@override
void setType(String organizationType) {
  inputOrganizationType.add(organizationType);
  createOrganizationObject = createOrganizationObject.copyWith(type: organizationType);
  _isTypeValidController.add(organizationType.isNotEmpty);
  _validate();
}

  @override
  void setPhoneNumber(String phoneNumber) {
    inputPhoneNumber.add(phoneNumber);
    createOrganizationObject = createOrganizationObject.copyWith(
      phoneNumber: phoneNumber
    );
    _validate();
  }

  @override
  void setDescription(String description) {
    inputDescription.add(description);
    createOrganizationObject = createOrganizationObject.copyWith(
      description: description
    );
    _validate();
  }

  @override
  void setImage(File image) {
    inputImage.add(image);
    createOrganizationObject = createOrganizationObject.copyWith(
      image: image
    );
    _validate();
  }

  void setImagePath(String? path) {
    _imagePathController.add(path);
  }

  @override
  void setCity(String city) {
    // Not used in this implementation
  }

  @override
  void setPostalCode(String postalCode) {
    // Not used in this implementation
  }

  @override
  void setState(String state) {
    // Not used in this implementation
  }

  @override
  void setStreet(String street) {
    // Not used in this implementation
  }

  // Private methods
  bool _areAllInputsValid() {
    return createOrganizationObject.name.isNotEmpty &&
        createOrganizationObject.type.isNotEmpty &&
        createOrganizationObject.phoneNumber.isNotEmpty &&
        createOrganizationObject.description.isNotEmpty &&
        createOrganizationObject.image.path.isNotEmpty &&
        createOrganizationObject.addressId.isNotEmpty;
  }

  void _validate() {
    inputAreAllInputsValid.add(_areAllInputsValid());
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

  Sink get inputAddressId;

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

  Stream<String?> get outputAddressId;

  Stream<bool> get outputAreAllInputsValid;

  Stream<bool> get isOrganizationCreatedSuccessfullyStream;

  Stream<String?> get outputImagePath;

  Stream<FlowState> get outputState; // Add this lin
}