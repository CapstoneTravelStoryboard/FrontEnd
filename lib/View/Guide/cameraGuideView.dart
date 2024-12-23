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
                  SizedBox(
                    width: 115.w,
                  ),
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildElement(
                          index: 0,
                          backgroundColor: Colors.pink[100],
                          title: '아래에서? 위에서?',
                          description: '각도를 결정하는 ',
                          concept: '앵글',
                          hashtags: '#오버헤드 #로우 #아이레벨',
                          detailContent: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Eye Level",
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600
                                  ),
                                ),
                                Text(
                                    "대상과 수평을 맞추는 일반적인 촬영 기법으로, 자연스럽고 중립적인 분위기를 제공합니다."),
                                Text(
                                    "High Angle",
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600
                                    )
                                ),
                                Text(
                                    "대상을 위에서 아래로 내려다보며, 피사체가 작고 초라해 보이게 합니다."),
                                Text(
                                  "Low Angle",
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600
                                  ),
                                ),
                                Text(
                                    "아래에서 위로 올려다보며, 피사체를 웅장하고 강력하게 표현합니다."),
                                Text(
                                  "Bird’s Eye View",
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600
                                  ),
                                ),
                                Text(
                                    "피사체를 위에서 내려다보는 극단적인 앵글로, 전체적인 맥락이나 위치를 보여줄 때 유용합니다."),
                                Text("Dutch Angle", style: TextStyle(
                                    fontSize: 14.sp, fontWeight: FontWeight.w600
                                ),),
                                Text(
                                    "카메라를 기울여서 긴장감과 불안감을 강조하며, 흔히 액션이나 스릴러 장면에서 사용됩니다"),
                              ],
                            ),
                          )),
                      buildElement(
                        index: 2,
                        backgroundColor: Colors.blue[100],
                        title: '어느 각도에서 얼만큼?',
                        description: '앵글과 화각의 조합 ',
                        concept: '샷',
                        hashtags: '#롱샷 #클로즈업 #오버더숄더',
                        detailContent: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Extreme Long Shot",
                                style: TextStyle(
                                    fontSize: 14.sp, fontWeight: FontWeight.w600
                                ),
                              ),
                              Text(
                                  "대상을 매우 멀리서 촬영하여 장면의 전체적인 공간을 보여줍니다. 캐릭터보다 배경을 강조할 때 사용됩니다."),
                              Text(
                                  "Long Shot",
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600
                                  )
                              ),
                              Text(
                                  "대상과 배경을 모두 담아내며, 장면의 설정을 제공합니다. 대체로 인물의 전체 신체를 포함합니다."),
                              Text(
                                "Full Shot",
                                style: TextStyle(
                                    fontSize: 14.sp, fontWeight: FontWeight.w600
                                ),
                              ),
                              Text(
                                  "인물의 머리부터 발끝까지 담아내는 샷으로, 캐릭터의 움직임과 자세를 보여줍니다."),
                              Text(
                                "Medium Shot",
                                style: TextStyle(
                                    fontSize: 14.sp, fontWeight: FontWeight.w600
                                ),
                              ),
                              Text(
                                  "인물의 머리에서 허리까지 보여주어 대화 장면이나 캐릭터 감정 표현에 적합합니다."),
                              Text("Close Up", style: TextStyle(
                                  fontSize: 14.sp, fontWeight: FontWeight.w600
                              ),),
                              Text(
                                  "인물의 얼굴이나 피사체의 중요한 부분을 확대해 표현하여 관객이 감정을 집중할 수 있도록 합니다."),
                              Text("Extreme Close Up", style: TextStyle(
                                  fontSize: 14.sp, fontWeight: FontWeight.w600
                              )),
                              Text("피사체의 세부 사항을 매우 근접하게 담아내어, 감정의 디테일을 강조합니다.")
                            ],
                          ),
                        ),
                      ),
                      buildElement(
                        index: 3,
                        backgroundColor: Colors.orange[200],
                        title: '끝에는 반드시 피사체가 있다',
                        description: '카메라의 움직임 ',
                        concept: '무빙',
                        hashtags: '#줌인 #줌아웃 #트래킹 #팬',
                        detailContent: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Dolly Shot",
                                style: TextStyle(
                                    fontSize: 14.sp, fontWeight: FontWeight.w600
                                ),
                              ),
                              Text(
                                  "카메라를 피사체에 접근하거나 멀어지게 이동시키는 기법으로, 인물의 감정이나 중요한 물체에 주목할 때 사용됩니다."
                              ),
                              Text(
                                  "Zoom",
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600
                                  )
                              ),
                              Text(
                                  "화면을 좁히거나 넓히며 피사체를 더 가까이 또는 멀리서 볼 수 있게 조정합니다. 주로 감정 변화를 강조할 때 사용됩니다."
                              ),
                              Text(
                                "Tilt",
                                style: TextStyle(
                                    fontSize: 14.sp, fontWeight: FontWeight.w600
                                ),
                              ),
                              Text(
                                  "카메라의 위치를 고정하고 렌즈를 위아래로 움직이는 기법으로, 높은 건물이나 사람을 강조할 때 사용됩니다."
                              ),
                              Text(
                                "Pan",
                                style: TextStyle(
                                    fontSize: 14.sp, fontWeight: FontWeight.w600
                                ),
                              ),
                              Text(
                                  "인물의 머리에서 허리까지 보여주어 대화 장면이나 캐릭터 감정 표현에 적합합니다."),
                              Text("Handheld", style: TextStyle(
                                  fontSize: 14.sp, fontWeight: FontWeight.w600
                              ),),
                              Text(
                                  "삼각대 없이 카메라를 직접 손으로 들고 촬영하여, 생동감과 몰입감을 줍니다. 다큐멘터리나 액션 장면에서 자주 사용됩니다."
                              ),
                            ],
                          ),
                        ),
                      ),
                      buildElement(
                        index: 4,
                        backgroundColor: Colors.grey[300],
                        title: '얼만큼 볼건가요?',
                        description: '시야 폭, ',
                        concept: '화각',
                        hashtags: '#광각_24 #표준_50 #초망원_200',
                        detailContent: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "광각렌즈 (35mm 이하)",
                                style: TextStyle(
                                    fontSize: 14.sp, fontWeight: FontWeight.w600
                                ),
                              ),
                              Text(
                                  "넓은 화각(넓은 시야)을 제공하며, 피사체와의 거리가 멀어 보이게 표현합니다."
                              ),
                              Text(
                                  "표준렌즈 (약 50mm)",
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600
                                  )
                              ),
                              Text(
                                  "사람의 눈에 가까운 자연스러운 화각을 제공합니다"
                              ),
                              Text(
                                "망원 렌즈 (70mm이상)",
                                style: TextStyle(
                                    fontSize: 14.sp, fontWeight: FontWeight.w600
                                ),
                              ),
                              Text(
                                  "좁은 화각(좁은 시야)을 제공하며, 먼 피사체를 가까이 당겨 보이게 표현합니다"
                              ),
                              Text(
                                "초광각 렌즈 (24mm 이하)",
                                style: TextStyle(
                                    fontSize: 14.sp, fontWeight: FontWeight.w600
                                ),
                              ),
                              Text(
                                  "극단적으로 넓은 화각을 제공하며, 주변을 모두 담는 느낌을 제공합니다."),
                              Text("초망원 렌즈 (300mm 이상)", style: TextStyle(
                                  fontSize: 14.sp, fontWeight: FontWeight.w600
                              ),),
                              Text(
                                  "매우 멀리 있는 피사체를 당겨서 촬영할 수 있으며 주로 천체나 야생동물, 스포츠촬영에 사용됩니다."
                              ),
                            ],
                          ),
                        ),
                      ),
                      buildElement(
                        index: 4,
                        backgroundColor: Colors.yellow[200],
                        title: '아는만큼 보이는',
                        description: '그 밖의 촬영 용어',
                        concept: '',
                        hashtags: '#프레임 #씬 #미장센 #롱테이크',
                        detailContent: Text(
                          '프레임, 씬, 미장센은 촬영에서 중요한 개념입니다.',
                        ),
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
                child: detailContent,
              ),
          ],
        ),
      ),
    );
  }
}
