import 'package:flutter/material.dart';
import 'package:member/core/helper/colors_manager.dart';
import 'app_sizes.dart';
 

class AppTextStyles {
  static const TextStyle heading = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: ColorsManager.primary,
  );

  static const TextStyle body = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 10,
        fontWeight: FontWeight.w400,
    color: Colors.black,
  );
    static const TextStyle semiBold = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w600,
    fontSize: 16,
    color: Color(0XFF1B4865),
  );
}
