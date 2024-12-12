import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../config/appConfig.dart';
import '../controller/tokenController.dart';

final tokenController = Get.put(TokenController());

class StoryBoardArchiveTile extends StatelessWidget {
  final bool isMy;
  final String title;
  final String start_date;
  final String destination;
  final String thumbnaili;
  final VoidCallback onTap;
  final bool isStoryboard;
  final int storyboardId;
  final int tripid;
  final Function(int) onDelete; // 삭제 이벤트 콜백 추가

  const StoryBoardArchiveTile({
    Key? key,
    required this.isMy,
    required this.title,
    required this.start_date,
    required this.destination,
    required this.thumbnaili,
    required this.onTap,
    required this.isStoryboard,
    required this.storyboardId,
    required this.tripid,
    required this.onDelete, // 콜백 추가
  }) : super(key: key);

  Future<void> _deleteStoryboard(BuildContext context) async {
    final url = Uri.parse('${AppConfig.baseUrl}/api/v1/$tripid/storyboards/$storyboardId');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${tokenController.token.value}',
    };

    try {
      final response = await http.delete(url, headers: headers);
      if (response.statusCode == 200 || response.statusCode == 204) {
        Get.snackbar('삭제 완료', '스토리보드가 성공적으로 삭제되었습니다.');
        onDelete(storyboardId); // 부모 위젯에 삭제 알림
      } else {
        Get.snackbar('오류', '스토리보드를 삭제하는 데 실패했습니다.');
      }
    } catch (e) {
      print('Error deleting storyboard: $e');
      Get.snackbar('오류', '스토리보드를 삭제하는 중 문제가 발생했습니다.');
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
                _deleteStoryboard(context); // 삭제 수행
              },
              child: Text('삭제'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 4.0,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(4.0),
              child: Image.network(
                thumbnaili,
                width: 80.w,
                height: 80.w,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.image_not_supported, size: 40);
                },
              ),
            ),
            SizedBox(width: 15.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontSize: 14.sp)),
                  Text(start_date, style: TextStyle(fontSize: 12.sp)),
                  Text(destination, style: TextStyle(fontSize: 12.sp)),
                ],
              ),
            ),
            if (isMy)
              PopupMenuButton<String>(
                icon: Icon(Icons.more_vert),
                onSelected: (value) {
                  if (value == 'delete') {
                    _confirmDelete(context);
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'delete',
                    child: Text('삭제하기'),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
