import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tripdraw/View/GenerateStoryboard/storyTextDetailView.dart';
import 'package:tripdraw/View/mainView.dart';
import 'package:tripdraw/config/appConfig.dart';
import '../../api test/generatesb_api_func.dart';
import '../../data/dummyJson2.dart';
import '../../data/stroyboard_data.dart';
import 'package:tripdraw/style.dart' as style;

import '../Archive/archiveView.dart';
import '../Archive/sceneListView.dart';
import 'package:http/http.dart' as http;

import '../homeView.dart';
class StoryTextGenerationView extends StatefulWidget {
  final String companions;
  final int? selectedLandmark;
  final int startDate;
  final int endDate;
  final String themes;
  final String season;
  final String? intro;
  final String? outro;
  final List<String> storyboardData;

  const StoryTextGenerationView({
    Key? key,
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
  bool isProcessing = false;

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> sceneList =
        widget.storyboardData.isNotEmpty
            ? widget.storyboardData
                .map((data) => jsonDecode(data) as Map<String, dynamic>)
                .toList()
            : (storyboard1_1['sceneList'] as List<Map<String, dynamic>>? ?? []);

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
              onPressed: () {
                if (sceneList.isEmpty) {
                  Get.snackbar('오류', '장면 데이터가 없습니다.');
                  return;
                }
                if (isProcessing) {
                  Get.snackbar('알림', '이미지 생성이 이미 진행 중입니다.');
                  return;
                }
                _startProcessingAndNavigateToArchive();
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              child: Text(
                '이미지 생성 및 스토리보드 저장',
                style: style.textTheme.headlineMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _startProcessingAndNavigateToArchive() {
    setState(() {
      isProcessing = true;
    });

    // 진행 중 알림 표시
    Get.snackbar('알림', '이미지 생성 작업이 진행 중입니다...');

    // ArchiveView로 이동
    Get.offAll(() => MainView());

    // 작업 상태를 주기적으로 확인
    _pollStoryboardStatus(123); // 여기에 실제 ID를 전달하세요.
  }

  Future<void> _pollStoryboardStatus(int storyboardId) async {
    final url =
    Uri.parse('${AppConfig.baseUrl}/api/v1/storyboards/$storyboardId/status');

    final headers = {'Content-Type': 'application/json'};

    while (isProcessing) {
      try {
        final response = await http.get(url, headers: headers);

        if (response.statusCode == 200) {
          final responseBody = jsonDecode(response.body);
          if (responseBody['status'] == true) {
            _onProcessingComplete();
            break;
          }
        } else {
          print('Failed to fetch status. Status code: ${response.statusCode}');
        }
      } catch (e) {
        print('Error checking status: $e');
      }

      // 2초마다 상태 확인
      await Future.delayed(Duration(seconds: 2));
    }
  }
  void _onProcessingComplete() {
    setState(() {
      isProcessing = false;
    });

    // 작업 완료 알림 표시
    Get.snackbar('완료', '이미지 생성이 완료되었습니다!');
  }
  void _showProgressSnackbar() async {
    while (isProcessing) {
      await Future.delayed(Duration(seconds: 2)); // 2초마다 상태 알림
      if (!isProcessing) break; // 작업 완료 시 종료
      Get.snackbar('진행 중', '이미지 생성 작업이 진행 중입니다...');
    }
  }
}
