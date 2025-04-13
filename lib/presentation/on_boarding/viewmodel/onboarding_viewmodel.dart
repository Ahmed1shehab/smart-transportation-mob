import 'dart:async';
import '../../../domain/model/models.dart';
import '../../base/baseviewmodel.dart';
import '../../resources/asset_manager.dart';
import '../../resources/strings_manager.dart';
import 'package:flutter/material.dart';

class OnboardingViewmodel extends BaseViewModel
    implements BaseViewModelInputs, BaseViewModelOutputs {
  final _streamController = StreamController<SliderViewObject>();
  late final List<SliderObject> _list;
  int _currentIndex = 0;

  int get currentIndex => _currentIndex; // Add getter for current index
  int get totalSlides => _list.length; // Getter for total slides

  @override
  void dispose() {
    _streamController.close();
  }

  @override
  void start() {
    _list = _getSliderObject();
    _postDataToView();
  }

  @override
  int goNext() {
    if (_currentIndex < _list.length - 1) {
      _currentIndex++;
      _postDataToView();
    }
    return _currentIndex;
  }

  @override
  void onPageChanged(int index) {
    _currentIndex = index;
    _postDataToView();
  }

  @override
  Sink get inputSliderViewObject => _streamController.sink;

  @override
  Stream<SliderViewObject> get outputSliderViewObject =>
      _streamController.stream.map((sliderViewObject) => sliderViewObject);

  void _postDataToView() {
    inputSliderViewObject.add(SliderViewObject(
        _list[_currentIndex], _currentIndex, _list.length));
  }

  List<SliderObject> _getSliderObject() => [
    SliderObject(
      AppStrings.onBoardingTitle1,
      AppStrings.onBoardingSubTitle1,
      ImageAssets.onboardingLogo1,
      [const Color(0xFF5FA8D3), Colors.white]
    ),
    SliderObject(
      AppStrings.onBoardingTitle2,
      AppStrings.onBoardingSubTitle2,
      ImageAssets.onboardingLogo2,
      [const Color(0xFF83C7C5), Colors.white],
    ),
    SliderObject(
      AppStrings.onBoardingTitle3,
      AppStrings.onBoardingSubTitle3,
      ImageAssets.onboardingLogo3,
      [const Color(0xFF61B6CB), Colors.white],
    ),
  ];

}
