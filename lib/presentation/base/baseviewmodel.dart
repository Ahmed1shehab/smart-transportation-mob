import 'dart:async';
import 'package:smart_transportation/presentation/common/state_renderer/state_rendered_impl.dart';

abstract class BaseViewModel extends BaseViewModelInputs
    implements BaseViewModelOutputs {
  // Use explicit type for StreamController
  final StreamController<FlowState> _inputStreamController =
  StreamController<FlowState>.broadcast();

  @override
  Sink<FlowState> get inputState => _inputStreamController.sink;

  @override
  Stream<FlowState> get outputState => _inputStreamController.stream;

  @override
  void dispose() {
    _inputStreamController.close();
  }
}

abstract class BaseViewModelInputs {
  void start();
  void dispose();
  Sink<FlowState> get inputState;  // Explicitly typed Sink
}

abstract class BaseViewModelOutputs {
  Stream<FlowState> get outputState;
}