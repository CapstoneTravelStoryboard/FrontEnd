import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tripdraw/View/Archive/emptyArchiveView.dart';
import 'package:tripdraw/View/Archive/sceneListView.dart';
import 'package:tripdraw/View/GenerateStoryboard/generateStoryboard.dart';
import 'package:tripdraw/Widget/storyboardArchiveTile.dart';
import 'package:tripdraw/controller/tokenController.dart';
import 'package:tripdraw/style.dart' as style;
import '../../config/appConfig.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class StoryBoardListView extends StatefulWidget {
  final int travelId;
  final String travelTitle;
  final List<Map<String, dynamic>> storyboards; // 추가된 파라미터


  const StoryBoardListView({
    super.key,
    required this.travelId,
    required this.travelTitle,
    required this.storyboards,
  });

  @override
  _StoryBoardListViewState createState() => _StoryBoardListViewState();
}

class _StoryBoardListViewState extends State<StoryBoardListView> {
  bool isLoading = true;
  final tokenController = Get.put(TokenController());
  @override
  void initState() {
    super.initState();
  }

  Future<void> fetchStoryboardDetails(
      int travelId, Map<String, dynamic> storyboardItem) async {
    print("onTap triggered");
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${tokenController.token.value}',
    };

    try {
      final storyboardUrl = Uri.parse(
          '${AppConfig.baseUrl}/api/v1/$travelId/storyboards/${storyboardItem['id']}');
      print('Storyboard URL: $storyboardUrl');
      final token = headers['Authorization'];
      print('Token: $token');
      final storyboardResponse = await http.get(storyboardUrl, headers: headers);
      print('Response Status: ${storyboardResponse.statusCode}');
      // print('Response Body: ${storyboardResponse.body}');
      if (storyboardResponse.statusCode == 200) {
        print('API Call Success');
        final List<dynamic> rawScenes = jsonDecode(utf8.decode(storyboardResponse.bodyBytes));

        // List<Map<String, dynamic>>로 변환
        final List<Map<String, dynamic>> scenes = rawScenes
            .map((scene) => scene as Map<String, dynamic>)
            .toList();

        print('Parsed Scenes: $scenes');

        // 각 Scene 출력 (디버깅용)
        for (var scene in scenes) {
          print('Scene ID: ${scene['sceneId']}');
          print('Order Number: ${scene['orderNum']}');
          print('Title: ${scene['title']}');
          print('Description: ${scene['description']}');
        }
        Get.to(() => SceneListView(

          isMy: false,
          description: storyboardItem['description'] ?? '',
          scenes: scenes,
          storyboardTitle: storyboardItem['title'],
          storyboardId: storyboardItem['id'],
        ));
      } else {
        print('API Call Failed: ${storyboardResponse.statusCode}');
        throw Exception('스토리보드 상세 API 호출 실패');
      }
    } catch (e) {
      print('Error: $e');
      Get.snackbar('오류', '스토리보드 데이터를 불러오는 중 문제가 발생했습니다.');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 50.h, 20.w, 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "내 여행",
              style: style.textTheme.titleMedium,
            ),
            Text(
              "우측 아이콘을 눌러 수정할 수 있습니다.",
              style: style.textTheme.displaySmall,
            ),
            SizedBox(height: 10.h),
            Text(
              widget.travelTitle,
              style: style.textTheme.titleSmall,
            ),
            Expanded(
              child: widget.storyboards.isEmpty
                  ? EmptyArchiveView(travelId: widget.travelId)
                  : ListView.builder(
                itemCount: widget.storyboards.length,
                itemBuilder: (context, index) {
                  final storyboardItem = widget.storyboards[index];
                  return StoryBoardArchiveTile(
                    isMy: true,
                    title: storyboardItem['title'].toString(),
                    start_date: storyboardItem['startDate']?.split('T').first ?? '',
                    destination: storyboardItem['landmarkInfo'].toString(),
                    onDelete: (deletedStoryboardId) {
                      setState(() {
                        widget.storyboards.removeWhere((item) => item['id'] == deletedStoryboardId);
                      });
                    },
                    onTap: () => fetchStoryboardDetails(widget.travelId, storyboardItem),
                    thumbnaili:
                    'https://trip-sculptor-images.s3.ap-northeast-2.amazonaws.com/images/storyboard/${storyboardItem['id']}/1.jpg',
                    isStoryboard: true,
                    storyboardId: index, tripid: widget.travelId,
                  );
                },
              ),

            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.to(() => GenerateStoryboardView(travelId: widget.travelId));
        },
        label: Text('${widget.travelTitle}에 새 여행지 추가'),
        icon: Icon(Icons.add),
        backgroundColor: style.mainColor,
      ),
    );
  }
}
