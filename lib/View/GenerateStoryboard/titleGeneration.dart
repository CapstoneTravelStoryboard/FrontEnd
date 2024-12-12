import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tripdraw/api%20test/generatesb_api_func.dart';
import 'package:tripdraw/style.dart' as style;

import '../../data/dummyJson.dart';
import 'iotroGeneration.dart';

class TitleGeneration extends StatefulWidget {
  final int travelId;
  final String companions;
  final int companionCount;
  final String season;
  final int? selectedLandmark;
  final DateTime? startDate;
  final DateTime? endDate;
  final String purpose;
  final List<String> responseList; // 추가된 응답값. 제목후보들이다

  TitleGeneration({
    super.key,
    required this.travelId,
    required this.companions,
    required this.companionCount,
    required this.season,
    required this.selectedLandmark,
    required this.startDate,
    required this.endDate,
    required this.purpose,
    required this.responseList,
  });

  @override
  _TitleGenerationState createState() => _TitleGenerationState();
}

class _TitleGenerationState extends State<TitleGeneration>
    with TickerProviderStateMixin {
  String? selectedTitle;

  // titleListServer가 비어있지 않다면 titleListServer를, 그렇지 않으면 기본 titleList를 사용
  late final List<String> titleList = widget.responseList.isNotEmpty
      ? widget.responseList
      : titles;

  List<bool> isVisible = [false, false, false, false, false];

  @override
  void initState() {
    super.initState();

    // Trigger the fade-in animation for each title on screen load
    Future.delayed(Duration(milliseconds: 5), () {
      setState(() {
        isVisible = [true, true, true, true, true];
      });
    });
  }

  void nextStep() async {
    // POST 요청에 필요한 데이터 정의
    final body = {
      'selectedTitle': selectedTitle,
    };

    try {
      // sendDataForIotro 호출 및 응답 처리
      final response = await sendDataForIotro(body);
      final intros = response['intros']!;
      final outros = response['outros']!;

      // IotroGeneration으로 이동하며 데이터 전달
      Get.to(() => IotroGeneration(
        travelId : widget.travelId,
        companions: widget.companions,
        companionCount: widget.companionCount,
        selectedLandmarkId: widget.selectedLandmark,
        startDate: widget.startDate,
        endDate: widget.endDate,
        purpose: widget.purpose,
        season: widget.season,
        selectedTitle: selectedTitle,
        introList: intros,
        outroList: outros,
      ));
    } catch (e) {
      print('POST 요청 중 오류 발생: $e');
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
              '스토리보드 생성',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              '원하는 제목을 선택해주세요',
              style: style.textTheme.displayMedium,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: titleList.length,
                itemBuilder: (context, index) {
                  return AnimatedOpacity(
                    opacity: isVisible[index] ? 1.0 : 0.0,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeOut,
                    child: AnimatedSlide(
                      offset: isVisible[index] ? Offset(0, 0) : Offset(0, 0.2),
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeOut,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedTitle = titleList[index];
                          });
                        },
                        child: TweenAnimationBuilder(
                          tween: Tween<double>(
                              begin: 1.0,
                              end: selectedTitle == titleList[index]
                                  ? 1.02
                                  : 1.0),
                          duration: Duration(milliseconds: 100),
                          builder: (context, double scale, child) {
                            return Transform.scale(
                              scale: scale,
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: 5.h),
                                padding: EdgeInsets.symmetric(
                                    vertical: 8.h, horizontal: 13.w),
                                decoration: BoxDecoration(
                                  color: selectedTitle == titleList[index]
                                      ? Colors.blue
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(6),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 4,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Text(
                                  titleList[index],
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w500,
                                    color: selectedTitle == titleList[index]
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20.h),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(10.r), // 버튼의 모서리 둥글기 조정
                        ),
                      ),
                      backgroundColor: WidgetStateProperty.resolveWith<Color>(
                            (Set<WidgetState> states) {
                          if (states.contains(WidgetState.disabled)) {
                            return Colors.grey; // 비활성화 상태일 때 배경색
                          }
                          return Colors.blue; // 활성화 상태일 때 배경색
                        },
                      ),
                      foregroundColor: WidgetStateProperty.resolveWith<Color>(
                            (Set<WidgetState> states) {
                          if (states.contains(WidgetState.disabled)) {
                            return Colors.white; // 비활성화 상태일 때 글자 색상
                          }
                          return Colors.white; // 활성화 상태일 때 글자 색상
                        },
                      ),
                    ),
                    onPressed: selectedTitle == null
                        ? null
                        : () {
                      // 버튼이 활성화된 상태일 때 실행할 동작
                      nextStep();
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      child: Text('인트로/아웃트로 생성'),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
