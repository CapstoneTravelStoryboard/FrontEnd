import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tripdraw/style.dart' as style;
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../NewProject_ver2/imageDetailView.dart';

class SceneListView extends StatefulWidget {
  final bool isMy;
  final int storyboardId;
  final String travelTitle;
  final String storyboardTitle;
  final List<Map<String, dynamic>> scenes;

  const SceneListView({
    Key? key,
    required this.storyboardId,
    required this.travelTitle,
    required this.storyboardTitle,
    required this.scenes,
    required this.isMy,
  }) : super(key: key);

  @override
  State<SceneListView> createState() => _SceneListViewState();
}

class _SceneListViewState extends State<SceneListView> {
  bool isListView = true; // ListView와 GridView 전환 상태

  void editScene(int index) {
    final scene = widget.scenes[index];
    TextEditingController titleController =
        TextEditingController(text: scene['sceneTitle']);
    TextEditingController descriptionController =
        TextEditingController(text: scene['description']);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Scene'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  widget.scenes[index]['sceneTitle'] = titleController.text;
                  widget.scenes[index]['description'] =
                      descriptionController.text;
                });
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void deleteScene(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Scene'),
          content: const Text('Are you sure you want to delete this scene?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  widget.scenes.removeAt(index);
                });
                Navigator.pop(context);
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 50.h, 20.w, 16.h),
        child: Column(
          children: [
            // 상단 제목과 전환 버튼
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Flexible(
                  child: Text(
                    '${widget.travelTitle} \n  > ${widget.storyboardTitle}',
                    style: style.textTheme.bodySmall,
                    maxLines: 2, // 최대 2줄로 제한
                    overflow: TextOverflow.ellipsis, // 넘치는 텍스트는 생략 표시
                  ),
                ),
                IconButton(
                  icon: Icon(isListView ? Icons.grid_view : Icons.list),
                  onPressed: () {
                    setState(() {
                      isListView = !isListView; // View 전환
                    });
                  },
                ),
              ],
            ),
            // ListView 또는 GridView
            Expanded(
              child: isListView
                  ? ListView.builder(
                      itemCount: widget.scenes.length,
                      itemBuilder: (context, index) {
                        final scene = widget.scenes[index];
                        return GestureDetector(
                          onTap: () {
                            Get.to(
                              () => ImageDetailView(
                                isMy: widget.isMy,
                                index: index,
                                title: scene['sceneTitle'],
                                detail: scene,
                              ),
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 8.h, horizontal: 2.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    // 텍스트 영역
                                    Expanded(
                                      child: Text(
                                        '#${index + 1}. ${scene['sceneTitle'] ?? '설명 없음'}',
                                        style: style.textTheme.displayLarge,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    if (widget.isMy)
                                      GestureDetector(
                                        onTap: () async {
                                          try {
                                            // API 호출 (현재 주석 처리)
                                            /*
                                            final response = await http.delete(
                                              Uri.parse('https://your-api-domain.com/api/v1/storyboards/${widget.storyboardId}/scenes/${sceneId}'),
                                            );

                                            if (response.statusCode == 200) {
                                              Get.snackbar('성공', '삭제되었습니다.');
                                              // 추가로 필요한 동작 (예: 목록 갱신)
                                            } else {
                                              Get.snackbar('오류', '삭제에 실패했습니다.');
                                            }
                                            */
                                            // 임시 동작
                                            print(
                                                'DELETE /api/v1/storyboards/${widget.storyboardId}/scenes/${scene['scene_id']}');
                                            Get.snackbar('알림', '삭제 API 호출 (현재 주석 처리됨)');
                                          } catch (e) {
                                            Get.snackbar('오류', '삭제 요청 중 문제가 발생했습니다.');
                                          }
                                        },
                                        child: Text(
                                          "삭제",
                                          style: style.textTheme.labelMedium,
                                        ),
                                      ),

                                  ],
                                ),
                                SizedBox(height: 2.h),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // 이미지 영역
                                    Container(
                                      width: 130.w,
                                      height: 80.h,
                                      color: Colors.grey,
                                      child: scene['imageurl'] != null &&
                                              scene['imageurl']!.isNotEmpty
                                          ? Image.network(
                                              scene['imageurl']!,
                                              fit: BoxFit.cover,
                                            )
                                          : const Icon(Icons.image,
                                              color: Colors.white),
                                    ),
                                    const SizedBox(width: 10),
                                    // 텍스트 영역
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${scene['description'] ?? '설명 없음'}',
                                            style: style.textTheme.labelLarge,
                                            maxLines: 4,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  : GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // 한 줄에 표시할 아이템 개수
                        crossAxisSpacing: 10.w, // 가로 간격
                        mainAxisSpacing: 10.h, // 세로 간격
                        childAspectRatio: 10 / 9, // 카드 비율
                      ),
                      itemCount: widget.scenes.length,
                      itemBuilder: (context, index) {
                        final scene = widget.scenes[index];
                        return GestureDetector(
                          onTap: () {
                            Get.to(
                              () => ImageDetailView(
                                isMy: widget.isMy,
                                index: index,
                                title: scene['description'],
                                detail: scene,
                              ),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.all(8.w),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  blurRadius: 4,
                                  offset: Offset(0, 0), // Shadow 위치 조정
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 80.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4.r),
                                    color: Colors.grey,
                                  ),
                                  child: scene['imageurl'] != null &&
                                          scene['imageurl']!.isNotEmpty
                                      ? Image.network(
                                          scene['imageurl']!,
                                          fit: BoxFit.cover,
                                        )
                                      : const Icon(Icons.image,
                                          color: Colors.white),
                                ),
                                SizedBox(height: 8.h),
                                Text(
                                  '#${index + 1}. ${scene['sceneTitle'] ?? '설명 없음'}',
                                  style: style.textTheme.labelLarge,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.delete,
                                          color: Colors.red),
                                      onPressed: () => deleteScene(index),
                                    ),
                                  ],
                                ),
                              ],
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
}
