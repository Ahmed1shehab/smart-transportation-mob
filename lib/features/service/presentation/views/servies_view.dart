import 'package:flutter/material.dart';
import 'package:member/features/service/presentation/views/widgets/services_view_body.dart';
import 'package:member/features/welcome/presentation/views/widget/welcome_view_body.dart';

class ServicesView extends StatelessWidget {
  ServicesView({super.key,  this.isInSettings});
bool ? isInSettings =false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
           backgroundColor: Colors.white,
       appBar: AppBar(iconTheme: IconThemeData(color: Colors.black),),
      body: ServicesViewBody(isInSettings: isInSettings));
  }
  
}
