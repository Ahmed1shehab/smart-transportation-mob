import 'dart:async';

import 'package:flutter/cupertino.dart';

class AccountTypeViewModel with ChangeNotifier {
  final ValueNotifier<String?> selectedType = ValueNotifier(null);


  final StreamController<String?> _stateController =
  StreamController<String?>.broadcast();

  Stream<String?> get outputState => _stateController.stream;

  void selectType(String type) {
    selectedType.value = type;
    _stateController.add(type);
    notifyListeners();
  }

  bool get canSubmit => selectedType.value != null;

  @override
  void dispose() {
    selectedType.dispose();
    _stateController.close();
    super.dispose();
  }
}
