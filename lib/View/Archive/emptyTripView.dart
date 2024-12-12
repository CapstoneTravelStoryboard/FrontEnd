import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tripdraw/View/GenerateStoryboard/generateStoryboard.dart';
import 'package:tripdraw/style.dart' as style;
import 'package:lottie/lottie.dart';

import '../../Widget/newStoryboardButton.dart';


class EmptyTripView extends StatelessWidget {
  const EmptyTripView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(

      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
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
  }
}
