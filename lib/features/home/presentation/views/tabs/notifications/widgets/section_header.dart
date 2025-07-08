
 
import 'package:flutter/material.dart';
import 'package:member/config/app_text_styles.dart';

class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0, top: 24),
      child: Text(
        title,
        style: AppTextStyles.semiBold,
      ),
    );
  }
}
 