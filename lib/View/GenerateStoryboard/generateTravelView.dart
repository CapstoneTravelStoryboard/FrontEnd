import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tripdraw/View/Archive/archiveView.dart';
import 'package:tripdraw/View/GenerateStoryboard/generateStoryboard.dart';
import 'package:tripdraw/style.dart' as style;

class GenerateTravelView extends StatefulWidget {
  @override
  State<GenerateTravelView> createState() => _GenerateTravelViewState();
}

class _GenerateTravelViewState extends State<GenerateTravelView> {
  final TextEditingController _titleController = TextEditingController();
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    // TextEditingController의 변화를 감지
    _titleController.addListener(() {
      setState(() {
        _isButtonEnabled = _titleController.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
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
              '여행 생성',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            Text(
              '여행 제목을 입력해주세요\n(예: 5월의 가족여행, 1주년 데이트)\n제목은 추후 수정할 수 있습니다',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.only(left: 2.w),
              child: TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: '여행 제목',
                  hintText: '여행 제목을 입력하세요',
                  hintStyle: style.textTheme.displaySmall,
                ),
              ),
            ),
            SizedBox(height: 5.h),
            GestureDetector(
              onTap: () {
                Get.to(() => GenerateStoryboardView());
              },
              child: Text(
                "기존 여행에 스토리보드를 추가하고 싶다면?",
                style: TextStyle(fontSize: 13.sp, color: style.mainColor),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: _isButtonEnabled
              ? () {
            String travelTitle = _titleController.text;
            print('입력된 제목: $travelTitle');
            Get.to(() => ArchiveView());
            //api로 새로운 여행 생성
          }
              : null, // 비활성화 상태일 때 null로 설정
          style: ElevatedButton.styleFrom(
            backgroundColor: style.mainColor,
            padding: EdgeInsets.symmetric(vertical: 14.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text(
            '여행 생성',
            style: TextStyle(fontSize: 16.sp, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
