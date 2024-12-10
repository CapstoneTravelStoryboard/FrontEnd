import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:tripdraw/config/appConfig.dart';

Future<void> updateStoryboard(int id, Map<String, dynamic> updatedData) async {
  final url = Uri.parse('${AppConfig.baseUrl}/api/v1/storyboards/$id');
  final headers = {
    'Content-Type': 'application/json',
  };

  final response = await http.patch(
    url,
    headers: headers,
    body: jsonEncode(updatedData),
  );

  if (response.statusCode != 200) {
    throw Exception('Failed to update storyboard. Status code: ${response.statusCode}');
  }
}

Future<void> updateScene(int id, Map<String, dynamic> updatedData) async {
  final url = Uri.parse('${AppConfig.baseUrl}/api/v1/storyboards/{storyboard_id}/scenes/{$id}');
  final headers = {
    'Content-Type': 'application/json',
  };

  final response = await http.patch(
    url,
    headers: headers,
    body: jsonEncode(updatedData),
  );

  if (response.statusCode != 200) {
    throw Exception('Failed to update storyboard. Status code: ${response.statusCode}');
  }
}
