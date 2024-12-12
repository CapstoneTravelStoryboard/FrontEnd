import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tripdraw/View/Archive/archiveView.dart';
import 'package:tripdraw/View/GenerateStoryboard/storyTextDetailView.dart';
import 'package:tripdraw/api%20test/generatesb_api_func.dart';
import 'package:tripdraw/style.dart' as style;

class StoryTextGenerationView extends StatefulWidget {
  final int travelId;
  final String companions;
  final int? selectedLandmark;
  final DateTime? startDate;
  final DateTime? endDate;
  final String themes;
  final String season;
  final String? intro;
  final String? outro;
  final Map<String, dynamic> storyboardData; // 수정: 정확한 데이터 타입

  const StoryTextGenerationView({
    Key? key,
    required this.travelId,
    required this.companions,
    required this.selectedLandmark,
    required this.startDate,
    required this.endDate,
    required this.themes,
    required this.intro,
    required this.outro,
    required this.storyboardData,
    required this.season,
  }) : super(key: key);

  @override
  _StoryTextGenerationViewState createState() =>
      _StoryTextGenerationViewState();
}

class _StoryTextGenerationViewState extends State<StoryTextGenerationView> {
  @override
  Widget build(BuildContext context) {

    final int storyboardId = widget.storyboardData['id'];
    final List<Map<String, dynamic>> sceneList = widget.storyboardData['scenes'];

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 50.h, 20.w, 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '정보를 기반으로\n생성된 스토리보드',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            Text(
              '터치하면 수정 가능합니다',
              style: TextStyle(fontSize: 14.sp, color: Colors.grey),
            ),
            Expanded(
              child: ListView.separated(
                itemCount: sceneList.length,
                separatorBuilder: (context, index) => Divider(),
                itemBuilder: (context, index) {
                  final scene = sceneList[index];
                  return ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '#${index + 1}. ${scene['sceneTitle'] ?? '정보 없음'}',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontFamily: 'NotoSansCJK',
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          '${scene['description'] ?? '정보 없음'}',
                          style: style.textTheme.bodySmall,
                        ),
                      ],
                    ),
                    onTap: () async {
                      final updatedScene = await Get.to(
                        StoryTextDetailView(
                          title: scene['description'] ?? '정보 없음',
                          detail: scene,
                        ),
                      );

                      if (updatedScene != null) {
                        setState(() {
                          sceneList[index] = updatedScene; // 수정된 데이터 반영
                        });
                      }
                    },
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: (){
                sendDataForImageGenerate(widget.season, widget.travelId, storyboardId);
                Get.offAll(()=>ArchiveView());
                },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              child: Text('스토리보드 저장 및 이미지 생성'),
            ),
          ],
        ),
      ),
    );
  }
}
