
import 'package:flutter/material.dart';

class LeftCutClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(40, 0); // top-left before cut
    path.lineTo(0, size.height / 2); // triangle point
    path.lineTo(40, size.height); // bottom-left after cut
    path.lineTo(size.width, size.height); // bottom-right
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
// import 'package:flutter/material.dart';
//
// class LeftCutClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     Path path = Path();
//     path.lineTo(0, size.height);          // Bottom-left
//     path.lineTo(size.width, size.height);     // Bottom-right
//     path.lineTo(size.width, 0);               // Top-right
//     path.lineTo(0, 0);         // Top-left
//     path.lineTo(40, 0);
//     path.lineTo(0, size.height/2);
//     path.close();
//     return path;
//   }
//
//   @override
//   bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
// }