import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tripdraw/View/Archive/emptyArchiveView.dart';
import 'package:tripdraw/View/Archive/sceneListView.dart';
import 'package:tripdraw/View/GenerateStoryboard/generateStoryboard.dart';
import 'package:tripdraw/Widget/storyboardArchiveTile.dart';
import 'package:tripdraw/style.dart' as style;
import '../../data/dummyJson2.dart';
import 'package:get/get.dart';

class StoryBoardListView extends StatelessWidget {
  final int travelId;
  final String travelTitle;

  const StoryBoardListView({
    super.key,
    required this.travelId,
    required this.travelTitle,
  });

  @override
  Widget build(BuildContext context) {
    // Travel ID에 따라 StoryboardList를 가져옴
    final selectedTravel = travelList.firstWhere(
      (travel) => travel['trip_id'] == travelId,
      orElse: () => {},
    );

    // 선택된 여행의 storyboardList를 가져옴
    final List<Map<String, Object>> StoryboardList = selectedTravel.isNotEmpty
        ? (selectedTravel['storyboardList'] as List<dynamic>)
            .map((e) => Map<String, Object>.from(e as Map))
            .toList()
        : [];

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 50.h, 20.w, 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 상단 텍스트
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
              travelTitle,
              style: style.textTheme.titleSmall,
            ),
            // Storyboard 리스트 출력
            Expanded(
              child: StoryboardList.isEmpty
                  ? EmptyArchiveView()
                  : ListView.builder(
                      itemCount: StoryboardList.length,
                      itemBuilder: (context, index) {
                        final storyboardItem = StoryboardList[index];
                        return StoryBoardArchiveTile(
                          isMy: true,
                          title: storyboardItem['title'].toString(),
                          start_date: storyboardItem['start_date'].toString(),
                          destination: storyboardItem['destination'].toString(),
                          imageUrl: '',
                          // 이미지 URL이 없는 경우 빈 문자열
                          onTap: () async {
                            try {
                              // API 호출 (현재 주석 처리)
                              /*
                        final response = await http.get(
                          Uri.parse('https://your-api-domain.com/api/v1/storyboards/${storyboardItem['storyboard_id']}'),
                        );

                        if (response.statusCode == 200) {
                          final Map<String, dynamic> storyboardDetails = jsonDecode(response.body);
                          Get.to(() => SceneListView(
                                storyboardId: storyboardDetails['id'] as int,
                                travelTitle: travelTitle,
                                storyboardTitle: storyboardDetails['title'].toString(),
                                scenes: (storyboardDetails['scenes'] as List<dynamic>)
                                    .map((scene) => scene as Map<String, dynamic>)
                                    .toList(),
                              ));
                        } else {
                          Get.snackbar('오류', '스토리보드 데이터를 불러오는 데 실패했습니다.');
                        }
                        */
                              // 임시 이동 (주석을 해제하면 API 데이터를 사용하여 이동)
                              Get.to(() => SceneListView(
                                    storyboardId:
                                        storyboardItem['storyboard_id'] as int,
                                    travelTitle: travelTitle,
                                    storyboardTitle:
                                        storyboardItem['title'].toString(),
                                    scenes: storyboardItem['scenesList']
                                        as List<Map<String, dynamic>>,
                                    isMy: true,
                                  ));
                            } catch (e) {
                              Get.snackbar(
                                  '오류', '스토리보드 데이터를 불러오는 중 문제가 발생했습니다.');
                            }
                          },

                          isStoryboard: true,
                          storyboardId: index,
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 10.w, 30.h), // 버튼을 위로 50.h 이동
        child: FloatingActionButton.extended(
          onPressed: () {
            print('{$travelTitle}에 여행지 추가');
            Get.to(() => GenerateStoryboardView());
          },
          label: Text(
            '$travelTitle에 새 여행지 추가',
            style: TextStyle(fontSize: 14.sp),
          ),
          icon: Icon(Icons.add),
          backgroundColor: style.mainColor,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
