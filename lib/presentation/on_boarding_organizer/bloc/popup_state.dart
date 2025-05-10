abstract class PopupState {
  const PopupState();

  PopupState copyWith();
}

class PopupInitial extends PopupState {
  const PopupInitial();

  @override
  PopupInitial copyWith() {
    return const PopupInitial();
  }
}
class ShowTermsAndConditionsPopup extends PopupState {
  final bool showPopup;

  const ShowTermsAndConditionsPopup({this.showPopup = true});

  @override
  ShowTermsAndConditionsPopup copyWith({bool? showPopup}) {
    return ShowTermsAndConditionsPopup(
      showPopup: showPopup ?? this.showPopup,
    );
  }
}
