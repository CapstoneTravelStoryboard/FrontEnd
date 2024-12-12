import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:tripdraw/config/appConfig.dart';

import '../controller/tokenController.dart';

final tokenController = Get.put(TokenController());

Future<List<String>> fetchThemesFromAPI(String url) async {
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${tokenController.token.value}',
  };
  try {
    final response = await http.get(Uri.parse(url), headers: headers);
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

Future<String> makeTrip(String body) async {
  final url = Uri.parse('${AppConfig.baseUrl}/api/v1/trips');
  final getToken = tokenController.token.value;
  try {
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        "ngrok-skip-browser-warning": "69420",
        'Authorization': 'Bearer $getToken',
      },
      body: body, // body를 객체로 감싸 JSON 구조를 유지
    );

    if (response.statusCode == 200) {
      final decodedBody = utf8.decode(response.bodyBytes);
      final responseData = jsonDecode(decodedBody);
      return responseData;
    } else {
      print('오류: ${response.statusCode}');
      return '';
    }
  } catch (e) {
    print('예외 발생: $e');
    return '';
  }
}


Future<List<String>> sendDataForTitle(Map<String, dynamic> body) async {
  final url = Uri.parse('${AppConfig.baseUrl}/api/v1/recommendations/titles');
  final getToken = tokenController.token.value;
  try {
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        "ngrok-skip-browser-warning": "69420",
        'Authorization': 'Bearer $getToken',
      },
      body: json.encode(body),
    );

    if (response.statusCode == 200) {
      // 응답 데이터를 JSON으로 디코드 후 String List로 변환
      // final responseData = json.decode(response.body);
      final decodedBody =
          utf8.decode(response.bodyBytes); // body 대신 bodyBytes 사용
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

Future<Map<String, dynamic>> sendDataForIotro(Map<String, dynamic> body) async {
  final url = Uri.parse('${AppConfig.baseUrl}/api/v1/recommendations/iotros');
  final getToken = tokenController.token.value;
  try {
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        "ngrok-skip-browser-warning": "69420",
        'Authorization': 'Bearer $getToken',
      },
      body: json.encode(body),
    );

    if (response.statusCode == 200) {
      final decodedBody = utf8.decode(response.bodyBytes); // Decode properly
      final responseData = jsonDecode(decodedBody) as Map<String, dynamic>;
      print('intro 생성 응답 데이터: $responseData');
      return responseData;
    } else {
      print('오류: ${response.statusCode}');
      return {};
    }
  } catch (e) {
    print('예외 발생: $e');
    return {};
  }
}

Future<Map<String, dynamic>> sendDataForStoryboardTxt(
    Map<String, dynamic> body, int tripId) async {
  final url = Uri.parse('${AppConfig.baseUrl}/api/v1/${tripId}/storyboards');
  print(url);
  final getToken = tokenController.token.value;

  try {
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        "ngrok-skip-browser-warning": "69420",
        'Authorization': 'Bearer $getToken',
      },
      body: json.encode(body),
    );

    if (response.statusCode == 200) {
      // JSON 디코드
      final decodedBody = utf8.decode(response.bodyBytes); // Decode properly

      final responseData = json.decode(decodedBody);
      final int storyboardId = responseData['id'];
      final List<dynamic> scenes = responseData['storyboardScenes'];

      // Map<String, dynamic> 형태로 변환
      final List<Map<String, dynamic>> parsedScenes = scenes.map((scene) {
        return {
          'orderNum': scene['orderNum'],
          'sceneTitle': scene['sceneTitle'],
          'description': scene['description'],
          // 'cameraAngle': scene['cameraAngle'],
          // 'cameraMovement': scene['cameraMovement'],
          // 'composition': scene['composition'],
        };
      }).toList();

      print('파싱된 데이터: $parsedScenes');
      return {
        'id': storyboardId,
        'scenes': parsedScenes,
      };
    } else {
      print('오류: ${response.statusCode}');
      return {};
    }
  } catch (e) {
    print('예외 발생: $e');
    return {};
  }
}

Future<String> sendDataForImageGenerate(
    String body, int trip_id, int storyboardId) async {
  final url = Uri.parse(
      '${AppConfig.baseUrl}/api/v1/${trip_id}/storyboards/${storyboardId}/images');
  final getToken = tokenController.token.value;
  try {
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        "ngrok-skip-browser-warning": "69420",
        'Authorization': 'Bearer $getToken',
      },
      body: body,
    );

    if (response.statusCode == 200) {
      final decodedBody =
          utf8.decode(response.bodyBytes); // body 대신 bodyBytes 사용
      final responseData = jsonDecode(decodedBody);
      return responseData;
    } else {
      print('오류: ${response.statusCode}');
      return '';
    }
  } catch (e) {
    print('예외 발생: $e');
    return '';
  }
}

Future<void> simulateApiCall() async {
  await Future.delayed(Duration(seconds: 5)); // 5초 대기 후 완료 상태 반환
}
