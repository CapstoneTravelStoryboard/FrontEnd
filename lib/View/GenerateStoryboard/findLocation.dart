import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tripdraw/config/appConfig.dart';

import '../../api test/generatesb_api_func.dart';
import '../../data/local_data.dart';

class FindLocationView extends StatefulWidget {
  final int? selectedLandmark;
  final Function(int?) onLandmarkSelected; // 콜백 추가

  const FindLocationView({
    Key? key,
    required this.selectedLandmark,
    required this.onLandmarkSelected,
  }) : super(key: key);

  @override
  State<FindLocationView> createState() => _FindLocationViewState();
}
class _FindLocationViewState extends State<FindLocationView> {
  final TextEditingController _searchController = TextEditingController();
  List<String> filteredLocations = [];
  List<String> landmarks = [];
  int? selectedLandmarkID; // 변경: String -> int

  String? selectedLocation;

  @override
  void initState() {
    super.initState();
    filteredLocations = allLocation;
  }

  void _filterLocations() {
    setState(() {
      final query = _searchController.text.trim();
      if (query.isEmpty) {
        filteredLocations = allLocation;
      } else {
        filteredLocations = allLocation
            .where((location) =>
            location.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  void _selectLocation(String location) {
    setState(() {
      selectedLocation = location;
      landmarks = LocationLandmark[location] ?? [];
      selectedLandmarkID;

      // 검색 초기화
      _searchController.clear();
      filteredLocations = [];
    });
  }
  Future<void> _showLocationSearchDialog() async {
    // 다이얼로그를 열 때 항상 전체 목록을 보여줌
    setState(() {
      filteredLocations = allLocation;
      _searchController.text = selectedLocation ?? ''; // 선택된 지역을 TextField에 표시
    });

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: 300.h,
                    maxHeight: 400.h, // 다이얼로그 최대 크기 제한
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 50.h, // TextField 높이 고정
                        child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            fillColor: Colors.grey[50],
                            labelText: '시/군 검색',
                            hintText: '예: 서울특별시 강남구',
                          ),
                          onChanged: (value) {
                            setState(() {
                              _filterLocations(); // 검색 결과 필터링
                            });
                          },
                        ),
                      ),
                      // SizedBox(height: 10.h), // 검색 필드와 결과 간의 간격
                      Expanded(
                        child: filteredLocations.isEmpty
                            ? Center(
                          child: Text(
                            '검색 결과가 없습니다.',
                            style: TextStyle(color: Colors.grey),
                          ),
                        )
                            : ListView.builder(
                          itemCount: filteredLocations.length,
                          itemBuilder: (context, index) {
                            final location = filteredLocations[index];
                            return ListTile(
                              title: Text(location),
                              onTap: () {
                                _selectLocation(location);
                                Navigator.pop(context);
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  bool isLoading = false; // API 로딩 상태
  List<String> filteredLandmark = [];
  List<Map<String, dynamic>> landmarkObj = [];

  Future<void> _fetchLandmarks(String province, String district) async {
    setState(() {
      isLoading = true;
    });

    print('province:$province, district:$district');
    try {
      final response = await http.get(
        Uri.parse('${AppConfig.baseUrl}/api/v1/landmarks?province=$province&district=$district'),
      );


      if (response.statusCode == 200) {
        // final List<dynamic> data = jsonDecode(response.body);
        final decodedBody = utf8.decode(response.bodyBytes); // body 대신 bodyBytes 사용
        List<dynamic> data = jsonDecode(decodedBody);
        print(data);


        // landmarks 리스트에 id와 name 저장
        final List<Map<String, dynamic>> fetchedLandmarks = data.map((item) {
          return {
            "id": item['id'],
            "name": item['name'],
          };
        }).toList();

        print(fetchedLandmarks);

        setState(() {
          landmarkObj = fetchedLandmarks; // 전체 랜드마크 리스트
          print("랜드마크리스트 호출완료");
          filteredLandmark = fetchedLandmarks.map((e) => e['name'] as String).toList(); // name만 필터링
        });
      } else {
        throw Exception('Failed to load landmarks');
      }
    } catch (e) {
      setState(() {
        filteredLandmark = [];
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('랜드마크 데이터를 가져오는 데 실패했습니다.')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  int? getLandmarkId(String name) {
    try {
      final landmark = landmarkObj.firstWhere(
            (landmark) => landmark['name'] == name,
        orElse: () => {"id": null, "name": null},
      );
      return landmark['id'] as int?;
    } catch (e) {
      print('Error in getLandmarkId: $e');
      return null;
    }
  }


  String? getLandmarkName(int? id) {
    if (id == null) return null;

    final landmark = landmarkObj.firstWhere(
          (item) => item['id'] == id,
      orElse: () => {"id": null, "name": null}, // 빈 Map 반환
    );

    return landmark['name'] as String?;
  }



  Future<void> _showLandmarkSearchDialog() async {
    if (selectedLocation == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('먼저 지역을 선택해주세요.')),
      );
      return;
    }

    // 선택된 location을 파싱하여 province와 district로 분리
    final parts = selectedLocation!.split(' ');
    final province = parts[0].replaceAll('도', '').replaceAll('특별시', '').replaceAll('광역시', '').replaceAll('특별자치도', '');
    final district = parts.length > 1 ? parts[1] : '';

    // API 호출
    await _fetchLandmarks(province, district);

    // 다이얼로그 표시
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Padding(
                padding: EdgeInsets.all(16.0),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: 300.h,
                    maxHeight: 400.h,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 50.h,
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: '랜드마크 검색',
                            hintText: '랜드마크를 검색하세요',
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) {
                            setState(() {
                              filteredLandmark = landmarkObj
                                  .map((e) => e['name'] as String)
                                  .where((name) => name.toLowerCase().contains(value.toLowerCase()))
                                  .toList();
                            });
                          },

                        ),
                      ),
                      SizedBox(height: 16),
                      Expanded(
                        child: isLoading
                            ? Center(child: CircularProgressIndicator())
                            : filteredLandmark.isEmpty
                            ? Center(
                          child: Text(
                            '검색 결과가 없습니다.',
                            style: TextStyle(color: Colors.grey),
                          ),
                        )
                            : ListView.builder(
                          itemCount: filteredLandmark.length,
                          itemBuilder: (context, index) {
                            final landmark = filteredLandmark[index];
                            return ListTile(
                              title: Text(landmark),
                              onTap: () {
                                final selectedName = filteredLandmark[index]; // 선택된 name
                                final selectedId = getLandmarkId(selectedName); // name 기반으로 id 가져오기

                                setState(() {
                                  selectedLandmarkID = selectedId; // id 저장
                                });
                                widget.onLandmarkSelected(selectedId);

                                Navigator.pop(context);
                              },


                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    final landmarkName = getLandmarkName(selectedLandmarkID);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '여행지 찾기',
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10.h),
        Text(
          '방문하려는 관광지의 행정구역을 검색하고 선택하세요.',
          style: TextStyle(fontSize: 12.sp, color: Colors.grey),
        ),
        SizedBox(height: 10.h),
        GestureDetector(
          onTap: _showLocationSearchDialog,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  selectedLocation ?? "시/군",
                  style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                ),
                Spacer(),
                Icon(Icons.search, color: Colors.grey),
              ],
            ),
          ),
        ),
        SizedBox(height: 14.h),
        GestureDetector(
          onTap: _showLandmarkSearchDialog,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  landmarkName ?? "랜드마크 검색",
                  style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                ),
                Spacer(),
                Icon(Icons.location_on_outlined, color: Colors.grey),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
