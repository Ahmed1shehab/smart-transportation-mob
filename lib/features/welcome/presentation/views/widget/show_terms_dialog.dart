// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:member/config/app_text_styles.dart';
// import 'package:member/core/helper/colors_manager.dart';

// void showTermsDialog(BuildContext context) {
//   final ScrollController scrollController = ScrollController();

//   showDialog(
//     context: context,
//     barrierDismissible: false,
//     barrierColor: Colors.black.withOpacity(0.3),
//     builder: (context) {
//       return AlertDialog(
//         backgroundColor: Colors.white,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//         title: Center(
//           child: Text(
//             "Terms & Conditions",
//             style: AppTextStyles.heading.copyWith(fontSize: 16),
//           ),
//         ),
//         content: Container(
//           height: 300,
//           width: 380,
//           decoration: BoxDecoration(
//             border: Border.all(color: Colors.grey.shade400),
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: Scrollbar(
//             controller: scrollController,
//             thumbVisibility: true,
//             thickness: 8,

//             radius: const Radius.circular(8),
//             child: SingleChildScrollView(
//               controller: scrollController,
//               padding: const EdgeInsets.all(12),
//               child: Text('''
// 1. Introduction:
// Welcome to App! By signing up and using our services, you agree to comply with these Terms and Conditions. Please read them carefully before proceeding.

// 2. User Accounts:
// • You must provide accurate and up-to-date information during sign-up.
// • You are responsible for maintaining the confidentiality of your account credentials.
// • Do not create accounts on behalf of others without authorization.

// 3. Privacy and Data Usage:
// • Your data will be processed according to our Privacy Policy.
// • We use your information only for service and communication.

// 4. Acceptable Use:
// • Do not share your credentials or misuse the app.
// • Be respectful and avoid offensive content.
//         ''', style: AppTextStyles.body.copyWith(fontSize: 14)),
//             ),
//           ),
//         ),

//         actions: [
//           Center(
//             child: Column(
//               children: [
//                 ElevatedButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: ColorsManager.primary,
//                     minimumSize: const Size(326, 45),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                   child: Text(
//                     "Accept",
//                     style: AppTextStyles.heading.copyWith(
//                       color: Colors.white,
//                       fontSize: 14,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 Center(
//                   child: Text(
//                     "You agree to comply with our terms.",

//                     textAlign: TextAlign.center,
//                     style: AppTextStyles.body.copyWith(
//                       color: ColorsManager.primary,
//                       fontSize: 14.sp,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       );
//     },
//   );
// }
