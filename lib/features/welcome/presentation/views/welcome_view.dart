import 'package:flutter/material.dart';
import 'package:member/features/welcome/presentation/views/widget/welcome_view_body.dart';

class WelcomeView extends StatelessWidget {
  WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
           backgroundColor: Colors.white,
      body: WelcomeViewBody());
  }
}
