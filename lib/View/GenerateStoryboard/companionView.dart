import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CompanionView extends StatefulWidget {
  final String initialSelection; // 초기 선택 상태 (단일 선택)
  final Function(int) onCompanionCountChanged; // 동행 인원 변경 시 상위로 전달
  final Function(String) onCompanionSelected; // 선택된 결과를 상위로 전달

  const CompanionView({
    Key? key,
    required this.initialSelection,
    required this.onCompanionSelected,
    required this.onCompanionCountChanged,
  }) : super(key: key);

  @override
  _CompanionViewState createState() => _CompanionViewState();
}

class _CompanionViewState extends State<CompanionView> {
  late String selectedCompanion; // 선택된 동행인
  List<bool> isVisible = []; // 각 항목의 표시 상태
  final TextEditingController companionCountController =
  TextEditingController(); // 동행인 수 입력 필드 컨트롤러
  int companionCount = 0; // 입력받은 동행인 수

  @override
  void initState() {
    super.initState();
    // 초기 선택값을 복사하여 상태로 사용
    selectedCompanion = widget.initialSelection;

    // 초기 표시 상태는 모두 숨김
    isVisible = List.generate(6, (_) => false);

    // 표시 애니메이션을 단계적으로 실행
    Future.delayed(Duration.zero, () {
      for (int i = 0; i < isVisible.length; i++) {
        Future.delayed(Duration(milliseconds: i * 100), () {
          setState(() {
            isVisible[i] = true;
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final companions = [
      {'name': '혼자', 'icon': Icons.person_outline},
      {'name': '친구', 'icon': Icons.people_outline},
      {'name': '가족', 'icon': Icons.family_restroom_outlined},
      {'name': '연인', 'icon': Icons.favorite_outline},
      {'name': '아기', 'icon': Icons.child_care},
      {'name': '반려동물', 'icon': Icons.pets},
    ];

    return Scaffold(
      resizeToAvoidBottomInset: true, // 키보드가 올라올 때 자동으로 공간 확보
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '동행인 선택',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: Colors.grey[200], // 배경색 설정
                borderRadius: BorderRadius.circular(8), // 둥근 모서리 설정
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "동행 인원(본인 포함)",
                    style: TextStyle(fontSize: 14.sp),
                  ),
                  SizedBox(width: 16.w), // Text와 TextField 사이 여백
                  Expanded(
                    child: TextField(
                      textAlign: TextAlign.right,
                      controller: companionCountController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: InputBorder.none, // 아래줄 제거
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 5.h),
                      ),
                      onChanged: (value) {
                        setState(() {
                          companionCount =
                              int.tryParse(value) ?? 0; // 입력값을 정수로 변환
                        });
                        widget
                            .onCompanionCountChanged(companionCount); // 상위로 전달
                      },
                    ),
                  ),
                  Text(
                    "명",
                    style: TextStyle(fontSize: 14.sp),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            SizedBox(
              height: 300.h,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: companions.length,
                itemBuilder: (context, index) {
                  final companionName = companions[index]['name'].toString();
                  final isSelected = selectedCompanion == companionName;

                  return AnimatedOpacity(
                    duration: Duration(milliseconds: 500),
                    opacity: isVisible[index] ? 1.0 : 0.0, // 투명도 애니메이션
                    child: AnimatedSlide(
                      duration: Duration(milliseconds: 500),
                      offset: isVisible[index]
                          ? Offset(0, 0)
                          : Offset(0, 0.3), // 위에서 아래로 슬라이드
                      curve: Curves.easeOut,
                      child: TweenAnimationBuilder<double>(
                        tween: Tween<double>(
                            begin: 1.0,
                            end: isSelected ? 1.05 : 1.0), // 크기 애니메이션
                        duration: Duration(milliseconds: 100),
                        curve: Curves.easeInOut,
                        builder: (context, scale, child) {
                          return Transform.scale(
                            scale: scale,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedCompanion = companionName; // 선택 변경
                                });
                                // 변경된 선택 상태를 상위로 전달
                                widget.onCompanionSelected(selectedCompanion);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? Colors.blue[50]
                                      : Colors.grey[200],
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: isSelected
                                        ? Colors.blue
                                        : Colors.transparent,
                                    width: 2,
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(companions[index]['icon'] as IconData,
                                        size: 40),
                                    SizedBox(height: 8),
                                    Text(companions[index]['name'].toString()),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    companionCountController.dispose();
    super.dispose();
  }
}
