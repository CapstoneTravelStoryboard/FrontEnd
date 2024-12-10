import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tripdraw/style.dart' as style;

import '../View/navigator/newCategory.dart';

class GoAroundwidget2 extends StatelessWidget {
  const GoAroundwidget2({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _categoryButton(input_icon: Icons.ac_unit, theme: '전체'),
          _categoryButton(input_icon: Icons.people, theme: '동행인'),
          _categoryButton(input_icon: Icons.location_on_outlined, theme: '지역'),
          _categoryButton(input_icon: Icons.sunny_snowing, theme: '계절'),
        ],
      ),
    );
  }

  Widget _categoryButton({
    required IconData input_icon,
    required String theme,
  }) {
    return GestureDetector(
      onTap: () {
        Get.to(() => NewCategoryView(
              selectedFilter: theme,
            ));
      },
      child: Container(
        width: 70.w, // 원형을 만들기 위해 동일한 width와 height 설정
        height: 65.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // 아이콘과 텍스트를 중앙 정렬
          children: [
            Icon(
              input_icon,
              size: 30.sp,
              // color: theme == '전체' ? Colors.white : Color(0XFF2266FF),
              color: theme == '전체' ? Colors.white : Color(0XFF56B1FA),
            ),
            Text(
              theme,
              style: TextStyle(
                color: theme == "전체" ? Colors.white : Color(0XFF56B1FA),
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
          color: theme == '전체' ? Color(0XFF56B1FA) : Colors.white,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), // 그림자 색상 및 투명도
              spreadRadius: 1, // 그림자 확산 정도
              blurRadius: 3, // 그림자 흐림 정도
              offset: Offset(0, 1), // 그림자 위치 (x, y)
            ),
          ],
        ),
      ),
    );
  }
}
