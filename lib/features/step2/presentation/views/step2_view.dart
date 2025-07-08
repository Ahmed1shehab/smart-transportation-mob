import 'package:flutter/material.dart';
import 'package:member/features/step2/presentation/views/widgets/step_2_view_body.dart';

class Step2View extends StatelessWidget {
  const Step2View({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
           backgroundColor: Colors.white,
      body: Step2ViewBody(),
    );
  }
}