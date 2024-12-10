import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tripdraw/View/Archive/emptyArchiveView.dart';
import 'package:tripdraw/View/Archive/stroyboardListView.dart';
import 'package:tripdraw/View/GenerateStoryboard/generateTravelView.dart';
import 'package:tripdraw/Widget/storyboardArchiveTile.dart';
import 'package:tripdraw/style.dart' as style;
import 'package:http/http.dart' as http;

import '../../Widget/tripTile.dart';
import '../../data/dummyJson2.dart';

class ArchiveView extends StatefulWidget {
  const ArchiveView({super.key});

  @override
  State<ArchiveView> createState() => _ArchiveViewState();
}

class _ArchiveViewState extends State<ArchiveView> {
  List<Map<String, dynamic>> tripList = travelList; // 초기 travelList
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTravelList();
  }

  Future<void> _loadTravelList() async {
    try {
      // 기존 dummy data를 초기값으로 설정
      setState(() {
        travelList = travelList;
        isLoading = true;
      });

      // API 호출
      final response = await http.get(
        Uri.parse('https://your-api-domain.com/api/v1/trips'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> apiTravelList = jsonDecode(response.body);
        setState(() {
          tripList = apiTravelList
              .map((item) => item as Map<String, dynamic>)
              .toList();
          isLoading = false;
        });
      } else {
        tripList = travelList;
        setState(() {
          isLoading = false; // 오류 시 로딩 해제
        });
        Get.snackbar('오류', '여행 데이터를 불러오는 데 실패했습니다.');
      }
    } catch (e) {
      tripList = travelList;
      setState(() {
        isLoading = false; // 오류 시 로딩 해제
      });
      Get.snackbar('오류', '여행 데이터를 불러오는 중 문제가 발생했습니다.');
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
            SizedBox(height: 8.h),
            Text(
              '그동안 등록한 여행 목록입니다 :)',
              style: TextStyle(fontSize: 12.sp, color: Colors.grey),
            ),
            SizedBox(height: 8.h),
            Expanded(
              child: isLoading
                  ? Center(
                child: CircularProgressIndicator(), // 로딩 중 상태 표시
              )
                  : tripList.isEmpty
                  ? EmptyArchiveView()
                  : ListView.builder(
                physics:
                const NeverScrollableScrollPhysics(), // 부모 스크롤과 충돌 방지
                shrinkWrap: true, // ListView 높이 축소
                itemCount: tripList.length,
                itemBuilder: (context, index) {
                  final travel = tripList[index];
                  return TripTile(
                    title: travel['title'].toString(),
                    date: travel['day_start'].toString(),
                    destination: (travel['destination_list']
                    as List<String>)
                        .join(', '),
                    imageUrl: '',
                    onTap: () async {
                      try {
                        // API 호출 (현재 주석 처리)
                        /*
                        final response = await http.get(
                          Uri.parse('https://your-api-domain.com/api/v1/storyboards?trip_id=${travel['trip_id']}'),
                        );

                        if (response.statusCode == 200) {
                          final List<dynamic> storyboards = jsonDecode(response.body);
                          Get.to(() => StoryBoardListView(
                                travelId: travel['trip_id'],
                                travelTitle: travel['title'].toString(),
                                storyboardList: storyboards.map((item) => item as Map<String, dynamic>).toList(),
                              ));
                        } else {
                          Get.snackbar('오류', '스토리보드를 불러오는 데 실패했습니다.');
                        }
                        */
                        // 임시 이동
                        Get.to(() => StoryBoardListView(
                          travelId: travel['trip_id'],
                          travelTitle: travel['title'].toString(),
                        ));
                      } catch (e) {
                        Get.snackbar('오류', '스토리보드 데이터를 불러오는 중 문제가 발생했습니다.');
                      }
                    },

                    isStoryboard: false, storyboardId: index,
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 10.w, 30.h),
        child: FloatingActionButton.extended(
          onPressed: () {
            Get.to(() => GenerateTravelView());
          },
          label: Text(
            '새 여행기록 추가',
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
