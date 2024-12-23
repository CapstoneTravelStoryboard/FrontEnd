import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tripdraw/style.dart' as style;

import '../../NewProject_ver2/imageDetailView.dart';
import '../../config/appConfig.dart';
import '../../controller/tokenController.dart';

class SceneListView extends StatefulWidget {
  final bool isMy;
  final String description;
  final String storyboardTitle;
  final int storyboardId;
  final List<Map<String, dynamic>> scenes;

  const SceneListView({
    Key? key,
    required this.description,
    required this.scenes,
    required this.isMy,
    required this.storyboardTitle,
    required this.storyboardId,
  }) : super(key: key);

  @override
  State<SceneListView> createState() => _SceneListViewState();
}

class _SceneListViewState extends State<SceneListView> {
  late List<Map<String, dynamic>> localScenes;
  bool isListView = true;
  final tokenController = Get.put(TokenController());

  @override
  void initState() {
    super.initState();
    localScenes = List.from(widget.scenes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 50.h, 20.w, 16.h),
        child: Column(
          children: [
            // Header Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    '${widget.storyboardTitle}',
                    style: style.textTheme.bodySmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  icon: Icon(isListView ? Icons.grid_view : Icons.list),
                  onPressed: () {
                    setState(() {
                      isListView = !isListView;
                    });
                  },
                ),
              ],
            ),
            // Content Section
            Expanded(
              child: isListView ? _buildListView() : _buildGridView(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      itemCount: localScenes.length,
      itemBuilder: (context, index) {
        final scene = localScenes[index];
        print(scene);
        return GestureDetector(
          onTap: () async {
            try {
              final headers = {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer ${tokenController.token.value}',
                // 필요한 경우 추가
              };
              print(headers);
              String image_url =
                  'https://trip-sculptor-images.s3.ap-northeast-2.amazonaws.com/images/storyboard/${widget.storyboardId}/${scene['orderNum']}.jpg';
              // API 호출
              final sceneUrl = Uri.parse(
                  '${AppConfig.baseUrl}/api/v1/storyboards/${widget.storyboardId}/scenes/${scene['sceneId']}');
              print('Scene URL: $sceneUrl');

              final response = await http.get(sceneUrl, headers: headers);

              if (response.statusCode == 200) {
                print('API Call Success: ${response.statusCode}');
                final decodedData = jsonDecode(utf8.decode(response.bodyBytes));
                final cameraAngle = decodedData['cameraAngle'] ?? 'Unknown';
                final cameraMovement =
                    decodedData['cameraMovement'] ?? 'Unknown';
                final composition = decodedData['composition'] ?? 'Unknown';

                // 화면 이동 및 데이터 전달
                Get.to(() => ImageDetailView(
                      isMy: widget.isMy,
                      index: index,
                      title: scene['title'],
                      detail: scene,
                      cameraAngle: cameraAngle,
                      cameraMovement: cameraMovement,
                      composition: composition,
                      imageUrl: image_url,
                    ));
              } else {
                print('API Call Failed: ${response.statusCode}');
                Get.snackbar('Error', 'Failed to fetch scene details.');
              }
            } catch (e) {
              print('Error: $e');
              Get.snackbar(
                  'Error', 'An unexpected error occurred while fetching data.');
            }
          },
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 2.w),
            child: Row(
              children: [
                _buildImage(
                    'https://trip-sculptor-images.s3.ap-northeast-2.amazonaws.com/images/storyboard/${widget.storyboardId}/${scene['orderNum']}.jpg'),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '#${index + 1}. ${scene['title'] ?? 'No Title'}',
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        scene['description'] ?? 'No Description',
                        style: style.textTheme.labelLarge,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                if (widget.isMy)
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () => deleteScene(index),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildGridView() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10.w,
        mainAxisSpacing: 10.h,
        mainAxisExtent: 190.h, // 각 셀의 고정 높이를 지정
      ),
      itemCount: localScenes.length,
      itemBuilder: (context, index) {
        final scene = localScenes[index];
        return GestureDetector(
          onTap: () async {
            try {
              final headers = {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer ${tokenController.token.value}',
              };
              print(headers);
              final sceneUrl = Uri.parse(
                  '${AppConfig.baseUrl}/api/v1/storyboards/${widget.storyboardId}/scenes/${scene['id']}');
              print('Scene URL: $sceneUrl');

              final response = await http.get(sceneUrl, headers: headers);

              if (response.statusCode == 200) {
                print('API Call Success: ${response.statusCode}');
                final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

                // 필요한 데이터 추출
                final cameraAngle = decodedData['cameraAngle'] ?? 'Unknown';
                final cameraMovement = decodedData['cameraMovement'] ?? 'Unknown';
                final composition = decodedData['composition'] ?? 'Unknown';
                String image_url =
                    'https://trip-sculptor-images.s3.ap-northeast-2.amazonaws.com/images/storyboard/${widget.storyboardId}/${scene['orderNum']}.jpg';

                // 화면 이동 및 데이터 전달
                Get.to(() => ImageDetailView(
                  isMy: widget.isMy,
                  index: index,
                  title: scene['title'],
                  detail: scene,
                  cameraAngle: cameraAngle,
                  cameraMovement: cameraMovement,
                  composition: composition,
                  imageUrl: image_url,
                ));
              } else {
                print('API Call Failed: ${response.statusCode}');
                Get.snackbar('Error', 'Failed to fetch scene details.');
              }
            } catch (e) {
              print('Error: $e');
              Get.snackbar(
                  'Error', 'An unexpected error occurred while fetching data.');
            }
          },
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 2.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildImage(
                  'https://trip-sculptor-images.s3.ap-northeast-2.amazonaws.com/images/storyboard/${widget.storyboardId}/${scene['orderNum']}.jpg',
                ),
                SizedBox(height: 8.h),
                Text(
                  '#${index + 1}. ${scene['title'] ?? 'No Title'}',
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 5.h),
                Text(
                  scene['description'] ?? 'No Description',
                  style: style.textTheme.labelLarge,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                if (widget.isMy)
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => deleteScene(index),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildImage(String? imageUrl) {
    if (imageUrl == null || imageUrl.isEmpty) {
      return Container(
        width: 130.w,
        height: 80.h,
        color: Colors.grey,
        child: Icon(Icons.image_not_supported, color: Colors.white),
      );
    }

    return Image.network(
      imageUrl,
      width: 130.w,
      height: 80.h,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        print('Error loading image: $imageUrl');
        return Container(
          width: 130.w,
          height: 80.h,
          color: Colors.grey,
          child: Icon(Icons.image_not_supported, color: Colors.white),
        );
      },
    );
  }

  void deleteScene(int index) {
    setState(() {
      localScenes.removeAt(index);
    });
  }
}
