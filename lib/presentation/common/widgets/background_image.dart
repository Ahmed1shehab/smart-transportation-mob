import 'package:flutter/material.dart';
import 'package:smart_transportation/presentation/resources/asset_manager.dart';
import 'package:smart_transportation/presentation/resources/constants_manager.dart';

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({super.key});

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationY(AppConstants.transformHorizontally),
        child: Image.asset(
          ImageAssets.appBG,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
