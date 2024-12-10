import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tripdraw/View/GenerateStoryboard/generateStoryboard.dart';
import 'package:tripdraw/View/GenerateStoryboard/generateTravelView.dart';
import 'package:tripdraw/style.dart' as style;
class NewStoryboardButton extends StatelessWidget {
  const NewStoryboardButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => GenerateTravelView());
      },
      child: Container(
        height: 30.h,
        width: 200.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color(0XFF2266FF),
        ),
        child: Center(
          child: Text(
            "+ 새 여행기록 추가",
            style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
                color: Color(0xFFFBFAE8)),
          ),
        ),
      ),
    );
  }
}
