import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tripdraw/View/LogIn/loginView2.dart';
import 'package:tripdraw/Widget/newStoryboardButton.dart';
import 'package:tripdraw/style.dart' as style;
import '../View/Archive/archiveView.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controller/tokenController.dart';

class HomeMainWidget extends StatelessWidget {
  HomeMainWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final tokenController = Get.find<TokenController>();
    return Obx(() {
      final token = tokenController.currentToken;
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (token == '') // token이 null이면 Login 버튼 왼쪽에 표시
                InkWell(
                  onTap: () async {
                    await Get.to(() => LoginView());
                    // 로그인 후 토큰 업데이트
                    tokenController.updateToken(token);
                  },
                  child: Container(
                    height: 25.h,
                    width: 60.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: const Color(0XFF56B1FA),
                    ),
                    child: Center(
                      child: Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              if (token != '') // token이 null이 아니면 오른쪽으로 공간 확보
                const Spacer(),
              if (token != '') // token이 null이 아니면 Archive 버튼 오른쪽에 표시
                InkWell(
                  onTap: () {
                    Get.to(() => ArchiveView());
                  },
                  child: Container(
                    width: 35.w,
                    height: 35.h,
                    decoration: BoxDecoration(
                      color: const Color(0XFF56B1FA),
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 24.0,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          Stack(
            children: [
              Opacity(
                opacity: 0.5,
                child: Lottie.asset(
                  'images/home_bus.json',
                  height: 220.h,
                  fit: BoxFit.fill,
                ),
              ),
              Positioned(
                top: 20.h,
                left: 60.w,
                child: Column(
                  children: [
                    Text(
                      "WELCOME",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "For Travel Video",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    const NewStoryboardButton(),
                  ],
                ),
              ),
            ],
          ),
        ],
      );
    });
  }
}
