import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:member/config/app_text_styles.dart';

class DetailsTab extends StatelessWidget {
  const DetailsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DetailRow(
          title: "E-mail",
          value: "ahmed@gmail.com",
        ),
        DetailRow(
          title: "Phone Number",
          value: "01223217637",
        ),
        DetailRow(
          title: "Address",
          value: "Mansoura , Gehan Street",
        ),
      ],
    );
  }
}

class DetailRow extends StatelessWidget {
  final String title;
  final String value;

  const DetailRow({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: AppTextStyles.body.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                ),
              ),
              Expanded(
                child: Text(
                  value,
                  textAlign: TextAlign.end,
                  style: AppTextStyles.body.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                    color: Colors.grey[800],
                  ),
                ),
              ),
            ],
          ),
        ),
        Divider(
          thickness: 1,
          color: Color(0XFF8FC2E0).withOpacity(.7),
        ),
      ],
    );
  }
}
