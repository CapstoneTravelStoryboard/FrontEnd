import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';
import 'package:tripdraw/config/appConfig.dart';

import '../controller/tokenController.dart';
final tokenController = Get.put(TokenController());
Future<void> updateScene(int storyboardId, int sceneId, Map<String, dynamic> updatedData) async {
  final url = Uri.parse('${AppConfig.baseUrl}/api/v1/storyboards/$storyboardId/scenes/$sceneId');
  final headers = {
    'Content-Type': 'application/json',
    "ngrok-skip-browser-warning": "69420",
    'Authorization': 'Bearer ${tokenController.token.value}',
  };

  final response = await http.post(
    url,
    headers: headers,
    body: jsonEncode(updatedData),
  );

  if (response.statusCode != 200) {
    throw Exception('Failed to update storyboard. Status code: ${response.statusCode}');
  }
}

Future<void> updateStoryboard(int id, Map<String, dynamic> updatedData) async {
  final url = Uri.parse('${AppConfig.baseUrl}/api/v1/storyboards/{storyboard_id}/scenes/{$id}');
  final headers = {
    'Content-Type': 'application/json',
    "ngrok-skip-browser-warning": "69420",
    'Authorization': 'Bearer ${tokenController.token.value}',
  };

  final response = await http.post(
    url,
    headers: headers,
    body: jsonEncode(updatedData),
  );

  if (response.statusCode != 200) {
    throw Exception('Failed to update storyboard. Status code: ${response.statusCode}');
  }
}
