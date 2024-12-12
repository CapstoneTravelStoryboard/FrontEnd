import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tripdraw/View/Archive/archiveView.dart';

import '../api test/archiveApi.dart';
import 'package:tripdraw/style.dart' as style;

class TripTile extends StatelessWidget {
  final String title;
  final String date;
  final String imageUrl;
  final VoidCallback onTap;
  final VoidCallback onDelete; // 삭제 콜백 추가
  final bool isStoryboard;
  final int storyboardId;
  final int id;

  const TripTile({
    Key? key,
    required this.title,
    required this.date,
    required this.imageUrl,
    required this.onTap,
    required this.onDelete, // onDelete 전달받음
    required this.isStoryboard,
    required this.storyboardId,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 2.w),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.r),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 5,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              SizedBox(width: 15.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      date,
                      style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                    ),
                    // Text(
                    //   destination,
                    //   style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                    // ),
                  ],
                ),
              ),
              SizedBox(width: 10.w),
              PopupMenuButton<String>(
                icon: Icon(Icons.more_vert),
                onSelected: (value) async {
                  if (value == 'edit') {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        TextEditingController titleController =
                            TextEditingController(text: title);
                        return AlertDialog(
                          title: Text(
                            '제목 수정',
                            style: style.textTheme.bodyMedium,
                          ),
                          content: TextField(
                            controller: titleController,
                            decoration: InputDecoration(
                              hintText: '새 제목을 입력하세요',
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3.r),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('취소'),
                            ),
                            TextButton(
                              onPressed: () async {
                                String newTitle = titleController.text;

                                if (newTitle.isNotEmpty) {
                                  print('수정된 제목: $newTitle');
                                  // 실제 API 호출은 아래와 같이 주석 처리된 부분을 사용하세요.
                                  // await _updateTitle(newTitle);

                                  Navigator.of(context).pop();
                                  Get.snackbar(
                                    '완료',
                                    '제목이 성공적으로 수정되었습니다!',
                                  );
                                } else {
                                  Get.snackbar(
                                    '오류',
                                    '제목을 입력해주세요.',
                                  );
                                }
                              },
                              child: Text('확인'),
                            ),
                          ],
                        );
                      },
                    );
                  } else if (value == 'delete') {
                    onDelete(); // 삭제 콜백 호출
                  }

                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'edit',
                    child: Text('수정하기'),
                  ),
                  PopupMenuItem(
                    value: 'delete',
                    child: Text('삭제하기'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

// 실제 API 호출 함수
  Future<void> _updateTitle(String newTitle) async {
    final id = 123; // 여기서 id 값을 실제로 전달받아 사용하세요.
    final url = Uri.parse('https://your-api-domain.com/api/v1/trip/$id');
    final headers = {'Content-Type': 'application/json'};
    final body = {'title': newTitle};

    // 아래는 HTTP PATCH 요청 샘플입니다.
    // try {
    //   final response = await http.patch(
    //     url,
    //     headers: headers,
    //     body: jsonEncode(body),
    //   );

    //   if (response.statusCode != 200) {
    //     throw Exception('Failed to update title');
    //   }
    // } catch (e) {
    //   print('Error updating title: $e');
    //   Get.snackbar('오류', '제목 수정에 실패했습니다.');
    // }
  }

  Future<void> _confirmDelete(BuildContext context) async {
    final Completer<void> completer = Completer<void>();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('삭제 확인'),
          content: Text('이 여행을 삭제하시겠습니까?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // 다이얼로그 닫기
                completer.complete(); // 취소한 경우에도 완료 신호를 보냄
              },
              child: Text('취소'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // 다이얼로그 닫기
                deleteTrip(id); // 삭제 수행
                completer.complete(); // 완료 신호
              },
              child: Text('삭제'),
            ),
          ],
        );
      },
    );

    // 다이얼로그가 닫힐 때까지 기다림
    return completer.future;
  }

}
