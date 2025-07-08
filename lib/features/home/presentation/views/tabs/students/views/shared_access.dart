import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:member/config/app_text_styles.dart';
import 'package:member/core/helper/assets_manager.dart';
import 'package:member/core/helper/colors_manager.dart';

class SharedAccessPage extends StatelessWidget {
  final List<Member> members = [
    Member(name: "Maryam Ahmed", status: MemberStatus.accepted),
    Member(name: "Maryam Ahmed", status: MemberStatus.pending),
    Member(name: "Maryam Ahmed", status: MemberStatus.pending),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Shared Access",
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.mic_none, color: Colors.black),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "You can allow members to check on \n the student with you.",
              textAlign: TextAlign.center,
              style: AppTextStyles.semiBold.copyWith(
                fontSize: 16,
                color: ColorsManager.primary,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              "Current Members",
              style: AppTextStyles.semiBold.copyWith(fontSize: 16),
            ),
            SizedBox(height: 12.h),
            Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: members.length,
                separatorBuilder: (_, __) => SizedBox(height: 12.h),
                itemBuilder: (context, index) {
                  final member = members[index];
                  return Dismissible(
                    key: Key(member.name + index.toString()),
                    direction: DismissDirection.endToStart,
                    confirmDismiss: (direction) async {
                      // نعرض الـ Dialog و نرجع true أو false بناءً عليه
                      final result = await showDialog<bool>(
                        context: context,
                        builder: (context) {
                          return DeleteConfirmationDialog(
                            memberName: member.name,
                          );
                        },
                      );
                      return result ?? false;
                    },
                    background: Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: 20.w),
                      decoration: BoxDecoration(
                        color: Colors.red.shade300,
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Icon(Icons.delete, color: Colors.white),
                    ),
                    child: MemberCard(member: member),
                  );
                },
              ),
            ),
            SizedBox(height: 16.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => AddMemberDialog(),
                  );
                },

                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorsManager.primary,
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  "Add Member",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum MemberStatus { accepted, pending }

class Member {
  final String name;
  final MemberStatus status;

  Member({required this.name, required this.status});
}

class MemberCard extends StatelessWidget {
  final Member member;

  const MemberCard({super.key, required this.member});

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    String statusText;

    switch (member.status) {
      case MemberStatus.accepted:
        statusColor = Colors.green;
        statusText = "Accepted";
        break;
      case MemberStatus.pending:
        statusColor = Colors.orange;
        statusText = "Pending";
        break;
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          // الجزء العلوي الأزرق الفاتح مع الصورة
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 40.h,
                decoration: BoxDecoration(
                  color: Color(0xFFD4EDF6),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.r),
                    topRight: Radius.circular(20.r),
                  ),
                ),
              ),
              Positioned(
                left: 16.w,
                top: 20.h,
                child: CircleAvatar(
                  radius: 30.r,
                  backgroundImage: AssetImage(AssetsManager.kid1),
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          // الاسم والحالة
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: 64.w), // تعويض لمكان الصورة
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      member.name,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade800,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        CircleAvatar(radius: 5.r, backgroundColor: statusColor),
                        SizedBox(width: 6.w),
                        Text(
                          statusText,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: statusColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DeleteConfirmationDialog extends StatelessWidget {
  final String memberName;

  const DeleteConfirmationDialog({super.key, required this.memberName});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Icon(
                Icons.close,
                size: 20.sp,
                color: ColorsManager.primary,
              ),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            "Are you sure you want to delete\n$memberName?",
            textAlign: TextAlign.center,
            style: AppTextStyles.semiBold.copyWith(fontSize: 16.sp),
          ),
          SizedBox(height: 24.h),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // هنا تضيف كود الحذف من القائمة فعليًا لو حبيت
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorsManager.primary,
              minimumSize: Size(double.infinity, 48.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: Text("Delete", style: TextStyle(color: Colors.white)),
          ),
          SizedBox(height: 12.h),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel", style: TextStyle(color: Colors.grey)),
          ),
        ],
      ),
    );
  }
}

class AddMemberDialog extends StatelessWidget {
  final TextEditingController controller = TextEditingController();

  AddMemberDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      child: SizedBox(
        width: 360.w, // تحكم كامل في العرض
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(
                    Icons.close,
                    size: 20.sp,
                    color: ColorsManager.primary,
                  ),
                ),
              ),
              SizedBox(height: 8.h),

              // Title Text
              Text(
                "Please provide the details of the member you want to add",
                textAlign: TextAlign.center,
                style: AppTextStyles.semiBold.copyWith(
                  fontSize: 16.sp,
                  color: ColorsManager.primary,
                ),
              ),
              SizedBox(height: 20.h),

              // TextField + QR icon on the side
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        hintStyle: TextStyle(fontSize: 12.sp),
                        hintText: "Enter Phone Number/ E-mail",
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 12.h,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: ColorsManager.primary.withOpacity(0.4),
                          ),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: ColorsManager.primary),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 4.w),

                  Container(
                    padding: EdgeInsets.all(10.r),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Image.asset(
                      AssetsManager.qrcode,
                      height: 30.h,
                      width: 30.w,

                      fit: BoxFit.fill,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20.h),

              // Add Member Button
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  // Handle member addition
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorsManager.primary.withOpacity(0.85),
                  minimumSize: Size(double.infinity, 48.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  "Add Member",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
