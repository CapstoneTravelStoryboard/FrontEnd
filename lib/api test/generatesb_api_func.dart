import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:tripdraw/config/appConfig.dart';


Future<List<String>> fetchThemesFromAPI(String url) async {
  try {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final decodedBody = jsonDecode(utf8.decode(response.bodyBytes));

      // Assuming the API returns a list of strings
      if (decodedBody is List) {
        return decodedBody.map((e) => e.toString()).toList();
      } else {
        throw Exception('Invalid response format');
      }
    } else {
      throw Exception('Failed to fetch themes');
    }
  } catch (e) {
    throw Exception('Error while fetching themes: $e');
  }
}

Future<List<String>> sendDataForTitle(Map<String, dynamic> body) async {
  final url = Uri.parse(
      '${AppConfig.baseUrl}/api/v1/recommendations/titles');

  try {
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        "ngrok-skip-browser-warning": "69420"
      },
      body: json.encode(body),
    );

    if (response.statusCode == 200) {
      // 응답 데이터를 JSON으로 디코드 후 String List로 변환
      // final responseData = json.decode(response.body);
      final decodedBody = utf8.decode(response.bodyBytes); // body 대신 bodyBytes 사용
      final responseData = jsonDecode(decodedBody);
      List<String> result =
          List<String>.from(responseData.map((item) => item.toString()));
      print('응답 데이터: $result');
      return result;
    } else {
      print('오류: ${response.statusCode}');
      return [];
    }
  } catch (e) {
    print('예외 발생: $e');
    return [];
  }
}



Future<List<String>> sendDataForStoryboardTxt(Map<String, dynamic> body) async {
  final url = Uri.parse('${AppConfig.baseUrl}/api/v1/storyboads');

  try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(body),
    );

    if (response.statusCode == 200) {
      // 응답 데이터를 JSON으로 디코드 후 String List로 변환
      final responseData = json.decode(response.body);
      List<String> result =
          List<String>.from(responseData.map((item) => item.toString()));
      print('응답 데이터: $result');
      return result;
    } else {
      print('오류: ${response.statusCode}');
      return [];
    }
  } catch (e) {
    print('예외 발생: $e');
    return [];
  }
}

Future<void> simulateApiCall() async {
  await Future.delayed(Duration(seconds: 5)); // 5초 대기 후 완료 상태 반환
}
