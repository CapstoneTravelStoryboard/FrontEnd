import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tripdraw/Widget/homeMainwidget.dart';
import 'package:tripdraw/Widget/youtubeUrlWidget.dart';
import 'package:tripdraw/style.dart' as style;

import '../Widget/goAroundWidget2.dart';
import '../tutorial/tutorialView.dart';
import 'Guide/cameraGuideView.dart';

class HomeView extends StatefulWidget {
  HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<String> bannerImages = [
    'images/guidebanner2.png',
    'images/guidebanner_1_3.png',
  ];

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_currentPage < bannerImages.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeIn,
      );
    });
  }
  void _onBannerTap(int index) {
    // Example: Navigate to a different screen or perform an action based on the index
    if (index == 0) {
      // Navigate to the first guide or perform a specific action
      Get.to(() => TutorialView());
    } else if (index == 1) {
      Get.to(() => CameraGuideView());
    }
  }
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Stack with Lottie animation and overlay text
            HomeMainWidget(),
            SizedBox(
              height: 100.h, // Set banner height
              child: PageView.builder(
                controller: _pageController,
                itemCount: bannerImages.length,
                itemBuilder: (context, index) {
                  return Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.w),
                      child: GestureDetector(
                        onTap: (){
                          _onBannerTap(index);
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            height: 70.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              image: DecorationImage(
                                image: AssetImage(bannerImages[index]),
                                fit: BoxFit.fitHeight, // 이미지를 꽉 채우기
                              ),
                            ),
                          ),
                        ),
                      ),);
                },
              ),
            ),
            Text(
              "스토리보드 둘러보기",
              style: style.textTheme.displayLarge,
            ),
            GoAroundwidget2(),
            SizedBox(
              height: 5.h,
            ),
            YoutubeUrlWidget(),
            SizedBox(
              height: 12.h,
            
            ),
          ],
        ),
      ),
    );
  }
}
