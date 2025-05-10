import 'package:bloc/bloc.dart';
import 'package:smart_transportation/presentation/on_boarding_organizer/bloc/popup_state.dart';

class PopupCubit extends Cubit<PopupState> {
  PopupCubit() : super(const PopupInitial());

  void showTermsAndConditionsPopup() {
    emit(const ShowTermsAndConditionsPopup(showPopup: true));
  }

  void hideTermsAndConditionsPopup() {
    if (state is ShowTermsAndConditionsPopup) {
      emit((state as ShowTermsAndConditionsPopup).copyWith(showPopup: false));
    }
  }
}