import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tripdraw/View/Archive/sceneListView.dart';
import 'package:tripdraw/Widget/storyboardArchiveTile.dart';
import 'package:tripdraw/config/appConfig.dart';
import 'package:tripdraw/style.dart' as style;
import '../../controller/tokenController.dart';
import '../../data/dummyJson2.dart';

class NewCategoryView extends StatefulWidget {
  final String selectedFilter;

  NewCategoryView({Key? key, required this.selectedFilter}) : super(key: key);

  @override
  _NewCategoryViewState createState() => _NewCategoryViewState();
}

class _NewCategoryViewState extends State<NewCategoryView> {
  bool isListView = true; // ListView와 GridView 전환 상태
  List<Map<String, dynamic>> allStoryboards = [];
  List<Map<String, dynamic>> filteredStoryboards = [];
  String selectedFilter = '전체'; // 초기 선택 필터
  String selectedSubFilter = ''; // 초기 선택 하위 필터

  @override
  void initState() {
    super.initState();
    selectedFilter = widget.selectedFilter; // 초기 필터 상태 설정
    _fetchStoryboards();
  }

  final tokenController = Get.put(TokenController());

  String getSeason(String? startDate) {
    if (startDate == null || startDate.isEmpty) return 'Unknown';

    try {
      // DateTime으로 변환
      final date = DateTime.parse(startDate);
      final month = date.month;

      // 월에 따라 계절 반환
      if (month >= 3 && month <= 5) {
        return '봄'; // 3월, 4월, 5월
      } else if (month >= 6 && month <= 8) {
        return '여름'; // 6월, 7월, 8월
      } else if (month >= 9 && month <= 11) {
        return '가을'; // 9월, 10월, 11월
      } else {
        return '겨울'; // 12월, 1월, 2월
      }
    } catch (e) {
      print('Error parsing date: $e');
      return 'Unknown';
    }
  }

  Future<void> _fetchStoryboards() async {
    try {
      // API 호출
      final headers = {
        'Content-Type': 'application/json',
        // 'Authorization': 'Bearer $token', // 필요한 경우
      };

      final url = Uri.parse('${AppConfig.baseUrl}/api/v1/examples');
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        // 성공적으로 응답을 받은 경우
        print(response.statusCode);
        final decodedBody = utf8.decode(response.bodyBytes);
        final List<dynamic> apiData = jsonDecode(decodedBody);
        print(apiData);
        // Storyboards 데이터 처리
        setState(() {
          allStoryboards =
              apiData.map((item) => item as Map<String, dynamic>).toList();
          applyFilter(selectedFilter); // 초기 필터 적용
        });
      } else {
        // API 오류 처리
        throw Exception('API 호출 실패: 상태 코드 ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching storyboards: $e');
      // API 호출 실패 시 더미 데이터를 기본 값으로 설정
      setState(() {
        allStoryboards = travelList
            .map((travel) =>
                travel["storyboardList"] as List<Map<String, dynamic>>)
            .expand((storyboardList) => storyboardList)
            .toList();
        applyFilter(selectedFilter); // 초기 필터 적용
      });
    }
  }

  void applyFilter(String filter) {
    setState(() {
      selectedFilter = filter; // 필터 상태 업데이트
      if (filter == '전체') {
        selectedSubFilter = ''; // 하위 필터 초기화
        filteredStoryboards = allStoryboards;
      } else {
        // 하위 필터 기본 선택
        if (filter == '동행인') {
          selectedSubFilter = '가족'; // '동행인'의 첫 번째 하위 필터
        } else if (filter == '계절') {
          selectedSubFilter = '봄'; // '계절'의 첫 번째 하위 필터
        } else if (filter == '테마') {
          selectedSubFilter = '관광'; // '테마'의 첫 번째 하위 필터
        } else {
          selectedSubFilter = ''; // 하위 필터가 없는 경우 초기화
        }

        // 선택된 필터와 하위 필터를 적용
        filteredStoryboards = allStoryboards.where((storyboard) {
          if (filter == '동행인') {
            return storyboard['companions']
                    ?.toString()
                    .contains(selectedSubFilter) ??
                false;
          } else if (filter == '계절') {
            return getSeason(storyboard['startDate'])
                    .contains(selectedSubFilter) ??
                false;
          } else if (filter == '테마') {
            return storyboard['purpose']
                    ?.toString()
                    .contains(selectedSubFilter) ??
                false;
          } else {
            return storyboard['category']?.toString().contains(filter) ?? false;
          }
        }).toList();
      }
    });
  }

