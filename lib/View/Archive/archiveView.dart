import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tripdraw/View/Archive/emptyArchiveView.dart';
import 'package:tripdraw/View/Archive/emptyTripView.dart';
import 'package:tripdraw/View/Archive/stroyboardListView.dart';
import 'package:tripdraw/View/GenerateStoryboard/generateTravelView.dart';
import 'package:tripdraw/Widget/storyboardArchiveTile.dart';
import 'package:tripdraw/api%20test/load_api.dart';
import 'package:tripdraw/config/appConfig.dart';
import 'package:tripdraw/style.dart' as style;
import 'package:http/http.dart' as http;

import '../../Widget/tripTile.dart';
import '../../controller/tokenController.dart';
import '../../data/dummyJson2.dart';

class ArchiveView extends StatefulWidget {
  const ArchiveView({super.key});

  @override
  State<ArchiveView> createState() => _ArchiveViewState();
}

class _ArchiveViewState extends State<ArchiveView> {
  List<Map<String, dynamic>> tripList = []; // 초기 여행 목록
  bool isLoading = true;

  final tokenController = Get.put(TokenController());

  @override
  void initState() {
    super.initState();
    _loadTravelList();
  }

  Future<void> _loadTravelList() async {
    final token = tokenController.token.value;
    print("token: $token");
    try {
      setState(() {
        isLoading = true;
      });

      final headers = {
        'Content-Type': 'application/json',
        "ngrok-skip-browser-warning": "69420",
        'Authorization': 'Bearer $token',
      };

      // API 호출
      final response = await http.get(
        Uri.parse('${AppConfig.baseUrl}/api/v1/trips'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        print("API /trips 호출 결과: ${response.statusCode}");
        final List<dynamic> apiTravelList =
        jsonDecode(utf8.decode(response.bodyBytes));

        setState(() {
          tripList = apiTravelList
              .map((item) => item as Map<String, dynamic>)
              .toList();
          isLoading = false;
          print("tripList: $tripList");
        });
      } else {
        setState(() {
          isLoading = false;
        });
        Get.snackbar('오류', '여행 데이터를 불러오는 데 실패했습니다.');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      Get.snackbar('오류', '여행 데이터를 불러오는 중 문제가 발생했습니다.');
    }
  }

  Future<void> _deleteTrip(int tripId) async {
    final token = tokenController.token.value;
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      final url = Uri.parse('${AppConfig.baseUrl}/api/v1/trips/$tripId');
      final response = await http.delete(url, headers: headers);

      if (response.statusCode == 200 || response.statusCode == 204) {
        // 삭제 성공 시 타일 숨기기
        setState(() {
          tripList.removeWhere((trip) => trip['id'] == tripId);
        });
        Get.snackbar('완료', '여행이 성공적으로 삭제되었습니다.');
      } else {
        throw Exception('Failed to delete trip');
      }
    } catch (e) {
      Get.snackbar('오류', '여행 삭제에 실패했습니다.');
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
                child: CircularProgressIndicator(),
              )
                  : tripList.isEmpty
                  ? EmptyTripView()
                  : ListView.builder(
                itemCount: tripList.length,
                itemBuilder: (context, index) {
                  final travel = tripList[index];
                  return TripTile(
                    title: travel['title'].toString(),
                    id: travel['id'],
                    date: travel['dayStart']?.split('T').first ?? '',
                    imageUrl: '',
                    onTap: () async {
                      final headers = {
                        'Content-Type': 'application/json',
                        "ngrok-skip-browser-warning": "69420",
                        'Authorization':
                        'Bearer ${tokenController.token.value}',
                      };

                      try {
                        final response = await http.get(
                          Uri.parse(
                              '${AppConfig.baseUrl}/api/v1/${travel['id']}/storyboards'),
                          headers: headers,
                        );

                        if (response.statusCode == 200) {
                          final List<dynamic> rawData =
                          jsonDecode(utf8.decode(
                              response.bodyBytes));
                          final List<Map<String, dynamic>>
                          storyboards = rawData
                              .map((item) =>
                          item as Map<String, dynamic>)
                              .toList();

                          Get.to(() => StoryBoardListView(
                            travelId: travel['id'],
                            travelTitle: travel['title'],
                            storyboards: storyboards,
                          ));
                        } else {
                          Get.snackbar('오류', '스토리보드를 불러오는 데 실패했습니다.');
                        }
                      } catch (e) {
                        Get.snackbar('오류', '스토리보드 데이터를 불러오는 중 문제가 발생했습니다.');
                      }
                    },
                    isStoryboard: false,
                    storyboardId: index,
                    onDelete: () async {
                      await _deleteTrip(travel['id']); // 삭제 로직 전달
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
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
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
