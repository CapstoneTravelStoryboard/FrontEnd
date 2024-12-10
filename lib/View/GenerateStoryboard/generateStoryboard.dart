import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tripdraw/View/GenerateStoryboard/companionView.dart';
import 'package:tripdraw/View/GenerateStoryboard/findLocation.dart';
import 'package:tripdraw/View/GenerateStoryboard/themeView.dart';
import 'package:tripdraw/View/GenerateStoryboard/dateSelectView.dart';
import 'package:tripdraw/View/GenerateStoryboard/titleGeneration.dart';
import 'package:get/get.dart';
import 'package:tripdraw/config/appConfig.dart';
import 'package:tripdraw/data/dummyJson.dart';

import '../../api test/generatesb_api_func.dart';

class GenerateStoryboardView extends StatefulWidget {
  const GenerateStoryboardView({super.key});

  @override
  State<GenerateStoryboardView> createState() => _GenerateStoryboardViewState();
}

class _GenerateStoryboardViewState extends State<GenerateStoryboardView> {
  int currentStep = 0;
  late int companionCount = 0;
  late String selectedCompanions = '';
  int? selectedLandmarkId;
  DateTime? startDate;
  DateTime? endDate;
  String? selectedThemes; // 사용자가 선택한 테마
  List<String> availableThemes = []; // API로부터 받아온 테마 리스트

  List<Widget> get steps => [
        CompanionView(
          initialSelection: selectedCompanions,
          onCompanionSelected: (companions) {
            setState(() {
              selectedCompanions = companions;
            });
          },
          onCompanionCountChanged: (count) {
            setState(() {
              companionCount = count;
            });
          },
        ),
        FindLocationView(
          selectedLandmark: selectedLandmarkId,
          onLandmarkSelected: (landmarkId) {
            setState(() {
              selectedLandmarkId = landmarkId;
            });
          },
        ),
        DateSelectView(
          initialStartDate: startDate,
          initialEndDate: endDate,
          onDateSelected: (start, end) {
            setState(() {
              startDate = start;
              endDate = end;
            });
          },
        ),
        ThemeView(
          responseList: availableThemes, // API로부터 받아온 리스트
          selectedTheme: selectedThemes, // 현재 선택된 테마
          onThemeSelected: (themes) {
            setState(() {
              selectedThemes = themes; // 선택된 테마 업데이트
            });
          },
        ),
      ];

  bool get isCurrentStepComplete {
    switch (currentStep) {
      case 0:
        return selectedCompanions.isNotEmpty && companionCount > 0;
      case 1:
        if (selectedLandmarkId == null) {
          selectedLandmarkId = 0;
        }
        return selectedLandmarkId != null;
      case 2:
        return startDate != null && endDate != null;
      case 3:
        return selectedThemes != ''; // 테마가 선택되었는지 확인
      default:
        return false;
    }
  }

  Future<List<String>> sendThemeList({
    required int? landmarkId, // companionCount도 지금은 사용되지 않음
  }) async {
    // 임시 데이터
    print('fail');
    final fallbackThemes = [
      '#관광',
      '#드라이브코스',
      '#신창풍차해안도로',
      '#싱계물공원',
      '#용천수',
      '#웨딩촬영',
      '#풍력발전기'
    ];

    if (landmarkId == null) {
      return fallbackThemes; // 랜드마크 ID가 없을 경우 바로 반환
    }

    final String url =
        '${AppConfig.baseUrl}/api/v1/landmarks/themes?landmarkId=$landmarkId';
    print(url);
    try {
      final responseList = await fetchThemesFromAPI(url);
      print('success');
      return responseList; // 성공 시 응답 반환
    } catch (e) {
      print('Error while fetching themes: $e');
      return fallbackThemes; // 실패 시 임시 데이터 반환
    }
  }

  void nextStep2() async {
    if (currentStep < steps.length - 1) {
      if (currentStep == 2) {
        try {
          final responseList = await sendThemeList(
            landmarkId: selectedLandmarkId,
          );

          setState(() {
            availableThemes = responseList; // API 응답을 테마 리스트로 저장
          });
        } catch (e) {
          print('Error while fetching themes: $e');
          return;
        }
      }

      setState(() {
        currentStep++;
      });
    } else if (currentStep == steps.length - 1) {
      final realBody = {
        'landmarkId': 1,
        'purpose': selectedThemes, // 선택된 테마를 전달
        'companions': selectedCompanions,
        'companionCount': companionCount,
        'season': _getSeason(startDate!),
      };

      try {
        final List<String> responseList = await sendDataForTitle(realBody);
        print('응답: $responseList');
        Get.to(() => TitleGeneration(
              companions: selectedCompanions,
              season: _getSeason(startDate!),
              selectedLandmark: selectedLandmarkId,
              startDate: startDate!.millisecondsSinceEpoch,
              endDate: endDate!.millisecondsSinceEpoch,
              purpose: selectedThemes!,
              responseList: responseList,
            ));
      } catch (e) {
        print('POST 요청 중 오류 발생: $e');
      }
    }
  }

  String _getSeason(DateTime date) {
    final month = date.month;

    if (month >= 3 && month <= 5) {
      return '봄'; // Spring
    } else if (month >= 6 && month <= 8) {
      return '여름'; // Summer
    } else if (month >= 9 && month <= 11) {
      return '가을'; // Autumn
    } else {
      return '겨울'; // Winter
    }
  }

  void previousStep() {
    if (currentStep > 0) {
      setState(() {
        currentStep--;
      });
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
              '원하는 정보를 선택해주세요',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            SizedBox(height: 10.h),
            TweenAnimationBuilder<double>(
              tween: Tween<double>(
                  begin: currentStep / steps.length,
                  end: (currentStep + 1) / steps.length),
              duration: Duration(milliseconds: 500),
              builder: (context, value, child) {
                return LinearProgressIndicator(
                  value: value,
                  backgroundColor: Colors.grey[300],
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                );
              },
            ),
            SizedBox(height: 10.h),
            Expanded(
              child: steps[currentStep],
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
        child: Row(
          children: [
            if (currentStep > 0)
              FloatingActionButton(
                onPressed: previousStep,
                child: Icon(Icons.arrow_back),
              ),
            Spacer(),
            FloatingActionButton(
              onPressed: isCurrentStepComplete ? nextStep2 : null,
              child: Icon(Icons.arrow_forward),
              backgroundColor:
                  isCurrentStepComplete ? Colors.blue : Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
