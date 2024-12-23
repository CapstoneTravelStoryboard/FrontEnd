  import 'package:http/http.dart' as http;
  import 'dart:convert';
  import 'package:flutter/material.dart';
  import 'package:get/get.dart';

  import '../../api test/modifyApi.dart';
import '../../config/appConfig.dart';

  class StoryTextDetailView extends StatefulWidget {
    final String title;
    final int travelid;
    final int storyboardId;
    final Map<String, dynamic> detail;
    final Map<String, dynamic> decodedData;

    StoryTextDetailView(
        {required this.title, required this.detail, required this.decodedData, required this.storyboardId, required this.travelid});

    @override
    _StoryTextDetailViewState createState() => _StoryTextDetailViewState();
  }

  class _StoryTextDetailViewState extends State<StoryTextDetailView> {
    late Map<String, dynamic> detail;
    Map<String, bool> isEditing = {};
    late TextEditingController descriptionController;
    late TextEditingController cameraAngleController;
    late TextEditingController cameraMovementController;
    late TextEditingController compositionController;

    @override
    void initState() {
      super.initState();
      detail = Map.from(widget.detail); // 원본 데이터를 보호

      // 초기화
      descriptionController = TextEditingController(text: widget.decodedData['description'] ?? '');
      cameraAngleController = TextEditingController(text: widget.decodedData['cameraAngle'] ?? '');
      cameraMovementController = TextEditingController(text: widget.decodedData['cameraMovement'] ?? '');
      compositionController = TextEditingController(text: widget.decodedData['composition'] ?? '');

      isEditing = {
        'description': false,
        'camera_angle': false,
        'camera_movement': false,
        'composition': false,
      };
    }


    @override
    void dispose() {
      // 컨트롤러 해제
      descriptionController.dispose();
      cameraAngleController.dispose();
      cameraMovementController.dispose();
      compositionController.dispose();
      super.dispose();
    }

    Future<void> _updateStoryboard() async {
      final updatedData = {
        'sceneId': detail['sceneId'],
        'orderNum': detail['orderNum'],
        'title': detail['sceneTitle'],
        'description': descriptionController.text,
        'cameraAngle': cameraAngleController.text,
        'cameraMovement': cameraMovementController.text,
        'composition': compositionController.text,
      };

      try {
        // 서버에 업데이트 요청
        await updateScene(widget.storyboardId, detail['sceneId'], updatedData);
        print("Updated Data Sent to Server: $updatedData");

        // 최신 데이터를 다시 가져오기
        final storyboardUrl = Uri.parse(
            '${AppConfig.baseUrl}/api/v1/${widget.travelid}/storyboards/${widget.storyboardId}');
        final headers = {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${tokenController.token.value}',
        };
        final sceneResponse = await http.get(storyboardUrl, headers: headers);

        if (sceneResponse.statusCode == 200) {
          print('API Call Success: ${sceneResponse.statusCode}');
          final updatedSceneData =
          jsonDecode(utf8.decode(sceneResponse.bodyBytes));
          print("Updated Scene Data: $updatedSceneData");
          print("Updated Scene Data Structure: $updatedSceneData");

          // 수정된 데이터를 StoryTextGenerationView로 반환
          Get.back(result: updatedSceneData);
        } else {
          print('Failed to fetch updated scene data: ${sceneResponse.statusCode}');
          // Get.snackbar('Error', 'Failed to fetch updated scene data.');
        }
      } catch (e) {
        Get.snackbar('오류', '장면 업데이트 중 문제가 발생했습니다.');
        print('Error: $e');
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
                  "#${detail['orderNum'] ?? '순서 없음'}. ${detail['sceneTitle']}",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                _buildEditableField(
                  fieldKey: 'description',
                  title: '영상',
                  controller: descriptionController,
                ),
                SizedBox(height: 16),
                _buildEditableField(
                  fieldKey: 'camera_angle',
                  title: '화각',
                  controller: cameraAngleController,
                ),
                SizedBox(height: 16),
                _buildEditableField(
                  fieldKey: 'camera_movement',
                  title: '카메라 무빙',
                  controller: cameraMovementController,
                ),
                SizedBox(height: 16),
                _buildEditableField(
                  fieldKey: 'composition',
                  title: '구도',
                  controller: compositionController,
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
      required TextEditingController controller,
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
              controller: controller,
              onChanged: (value) {
                // 동기화
                setState(() {
                  detail[fieldKey] = value;
                });
              },
              onSubmitted: (value) {
                setState(() {
                  isEditing[fieldKey] = false;
                });
              },
              decoration: InputDecoration(
                hintText: '값을 입력하세요',
                border: OutlineInputBorder(),
              ),
            )
                : Text(
              controller.text,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      );
    }

  }
