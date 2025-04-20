import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../domain/model/models.dart';
import '../../resources/asset_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/constants_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/route_manager.dart';
import '../../resources/strings_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';
import '../viewmodel/onboarding_viewmodel.dart';
import 'package:supervisor_app/presentation/dashboard/dashboard_view.dart';


class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final PageController _pageController = PageController();
  final OnboardingViewmodel _viewmodel = OnboardingViewmodel();

  _bind() {
    _viewmodel.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SliderViewObject>(
        stream: _viewmodel.outputSliderViewObject,
        builder: (context, snapshot) {
          return _getContentWidget(snapshot.data);
        });
  }

  Widget _getContentWidget(SliderViewObject? sliderViewObject) {
    if (sliderViewObject == null) {
      return Container();
    } else {
      return Scaffold(
        backgroundColor: ColorManager.white,
        body: PageView.builder(
            itemCount: sliderViewObject.numberOfSlides,
            controller: _pageController,
            onPageChanged: (index) {
              _viewmodel.onPageChanged(index);
            },
            itemBuilder: (context, index) {
              return OnBoardingPage(sliderViewObject.sliderObject);
            }),
        bottomSheet: Padding(
          padding: const EdgeInsets.only(top: 0.0),
          child: Container(
            color: ColorManager.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _getCircleIndicator(sliderViewObject),
                _getNavigationButtons(),
              ],
            ),
          ),
        ),
      );
    }
  }

  Widget _getCircleIndicator(SliderViewObject sliderViewObject) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < sliderViewObject.numberOfSlides; i++)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSize.s8),
            child: _getProperCircle(i, sliderViewObject.currentIndex),
          )
      ],
    );
  }

  Widget _getNavigationButtons() {
    bool isLastPage = _viewmodel.currentIndex == _viewmodel.totalSlides - 1;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppPadding.p14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (!isLastPage)
            TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, Routes.login);
                //Navigator.pushReplacementNamed(context, Routes.mainRoute);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  AppStrings.skip,
                  style: TextStyle(color: ColorManager.secondary.withOpacity(0.5), fontSize: 16 , fontWeight: FontWeightManager.semiBold),
                ),
              ),
            )
          else
            const SizedBox(), // Placeholder for alignment

          TextButton(
            onPressed: () {
              if (isLastPage) {
                Navigator.pushReplacementNamed(context, Routes.login);
                //Navigator.pushReplacementNamed(context, Routes.mainRoute);
              } else {
                _pageController.animateToPage(
                  _viewmodel.goNext(),
                  duration: const Duration(milliseconds: AppConstants.sliderAnimation),
                  curve: Curves.easeInOut,
                );
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                isLastPage ? AppStrings.finish : AppStrings.next,
                style: TextStyle(color: ColorManager.secondary, fontSize: 24 , fontWeight: FontWeightManager.semiBold ),
              ),
            ),
          ),
        ],
      ),
    );
  }



  Widget _getProperCircle(int index, int currentIndex) {
    if (index == currentIndex) {
      return Image.asset(ImageAssets.hollowCircle);
    } else {
      return Image.asset(ImageAssets.solidCircle);
    }
  }

  @override
  void dispose() {
    _viewmodel.dispose();
    super.dispose();
  }
}

class OnBoardingPage extends StatelessWidget {
  final SliderObject _sliderObject;

  const OnBoardingPage(this._sliderObject, {super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Container(
              height: AppHeight.h700,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: _sliderObject.gradientColors,
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),

          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: AppSize.s100),
            Image.asset(_sliderObject.image),
            const SizedBox(height: AppSize.s40),
            Padding(
              padding: const EdgeInsets.all(AppPadding.p8),
              child: Text(
                _sliderObject.title,
                textAlign: TextAlign.center,
                style: getBoldStyle(fontSize: FontSize.s24, color: ColorManager.onBoardingTitle),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppPadding.p8),
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0, left:8.0 ),
                child: Text(
                  _sliderObject.subTitle,
                  textAlign: TextAlign.center,
                  style: getMediumStyle(fontSize: FontSize.s20, color: ColorManager.black),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
