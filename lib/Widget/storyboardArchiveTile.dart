import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../View/Archive/editView.dart';

class StoryBoardArchiveTile extends StatelessWidget {
  final bool isMy;
  final String title;
  final String start_date;
  final String destination;
  final String imageUrl;
  final VoidCallback onTap;
  final bool isStoryboard;
  final int storyboardId; // 스토리보드 ID 추가

  const StoryBoardArchiveTile({
    Key? key,
    required this.isMy,
    required this.title,
    required this.start_date,
    required this.destination,
    required this.imageUrl,
    required this.onTap,
    required this.isStoryboard,
    required this.storyboardId, // ID 전달받음
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
              ClipRRect(
                borderRadius: BorderRadius.circular(4.r),
                child: imageUrl.isNotEmpty
                    ? Image.network(
                        imageUrl,
                        width: 80.w,
                        height: 80.w,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        width: 80.w,
                        height: 60.w,
                        color: Colors.grey,
                      ),
              ),
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
                      start_date,
                      style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                    ),
                    Text(
                      destination,
                      style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10.w),
              if (isMy)
                PopupMenuButton<String>(
                  icon: Icon(Icons.more_vert),
                  onSelected: (value) {
                    if (value == 'edit') {
                      Get.to(
                        () => EditView(
                          initialTitle: title,
                          initialDate: start_date,
                          initialDestination: destination,
                          onSave: (newTitle, newDate) {
                            _updateStoryboard(
                              newTitle: newTitle,
                              newDate: newDate,
                            );
                          },
                        ),
                      );
                    } else if (value == 'delete') {
                      _confirmDelete(context);
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

  Future<void> _updateStoryboard({
    required String newTitle,
    required String newDate,
  }) async {
    final url = Uri.parse('https://your-api-domain.com/api/v1/storyboards/$storyboardId');
    final headers = {'Content-Type': 'application/json'};
    final body = {
      'title': newTitle,
      'date': newDate,
    };

    try {
      final response = await http.patch(url, headers: headers, body: jsonEncode(body));

      if (response.statusCode == 200 || response.statusCode == 204) {
        Get.snackbar('완료', '스토리보드가 성공적으로 수정되었습니다!');
      } else {
        Get.snackbar('오류', '스토리보드를 수정하는 데 실패했습니다.');
      }
    } catch (e) {
      print('Error updating storyboard: $e');
      Get.snackbar('오류', '스토리보드를 수정하는 중 문제가 발생했습니다.');
    }
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('삭제 확인'),
          content: Text('이 스토리보드를 삭제하시겠습니까?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // 다이얼로그 닫기
              },
              child: Text('취소'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // 다이얼로그 닫기
                _deleteStoryboard();
              },
              child: Text('삭제'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteStoryboard() async {
    final url = Uri.parse(
        'https://your-api-domain.com/api/v1/storyboards/$storyboardId');
    final headers = {'Content-Type': 'application/json'};

    try {
      final response = await http.delete(url, headers: headers);

      if (response.statusCode == 200 || response.statusCode == 204) {
        Get.snackbar('완료', '스토리보드가 삭제되었습니다.');
      } else {
        Get.snackbar('오류', '스토리보드를 삭제하는 데 실패했습니다.');
      }
    } catch (e) {
      print('Error deleting storyboard: $e');
      Get.snackbar('오류', '스토리보드를 삭제하는 중 문제가 발생했습니다.');
    }
  }
}
