import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tripdraw/NewProject_ver2/imageDetailView.dart';
import 'package:tripdraw/data/stroyboard_data.dart';
import 'package:tripdraw/style.dart' as style;

class BuildListWidget extends StatelessWidget {
  final int length;
  final List<String> titles;
  final Map<String, dynamic> details;

  BuildListWidget(
      {super.key,
      required this.length,
      required this.titles,
      required this.details});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: length,
      separatorBuilder: (context, index) => Divider(),
      itemBuilder: (context, index) {
        return ListTile(
          leading: Container(
            width: 100.w,
            height: 70.h,
            color: Colors.grey,
          ),
          title: Text(
            '#${index + 1}. ${details['description']}', // 타이틀 추가
            style: style.textTheme.bodyMedium,
          ),
          subtitle: Text(
              '화각: ${details['cameraAngle']}\n카메라 무빙 : ${details['cameraMovement']}\n구도: ${details['composition']}'),
          // `sceneList`의 길이를 표시
          onTap: () {
            Get.to(
              ImageDetailView(
                isMy: false,
                index: index,
                title: titles[index],
                detail: details,
              ),
            );
          },
        );
      },
    );
  }
}
