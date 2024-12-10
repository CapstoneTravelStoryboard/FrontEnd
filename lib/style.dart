import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const Color mainColor = Colors.blueAccent;
const Color mainGradientColor = Color(0xFFB3DEFF);
const Color pointColor = Color(0xFFCC2036);
const Color basicGray = Color(0x7F000000);
var textTheme = TextTheme(
  //퀴즈
  titleLarge : TextStyle(fontSize: 26.sp, fontFamily: 'NotoSansCJK',color: Colors.black),
  titleMedium: TextStyle(fontSize: 20.sp, color: Colors.black),
  titleSmall: TextStyle(fontSize: 16.sp, fontFamily: 'NotoSansCJK',color: Colors.black),

  headlineMedium: TextStyle(fontSize: 15.sp,fontFamily: 'NotoSansCJK',color: Colors.white),
  displaySmall: TextStyle(fontSize: 10.sp, fontFamily: 'NotoSansCJK',color: basicGray),
  displayMedium: TextStyle(fontSize: 15.sp, fontFamily: 'NotoSansCJK',color: basicGray),
  displayLarge: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600,color: Colors.black),
  labelLarge: TextStyle(fontSize: 13.sp, fontFamily: 'NotoSansCJK',fontStyle: FontStyle.normal),
  bodyMedium: TextStyle(fontSize: 15.sp,fontFamily: 'NotoSansCJK', fontWeight: FontWeight.w400, color: Colors.black, ),
  bodySmall: TextStyle(fontSize: 14.sp, fontFamily: 'NotoSansCJK',color: Colors.black),
);

var theme = ThemeData(
  primaryColor: mainColor, // 메인 색상
  colorScheme: const ColorScheme.light(
    primary: mainColor,
    secondary: mainGradientColor,
    onPrimary: Colors.white,
    onSecondary: Colors.black,
  ),
  appBarTheme: const AppBarTheme(
    color: Colors.black,
    elevation: 1,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 25,
      fontWeight: FontWeight.w500,
    ),
    actionsIconTheme: IconThemeData(color: Colors.black),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor: Colors.black,
    unselectedItemColor: Colors.grey, // 선택되지 않은 아이템 색상
  ),
  splashColor: Colors.transparent, // 기본 스플래시 효과 제거
  highlightColor: Colors.transparent, // 하이라이트 효과 제거
);