  Widget _buildSubFilterButtons() {
    List<String> subFilters = [];
    if (selectedFilter == '동행인') {
      subFilters = ['가족', '친구', '연인', '혼자'];
    } else if (selectedFilter == '계절') {
      subFilters = ['봄', '여름', '가을', '겨울'];
    } else if (selectedFilter == '테마') {
      subFilters = ['관광', '자연힐링', '역사여행', '아이와 함께'];
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: subFilters.map((subFilter) {
          bool isSelected = selectedSubFilter == subFilter;
          return Padding(
            padding: EdgeInsets.only(right: 8.w), // 각 버튼 간격 조정
            child: TextButton(
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2.r),
                ),
                backgroundColor:
                    isSelected ? Colors.blueAccent : Colors.grey[200],
              ),
              onPressed: () => applySubFilter(subFilter),
              child: Text(
                '# $subFilter',
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.grey,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildFilterButtons() {
    List<String> filters = ['전체', '동행인', '계절', '테마'];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: filters.map((filter) {
          bool isSelected = selectedFilter == filter;
          return Padding(
            padding: EdgeInsets.only(right: 10.w),
            child: GestureDetector(
              onTap: () => applyFilter(filter), // 필터 적용 호출
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 16.w),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.blue : Colors.grey[50],
                  borderRadius: BorderRadius.circular(2.r),
                ),
                child: Text(
                  filter,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.grey,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  void applySubFilter(String subFilter) {
    setState(() {
      selectedSubFilter = subFilter;
      filteredStoryboards = allStoryboards.where((storyboard) {
        if (selectedFilter == '동행인') {
          return storyboard['companions']?.toString().contains(subFilter) ??
              false;
        } else if (selectedFilter == '계절') {
          return storyboard['season']?.toString().contains(subFilter) ?? false;
        } else if (selectedFilter == '테마') {
          return storyboard['purpose']?.toString().contains(subFilter) ?? false;
        }
        return true;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 50.h, 20.w, 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Flexible(
                  child: Text(
                    '제작된 스토리보드',
                    style: style.textTheme.titleMedium,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            _buildFilterButtons(),
            if (selectedFilter == '동행인' ||
                selectedFilter == '계절' ||
                selectedFilter == '테마')
              _buildSubFilterButtons(),
            Expanded(
              child: ListView.builder(
                itemCount: filteredStoryboards.length,
                itemBuilder: (context, index) {
                  final storyboardItem = filteredStoryboards[index];
                  return StoryBoardArchiveTile(
                    tripid: 0,
                    isMy: false,
                    title: storyboardItem['title'].toString(),
                    start_date: storyboardItem['startDate'].toString(),
                    destination: storyboardItem['landmarkInfo'].toString(),
                    thumbnaili:
                        'https://trip-sculptor-images.s3.ap-northeast-2.amazonaws.com/images/storyboard/3/1.jpg',
                    onTap: () async {
                      try {
                        // API 호출
                        final headers = {
                          'Content-Type': 'application/json',
                          // 'Authorization': 'Bearer $token', // 필요한 경우
                        };

                        final url = Uri.parse(
                            '${AppConfig.baseUrl}/api/v1/examples/${storyboardItem['id']}');
                        final response = await http.get(url, headers: headers);

                        if (response.statusCode == 200) {
                          // 성공적으로 응답을 받은 경우
                          print(response.statusCode);
                          final decodedBody = utf8.decode(response.bodyBytes);
                          final List<dynamic> apiData = jsonDecode(decodedBody);

                          // 파싱: Map<String, dynamic> 리스트로 변환
                          final List<Map<String, dynamic>> parsedScenes =
                              apiData
                                  .map((item) => item as Map<String, dynamic>)
                                  .toList();
                          print(apiData);
                          // 디버깅 출력
                          print(parsedScenes);

                          Get.to(
                            () => SceneListView(
                              isMy: false,
                              description:
                                  storyboardItem['description'].toString(),
                              scenes: parsedScenes,
                              storyboardTitle: storyboardItem['title'],
                              storyboardId: storyboardItem['id'], // 전달된 씬 데이터
                            ),
                          );
                        } else {
                          // API 오류 처리
                          throw Exception(
                              'API 호출 실패: 상태 코드 ${response.statusCode}');
                        }
                      } catch (e) {
                        print('Error fetching storyboards: $e');
                        // API 호출 실패 시 더미 데이터를 기본 값으로 설정
                        setState(() {
                          allStoryboards = travelList
                              .map((travel) => travel["storyboardList"]
                                  as List<Map<String, dynamic>>)
                              .expand((storyboardList) => storyboardList)
                              .toList();
                          applyFilter(selectedFilter); // 초기 필터 적용
                        });
                      }
                    },
                    isStoryboard: true,
                    storyboardId: storyboardItem['id'],
                    onDelete: (int) {},
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
