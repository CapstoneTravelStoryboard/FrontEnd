import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tripdraw/style.dart' as style;

class CameraGuideView extends StatefulWidget {
  @override
  _CameraGuideViewState createState() => _CameraGuideViewState();
}

class _CameraGuideViewState extends State<CameraGuideView> {
  // 각 요소의 펼침 상태를 관리하는 리스트
  List<bool> _isExpandedList = [false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.w, 50.h, 20.w, 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "영상을 구성하는\n네 가지 요소",
                        style: TextStyle(
                            fontSize: 18.sp, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        ': 앵글, 화각, 샷, 무빙',
                        style: style.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  SizedBox(width: 115.w,),
                  Container(
                    height: 65.h,
                    child: Image.asset(
                      'images/character2.png',
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ],
              ),

                  Text(
                    '각 패널을 터치하면 설명을 볼 수 있습니다',
                    style: TextStyle(fontSize: 13.sp, color: Colors.grey),
                  ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      buildElement(
                        index: 0,
                        backgroundColor: Colors.pink[100],
                        title: '아래에서? 위에서?',
                        description: '각도를 결정하는 ',
                        concept: '앵글',
                        hashtags: '#오버헤드 #로우 #아이레벨',
                        detailContent: Container(
                          child: Column(children: [],),
                        )

                      ),
                      buildElement(
                        index: 1,
                        backgroundColor: Colors.grey[300],
                        title: '얼만큼 볼건가요?',
                        description: '시야 폭, ',
                        concept: '화각',
                        hashtags: '#광각_24 #표준_50 #초망원_200',
                        detailContent: '화각은 장면의 전체 또는 일부를 어떻게 보여줄지를 결정합니다.',
                      ),
                      buildElement(
                        index: 2,
                        backgroundColor: Colors.blue[100],
                        title: '어느 각도에서 얼만큼?',
                        description: '앵글과 화각의 조합 ',
                        concept: '샷',
                        hashtags: '#롱샷 #클로즈업 #오버더숄더',
                        detailContent: '샷은 앵글과 화각의 조합으로 장면을 정의합니다.',
                      ),
                      buildElement(
                        index: 3,
                        backgroundColor: Colors.orange[200],
                        title: '끝에는 반드시 피사체가 있다',
                        description: '카메라의 움직임 ',
                        concept: '무빙',
                        hashtags: '#줌인 #줌아웃 #트래킹 #팬',
                        detailContent: '무빙은 카메라가 움직이는 방식을 나타냅니다.',
                      ),
                      buildElement(
                        index: 4,
                        backgroundColor: Colors.yellow[200],
                        title: '아는만큼 보이는',
                        description: '그 밖의 촬영 용어',
                        concept: '',
                        hashtags: '#프레임 #씬 #미장센 #롱테이크',
                        detailContent: '프레임, 씬, 미장센은 촬영에서 중요한 개념입니다.',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildElement({
    required int index,
    required Color? backgroundColor,
    required String title,
    required String description,
    required String concept,
    required String hashtags,
    required dynamic detailContent, // String 또는 Widget 허용
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpandedList[index] = !_isExpandedList[index];
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        width: double.infinity,
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.symmetric(vertical: 4.h),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: style.textTheme.bodySmall,
            ),
            Row(
              children: [
                Text(
                  description,
                  style: style.textTheme.titleSmall,
                ),
                Text(
                  concept,
                  style: style.textTheme.displayLarge,
                ),
              ],
            ),
            Text(
              hashtags,
              style: style.textTheme.labelLarge,
            ),
            // 세부 내용을 애니메이션으로 펼치기
            if (_isExpandedList[index]) // 펼침 여부에 따라 표시
              Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Text(
                  detailContent,
                  style: TextStyle(fontSize: 14.sp, color: Colors.black),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
