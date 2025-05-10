import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:smart_transportation/app/app_prefs.dart';
import 'package:smart_transportation/domain/model/models.dart';
import 'package:smart_transportation/domain/usecase/get_all_organizations_usecase.dart';
import 'package:smart_transportation/domain/usecase/get_organization_usecase.dart';
import 'package:smart_transportation/presentation/base/baseviewmodel.dart';
import 'package:smart_transportation/presentation/common/state_renderer/state_rendered.dart';
import 'package:smart_transportation/presentation/common/state_renderer/state_rendered_impl.dart';

import 'package:smart_transportation/app/di.dart';

class DashboardViewModel extends BaseViewModel
    implements DashboardViewModelInput, DashboardViewModelOutput {

  final _allOrganizationsStreamController = BehaviorSubject<List<OrganizationItem>>();
  final _firstOrganizationStreamController = BehaviorSubject<OrganizationItem?>();
  final navigationController = BehaviorSubject<String?>();

  final GetAllOrganizationsUsecase _getAllOrganizationsUsecase;
  final GetOrganizationUsecase _getOrganizationUsecase;
  final AppPreferences _appPreferences = instance<AppPreferences>();

  DashboardViewModel(
    this._getAllOrganizationsUsecase,
    this._getOrganizationUsecase,
  );

  @override
  void start() async {
    await _loadActiveOrganization();
    getAllOrganizations();
  }

Future<void> _loadActiveOrganization() async {
  String? activeOwnerId = await _appPreferences.getActiveOwner();
  if (activeOwnerId != null) {
    // Print the current owner and token
    print('Loading Active Owner ID: $activeOwnerId');
    final currentToken = await _appPreferences.getAccessToken();
    print('Current Access Token: $currentToken');
    
    await activateOrganization(activeOwnerId);
  }
}

  Future<void> getAllOrganizations() async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState));

    (await _getAllOrganizationsUsecase.execute(null)).fold(
      (failure) {
        inputState.add(
            ErrorState(StateRendererType.fullScreenErrorState, failure.message));
      },
      (organizations) {
        _allOrganizationsStreamController.sink.add(organizations);

        if (organizations.isNotEmpty) {
          inputState.add(ContentState());
        } else {
          inputState.add(EmptyState("Loading Organizations"));
        }
      },
    );
  }

  /// Activate Organization and Save Active Owner
Future<void> activateOrganization(String ownerId) async {
  inputState.add(LoadingState(
      stateRendererType: StateRendererType.popUpLoadingState));

  (await _getOrganizationUsecase.execute(ownerId)).fold(
    (failure) {
      inputState.add(ErrorState(StateRendererType.popUpErrorState, failure.message));
    },
    (organization) async {
      // Save the active owner ID
      await _appPreferences.setActiveOwner(ownerId);
      
      // Print the saved owner ID
      print('Saved Active Owner ID: $ownerId');
      
      // Get and print the current token (if any)
      final currentToken = await _appPreferences.getAccessToken();
      print('Current Access Token: $currentToken');
      
      _firstOrganizationStreamController.sink.add(organization);
      inputState.add(ContentState());
    },
  );
}

  @override
  void dispose() {
    _allOrganizationsStreamController.close();
    _firstOrganizationStreamController.close();
    navigationController.close();
    super.dispose();
  }

  @override
  Stream<List<OrganizationItem>> get outputAllOrganizations =>
      _allOrganizationsStreamController.stream;

  @override
  Stream<OrganizationItem?> get outputFirstOrganization =>
      _firstOrganizationStreamController.stream;

  @override
  Stream<String?> get outputNavigateToOrganizationDetails =>
      navigationController.stream;
}

abstract class DashboardViewModelInput {
  // No need for inputAllOrganizations in this implementation
}

abstract class DashboardViewModelOutput {
  Stream<List<OrganizationItem>> get outputAllOrganizations;
  Stream<OrganizationItem?> get outputFirstOrganization;
  Stream<String?> get outputNavigateToOrganizationDetails;
}
