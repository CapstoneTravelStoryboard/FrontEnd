import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tripdraw/View/GenerateStoryboard/generateStoryboard.dart';
import 'package:tripdraw/style.dart' as style;
import 'package:lottie/lottie.dart';


class EmptyArchiveView extends StatelessWidget {
  const EmptyArchiveView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(

      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          children: [
            Lottie.asset(
              'images/empty.json',
              // height: 200.h,
              width: 300.w,
              fit: BoxFit.fill,
            ),
            Positioned(
              top: 20.h,
              left: 60.w,
              child: Column(
                children: [
                  SizedBox(height: 50.h,),
                  Text(
                    "아직 스토리보드가 없습니다",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 80.h,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(() => GenerateStoryboardView());
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
                          "새 스토리보드 만들기",
                          style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFFFBFAE8)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}
