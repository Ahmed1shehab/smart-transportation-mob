import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_transportation/presentation/auth/account_type/viewmodel/account_type_viewmodel.dart';
import 'package:smart_transportation/presentation/resources/asset_manager.dart';
import 'package:smart_transportation/presentation/resources/color_manager.dart';
import 'package:smart_transportation/presentation/resources/constants_manager.dart';
import 'package:smart_transportation/presentation/resources/font_manager.dart';
import 'package:smart_transportation/presentation/resources/route_manager.dart';
import 'package:smart_transportation/presentation/resources/strings_manager.dart';
import 'package:smart_transportation/presentation/resources/values_manager.dart';

import '../../../common/widgets/background_image.dart';

class AccountTypeView extends StatelessWidget {
  final AccountTypeViewModel _viewModel = AccountTypeViewModel();

  AccountTypeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundImage(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    height: MediaQuery.of(context).size.width * AppSize.s0_5),
                const SizedBox(height: AppSize.s24),
                _buildTitleAndDescription(context),
                const SizedBox(height: AppPadding.p28),
                _buildAccountTypeChoices(context),
                const SizedBox(height: AppPadding.p24),
                _buildFinishButton(context),
                const SizedBox(height: AppSize.s8),
                _buildChangeInfoText(context),
                const SizedBox(height: AppSize.s24),
                _buildLoginNavigation(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitleAndDescription(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          AppStrings.accountTypeTitle,
          style: Theme.of(context).textTheme.displayMedium!.copyWith(
            fontSize: FontSize.s20,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSize.s16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p8),
          child: Text(
            AppStrings.accountTypeDescription,
            style: Theme.of(context)
                .textTheme
                .labelMedium!
                .copyWith(color: ColorManager.black, fontSize: FontSize.s14),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildAccountTypeChoices(BuildContext context) {
    return ValueListenableBuilder<String?>(
      valueListenable: _viewModel.selectedType,
      builder: (context, selected, _) {
        return Column(
          children: [
            _buildChoiceBox(
              context,
              label: AppStrings.member,
              description: AppStrings.memberDescription,
              isSelected: selected == AppStrings.member,
              onTap: () => _viewModel.selectType(AppStrings.member),
              icon: Icons.person_outline,
            ),
            const SizedBox(height: AppSize.s16),
            _buildChoiceBox(
              context,
              label: AppStrings.organizer,
              description: AppStrings.organizerDescription,
              isSelected: selected == AppStrings.organizer,
              onTap: () => _viewModel.selectType(AppStrings.organizer),
              icon: Icons.manage_accounts_outlined,
            ),
          ],
        );
      },
    );
  }

  Widget _buildFinishButton(BuildContext context) {
    return ValueListenableBuilder<String?>(
      valueListenable: _viewModel.selectedType,
      builder: (context, selected, _) {
        return SizedBox(
          width: double.infinity,
          height: AppSize.s43,
          child: ElevatedButton(
            onPressed: selected == null
                ? null
                : () {
              if (_viewModel.canSubmit) {
                if (selected == AppStrings.member) {
                  Navigator.pushNamed(context, Routes.mainRoute);
                } else if (selected == AppStrings.organizer) {
                  Navigator.pushReplacementNamed(context, Routes.homeViewOrganizer);
                }
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor:
              selected == null ? ColorManager.grey : ColorManager.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSize.s8),
              ),
            ),
            child: Text(
              AppStrings.finish,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: ColorManager.white),
            ),
          ),
        );
      },
    );
  }

  Widget _buildChangeInfoText(BuildContext context) {
    return Center(
      child: Text(
        AppStrings.accountTypeChangeInfo,
        style: Theme.of(context)
            .textTheme
            .labelSmall!
            .copyWith(fontSize: FontSize.s12, color: ColorManager.darkGrey),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildLoginNavigation(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            AppStrings.alreadyHaveAccount,
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .copyWith(fontSize: FontSize.s14, color: ColorManager.primary),
            textAlign: TextAlign.center,
          ),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, Routes.login);
            },
            child: Text(
              AppStrings.loginNow,
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: ColorManager.primary2,
                  fontSize: FontSize.s16,
                  fontWeight: FontWeightManager.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChoiceBox(
      BuildContext context, {
        required String label,
        required String description,
        required bool isSelected,
        required VoidCallback onTap,
        required IconData icon,
      }) {
    final textColor =
    isSelected ? ColorManager.white : Theme.of(context).primaryColor;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSize.s16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppPadding.p16),
        decoration: BoxDecoration(
          color:
          isSelected ? Theme.of(context).primaryColor : ColorManager.white,
          borderRadius: BorderRadius.circular(AppSize.s16),
          border: Border.all(color: Theme.of(context).primaryColor),
          boxShadow: const [
            BoxShadow(
              color: ColorManager.black12,
              blurRadius: AppSize.s4,
              offset: Offset(0, AppSize.s2),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: textColor, size: AppSize.s32),
            const SizedBox(height: AppSize.s8),
            Text(
              label,
              style: TextStyle(
                fontSize: FontSize.s18,
                fontWeight: FontWeightManager.bold,
                color: textColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSize.s6),
            Text(
              description,
              style: TextStyle(
                fontSize: FontSize.s13,
                color:
                isSelected ? ColorManager.white70 : ColorManager.darkGrey,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}