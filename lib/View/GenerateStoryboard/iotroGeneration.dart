import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tripdraw/View/GenerateStoryboard/storyTextGenerationView.dart';
import 'package:tripdraw/data/stroyboard_data.dart';
import 'package:tripdraw/style.dart' as style;

import '../../api test/generatesb_api_func.dart';
import '../../data/dummyJson.dart';

class IotroGeneration extends StatefulWidget {
  final String companions;
  final int? selectedLandmarkId;
  final int startDate;
  final int endDate;
  final String purpose;
  final String season;
  final String? selectedTitle;
  final List<String> introList;
  final List<String> outroList;

  const IotroGeneration({
    Key? key,
    required this.companions,
    required this.selectedLandmarkId,
    required this.startDate,
    required this.endDate,
    required this.purpose,
    required this.season,
    required this.selectedTitle,
    required this.introList,
    required this.outroList,
  }) : super(key: key);

  @override
  _IotroGenerationState createState() => _IotroGenerationState();
}

class _IotroGenerationState extends State<IotroGeneration>
    with TickerProviderStateMixin {
  String? selectedIntro;
  String? selectedOutro;
  final List<String> intro = intros;
  final List<String> outro = outros;
  List<bool> isVisible = [false, false, false, false, false];
  final PageController _pageController = PageController();

  bool isLoading = false; // 로딩 상태 추가

  void nextStep() async {
    setState(() {
      isLoading = true; // 로딩 시작
    });

    final body = {
      'companions': widget.companions,
      'start_date': widget.startDate,
      'season': widget.season,
      'purpose': widget.purpose,
      'title': widget.selectedTitle,
      'intro': selectedIntro,
      'outro': selectedOutro,
      'landmark': widget.selectedLandmarkId,
    };

    try {
      final response = await sendDataForStoryboardTxt(body);

      setState(() {
        isLoading = false; // 로딩 종료
      });

      if (response.isNotEmpty) {
        Get.to(() => StoryTextGenerationView(
          companions: widget.companions,
          selectedLandmark: widget.selectedLandmarkId,
          startDate: widget.startDate,
          endDate: widget.endDate,
          themes: widget.purpose,
          season: widget.season,
          intro: selectedIntro,
          outro: selectedOutro,
          storyboardData: response,
        ));
      } else {
        print('응답 데이터가 비어있음');
        // Empty response 처리
      }
    } catch (e) {
      setState(() {
        isLoading = false; // 로딩 종료
      });
      print('POST 요청 중 오류 발생: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 5), () {
      setState(() {
        isVisible = [true, true, true, true, true];
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(
        child: CircularProgressIndicator(), // 로딩 중 표시
      )
          : Padding(
        padding: EdgeInsets.fromLTRB(16.w, 50.h, 20.w, 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '스토리보드 생성',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              '원하는 인트로와 아웃트로를 선택해주세요',
              style: style.textTheme.displayMedium,
            ),
            SizedBox(height: 10.h),
            Expanded(
              child: PageView(
                controller: _pageController,
                children: [
                  buildIntroSelection(),
                  buildOutroSelection(),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                // Action for reloading or regenerating titles
              },
            ),
            SizedBox(height: 20.h),
            ElevatedButton(
              onPressed: (selectedIntro != null && selectedOutro != null)
                  ? nextStep
                  : null,
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                backgroundColor:
                (selectedIntro != null && selectedOutro != null)
                    ? Colors.blue
                    : Colors.grey,
                foregroundColor: Colors.white,
              ),
              child: Text('스토리보드 생성'),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildIntroSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '인트로',
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: intros.length,
            itemBuilder: (context, index) {
              return buildSelectionTile(
                text: intros[index],
                isSelected: selectedIntro == intros[index],
                onTap: () {
                  setState(() {
                    selectedIntro = intros[index];
                    _pageController.animateToPage(
                      1,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeOut,
                    );
                  });
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget buildOutroSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '아웃트로',
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: outros.length,
            itemBuilder: (context, index) {
              return buildSelectionTile(
                text: outros[index],
                isSelected: selectedOutro == outros[index],
                onTap: () {
                  setState(() {
                    selectedOutro = outros[index];
                  });
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget buildSelectionTile({
    required String text,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 8.w),
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 13.w),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.white,
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
          text,
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
