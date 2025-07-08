import 'package:flutter/material.dart';
import 'package:member/features/step3/presentation/views/widgets/step_3_view_body.dart';

class Step3View extends StatelessWidget {
  const Step3View({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
           backgroundColor: Colors.white,
      body: Step3ViewBody(),
    );
  }
}