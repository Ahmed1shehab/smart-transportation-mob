import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_transportation/app/constants.dart';
import 'package:smart_transportation/presentation/on_boarding_organizer/bloc/popup_cubit.dart';
import 'package:smart_transportation/presentation/on_boarding_organizer/bloc/popup_state.dart';
import 'package:smart_transportation/presentation/resources/asset_manager.dart';
import 'package:smart_transportation/presentation/resources/color_manager.dart';
import 'package:smart_transportation/presentation/resources/font_manager.dart';
import 'package:smart_transportation/presentation/resources/route_manager.dart';
import 'package:smart_transportation/presentation/resources/strings_manager.dart';
import 'package:smart_transportation/presentation/resources/values_manager.dart';

class HomeViewOrganizer extends StatelessWidget {
  const HomeViewOrganizer({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PopupCubit>().showTermsAndConditionsPopup();
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.white,
        elevation: Constants.zeroDouble,
      ),
      backgroundColor: ColorManager.white,
      body: BlocListener<PopupCubit, PopupState>(
        listener: (context, state) {
          if (state is ShowTermsAndConditionsPopup && state.showPopup) {
            showDialog(
              context: context,
              builder: (context) => _getTermsAndCondition(context),
            ).then((_) {
              context.read<PopupCubit>().hideTermsAndConditionsPopup();
            });
          }
        },
        child: _getContentWidget(context),
      ),
    );
  }

  Widget _getContentWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: AppPadding.p16),
                  Text(
                    AppStrings.welcome,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  const SizedBox(height: AppPadding.p16),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppPadding.p16),
                    child: Text(
                      AppStrings.pleaseProvideDetails,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: AppPadding.p60),

                  // Content
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppPadding.p8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          ImageAssets.steps,
                          width: AppSize.s100,
                          height: AppSize.s180,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppStrings.step1,
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                              Text(
                                AppStrings.organizationDetails,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              const SizedBox(height: AppPadding.p70),
                              Text(
                                AppStrings.step2,
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                              Text(
                                AppStrings.addAddress,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bottom Section: Buttons
          Padding(
            padding: const EdgeInsets.all(AppPadding.p20),
            child: Column(
              children: [
                // Start Button
                SizedBox(
                  width: double.infinity,
                  height: AppSize.s43,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.organizationDetails);
                    },
                    child: Text(
                      AppStrings.start,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                ),
                const SizedBox(height: AppPadding.p16),

                // Switch Account Button
                SizedBox(
                  width: double.infinity,
                  height: AppSize.s43,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, Routes.switchAccount);
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: ColorManager.white,
                      side: BorderSide(color: ColorManager.primary),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSize.s8),
                      ),
                    ),
                    child: Text(
                      AppStrings.switchAccount,
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium
                          ?.copyWith(fontSize: AppSize.s16),
                    ),
                  ),
                ),
                const SizedBox(height: AppPadding.p16),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _getTermsAndCondition(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.s16),
      ),
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.6, // Reduced height to 60% of screen height
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSize.s16),
          border: Border.all(
            color: ColorManager.primary,
            width: AppSize.s2,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppPadding.p16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                AppStrings.termsAndConditions,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: ColorManager.primary,
                ),
              ),
              const SizedBox(height: AppPadding.p16),

              // Scrollable Content
              Container(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.4, // Reduced height to 40% of screen height
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: ColorManager.primary,
                    width: AppSize.s1,
                  ),
                  borderRadius: BorderRadius.circular(AppSize.s8),
                ),
                child: const SingleChildScrollView(
                  padding: EdgeInsets.all(AppPadding.p8),
                  child: Text(
                    AppStrings.termsAndConditionsText,
                    style: TextStyle(fontSize: FontSize.s14),
                  ),
                ),
              ),
              const SizedBox(height: AppPadding.p16),

              // Accept Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the dialog
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorManager.primary,
                    padding: const EdgeInsets.symmetric(vertical: AppPadding.p12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSize.s8),
                    ),
                  ),
                  child: Text(
                    AppStrings.accept,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: ColorManager.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppPadding.p8),

              // "You agree to our terms" text with padding
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16), // Add horizontal padding
                child: Center(
                  child: Text(
                    AppStrings.youAgreeToOurTerms,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: AppSize.s15,
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
}
