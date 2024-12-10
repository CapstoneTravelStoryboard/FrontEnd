import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../api test/modifyApi.dart';

class StoryTextDetailView extends StatefulWidget {
  final String title;
  final Map<String, dynamic> detail;

  StoryTextDetailView({required this.title, required this.detail});

  @override
  _StoryTextDetailViewState createState() => _StoryTextDetailViewState();
}

class _StoryTextDetailViewState extends State<StoryTextDetailView> {
  late Map<String, dynamic> detail;
  Map<String, bool> isEditing = {};

  @override
  void initState() {
    super.initState();
    detail = Map.from(widget.detail); // 원본 데이터를 보호
    isEditing = {
      'description': false,
      'camera_angle': false,
      'camera_movement': false,
      'composition': false,
    };
  }

  Future<void> _updateStoryboard() async {
    final updatedData = {
      'description': detail['description'],
      'camera_angle': detail['camera_angle'],
      'camera_movement': detail['camera_movement'],
      'composition': detail['composition'],
      'order_num': detail['order_num'],
      'sceneTitle': detail['sceneTitle'],
    };

    try {
      await updateStoryboard(detail['storyboard_id'], updatedData);
      Get.back(result: updatedData); // 수정된 데이터를 반환하고 전 화면으로 이동
    } catch (e) {
      Get.snackbar('오류', '스토리보드 업데이트 중 문제가 발생했습니다.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 50, 20, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context); // 뒤로가기
                    },
                    child: Text(
                      '뒤로가기',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  TextButton(
                    onPressed: _updateStoryboard, // 저장하기 버튼
                    child: Text(
                      '저장하기',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              ),
              Text(
                "#${detail['order_num'] ?? '순서 없음'}",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              _buildEditableField(
                fieldKey: 'description',
                title: '영상',
                hint: '설명이 없습니다.',
              ),
              SizedBox(height: 16),
              _buildEditableField(
                fieldKey: 'camera_angle',
                title: '화각',
                hint: '화각 정보가 없습니다.',
              ),
              SizedBox(height: 16),
              _buildEditableField(
                fieldKey: 'camera_movement',
                title: '카메라 무빙',
                hint: '카메라 무빙 정보가 없습니다.',
              ),
              SizedBox(height: 16),
              _buildEditableField(
                fieldKey: 'composition',
                title: '구도',
                hint: '구도 정보가 없습니다.',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEditableField({
    required String fieldKey,
    required String title,
    required String hint,
  }) {
    return GestureDetector(
      onTap: () => setState(() {
        isEditing[fieldKey] = !(isEditing[fieldKey] ?? false);
      }),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          isEditing[fieldKey] == true
              ? TextField(
            autofocus: true,
            maxLines: null,
            keyboardType: TextInputType.multiline,
            onSubmitted: (value) {
              setState(() {
                detail[fieldKey] = value.isNotEmpty ? value : hint;
                isEditing[fieldKey] = false;
              });
            },
            controller: TextEditingController(text: detail[fieldKey] ?? ''),
            decoration: InputDecoration(
              hintText: hint,
              border: OutlineInputBorder(),
            ),
          )
              : Text(
            detail[fieldKey] ?? hint,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
