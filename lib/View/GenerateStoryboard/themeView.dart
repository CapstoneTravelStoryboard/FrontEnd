import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ThemeView extends StatefulWidget {
  final List<String> responseList; // 부모로부터 전달받을 데이터
  final String? selectedTheme; // 부모로부터 전달받은 초기 선택된 테마
  final Function(String?) onThemeSelected;

  const ThemeView({
    Key? key,
    required this.responseList,
    required this.onThemeSelected,
    this.selectedTheme,
  }) : super(key: key);

  @override
  _ThemeViewState createState() => _ThemeViewState();
}

class _ThemeViewState extends State<ThemeView> {
  String? selectedTheme; // 현재 선택된 테마

  @override
  void initState() {
    super.initState();
    // 초기값 설정
    selectedTheme = widget.selectedTheme;
  }

  @override
  Widget build(BuildContext context) {
    // 전달받은 responseList를 사용
    final themes = widget.responseList;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '여행 테마',
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16.h),
        Wrap(
          spacing: 12.w, // 버튼 간의 가로 간격
          runSpacing: 12.h, // 줄 간의 세로 간격
          children: themes.map((themeName) {
            // 선택 상태 확인
            final isSelected = selectedTheme == themeName;

            return GestureDetector(
              onTap: () {
                setState(() {
                  // 선택된 테마 변경
                  selectedTheme = isSelected ? null : themeName;
                });
                // 선택 결과를 부모 위젯으로 전달
                widget.onThemeSelected(selectedTheme);
              },
              child: TweenAnimationBuilder(
                tween: Tween<double>(
                    begin: 1.0, end: isSelected ? 1.05 : 1.0), // 크기 애니메이션
                duration: Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                builder: (context, double scale, child) {
                  return Transform.scale(
                    scale: scale,
                    child: Container(
                      padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Colors.blueAccent
                            : Colors.grey[200], // 선택 시 배경색 변경
                        borderRadius: BorderRadius.circular(12), // 둥근 모서리
                      ),
                      child: Text(
                        themeName,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: isSelected
                              ? Colors.white
                              : Colors.black, // 선택된 항목은 흰색 텍스트
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
