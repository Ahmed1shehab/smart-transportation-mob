import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:member/features/student_details/presentation/views/widgets/student_details_view_body.dart';

class StudentDetailsView extends StatelessWidget {
  const StudentDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
           backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.transparent,iconTheme: IconThemeData(color: Colors.black,),title:      Text(
                        "Student’s Details",
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        
                        ),
                      ),),
      body: StudentDetailsViewBody(),
    );
  }
}