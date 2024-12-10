import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tripdraw/Widget/newStoryboardButton.dart';
import 'package:tripdraw/style.dart' as style;
import '../View/Archive/archiveView.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeMainWidget extends StatelessWidget {
  final String googleLoginUrl = "https://your-api.com/auth/google";
  const HomeMainWidget({super.key});
  // URL 실행 함수
  Future<void> launchGoogleLoginUrl() async {
    final Uri url = Uri.parse(googleLoginUrl);

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $googleLoginUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    Future<void> loginProcess() async {
      print('press');
      try {
        await launchGoogleLoginUrl();
      } catch (e) {
        // URL 실행 실패 처리
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text('Failed to open Google login: $e'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    }

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                loginProcess();
              },
              child: Container(
                height: 25.h,
                width: 60.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Color(0XFF56B1FA),
                ),
                child: Center(
                  child: Text(
                    "Login",
                    style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Get.to(()=>ArchiveView());
              },
              child: Container(
                width: 35.w,
                height: 35.h,
                decoration: BoxDecoration(
                  color: Color(0XFF56B1FA),
                  // Background color of the circle
                  shape: BoxShape.circle, // Makes the container circular
                ),
                child: Center(
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 24.0, // Set the icon size as needed
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
                // width: 310.w,
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
                  const NewStoryboardButton()
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
