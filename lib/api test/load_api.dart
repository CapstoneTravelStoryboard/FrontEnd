import 'generatesb_api_func.dart';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../config/appConfig.dart';
import '../controller/tokenController.dart';
import '../data/dummyJson2.dart';
import 'generatesb_api_func.dart';
Future<void> loadScenList(int tripid, int storyboardId) async {
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${tokenController.token.value}',
  };

  try {
    final storyboardUrl = Uri.parse(
        '${AppConfig.baseUrl}/api/v1/$tripid/storyboards/$storyboardId');

    final sceneResponse = await http
        .get(storyboardUrl, headers: headers);
    print(storyboardUrl);
    print(sceneResponse);
    if (sceneResponse.statusCode == 200) {
      print(
          'API Call Success: ${sceneResponse.statusCode}');


      final decodedSceneList = jsonDecode(utf8.decode(sceneResponse.bodyBytes));
      print(decodedSceneList); // 전체 데이터 확인

    } else {
      print(
          'API Call Failed: ${sceneResponse.statusCode}');
      throw Exception('장면 API 호출 실패');
    }
  } catch (e) {
    print('Error: $e');
    Get.snackbar(
        '오류', '스토리보드 데이터를 불러오는 중 문제가 발생했습니다.');
  }
}

Future<void> loadStoryBoardList() async {
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${tokenController.token.value}',
  };

  try {
    final response = await http.get(
      Uri.parse('${AppConfig.baseUrl}/api/v1/3/storyboards'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final List<dynamic> storyboards = jsonDecode(response.body);
      if (storyboards.isEmpty) {
        Get.snackbar('알림', '스토리보드 데이터가 없습니다.');
        print("스토리보드 데이터가 없습니다");
      } else {
        print("스토리보드 로드 성공: $storyboards");
      }
    } else if (response.statusCode == 401 || response.statusCode == 403) {
      print("토큰이 유효하지 않습니다. 다시 로그인하세요.");
      print("this is header $headers");
      // Get.offAll(() => LoginView());
    } else {
      Get.snackbar('오류', '스토리보드를 불러오는 데 실패했습니다. 상태 코드: ${response.statusCode}');
    }
  } catch (e) {
    if (e is SocketException) {
      Get.snackbar('네트워크 오류', '인터넷 연결을 확인하세요.');
    } else {
      Get.snackbar('오류', '스토리보드 데이터를 불러오는 중 문제가 발생했습니다.');
    }
  }
}