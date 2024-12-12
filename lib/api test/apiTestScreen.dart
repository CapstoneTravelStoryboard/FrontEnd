import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../config/appConfig.dart';
import '../controller/tokenController.dart';
import '../data/dummyJson2.dart';
import 'generatesb_api_func.dart';

class ApiPostTestScreen extends StatefulWidget {
  @override
  _ApiPostTestScreenState createState() => _ApiPostTestScreenState();
}

class _ApiPostTestScreenState extends State<ApiPostTestScreen> {
  String responseMessage = "아직 응답이 없습니다.";
  List<String> responseList = [];
  String responseString = '';
  final tokenController = Get.put(TokenController());

  // POST 요청 함수
  Future<void> sendPostRequest() async {
    int id = 1;
    final url =
        Uri.parse('${AppConfig.baseUrl}/api/v1/storyboards/${id}/images');
    final body = {'winter'};

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          "ngrok-skip-browser-warning": "69420",
        },
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        setState(() {
          responseList =
              List<String>.from(responseData.map((item) => item.toString()));
          responseMessage = "요청 성공! 제목 리스트가 로드되었습니다.";
        });
      } else {
        setState(() {
          responseMessage = "오류 발생: ${response.statusCode}";
        });
      }
    } catch (e) {
      setState(() {
        responseMessage = "예외 발생: $e";
      });
    }
  }

  Future<String> signUp(Map<String, dynamic> body) async {
    final url = Uri.parse('${AppConfig.baseUrl}/api/v1/members/signup');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // 응답 데이터를 JSON으로 디코드 후 String List로 변환
        final responseData = json.decode(response.body);
        print('응답 데이터: $responseData');
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

  Future<Map<String, dynamic>> login(Map<String, dynamic> body) async {
    final url = Uri.parse('${AppConfig.baseUrl}/api/v1/members/login');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print('응답 데이터: $responseData');
        return responseData; // JSON 데이터를 반환
      } else {
        print('오류: ${response.statusCode}');
        return {'error': '로그인 실패', 'statusCode': response.statusCode};
      }
    } catch (e) {
      print('예외 발생: $e');
      return {'error': '예외 발생', 'exception': e.toString()};
    }
  }

  void handleLogin(BuildContext context) async {
    final loginBody = {
      'email': 'eve@naver.com',
      'password': 'eve',
    };

    final result = await login(loginBody);

    if (result.containsKey('token')) {
      // 로그인 성공
      final token = result['token'];
      final member = result['member'];
      print("token ${token}");

      // Update token in TokenController
      tokenController.updateToken(token);

      // 로그인 성공 메시지
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("로그인 성공: ${member['name']}님 환영합니다!")),
      );
    } else {
      // 로그인 실패 메시지
      final errorMessage = result['error'] ?? '알 수 없는 오류';
      final statusCode = result['statusCode'] ?? 'N/A';

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("로그인 실패: $errorMessage (상태 코드: $statusCode)")),
      );
    }
  }

  Map<String, dynamic> request_body = {
    "name": "string",
    "email": "string@naver.com",
    "password": "string",
    "passwordConfirm": "string"
  };

  void loadTravelList() async {
    List<Map<String, dynamic>> tripList = travelList; // 초기 travelList
    bool isLoading = true;
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${tokenController.token.value}',
      // Get token from controller
    };

    try {
      final response = await http.get(
        Uri.parse('${AppConfig.baseUrl}/api/v1/trips'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final List<dynamic> apiTravelList = jsonDecode(response.body);
        setState(() {
          tripList = apiTravelList
              .map((item) => item as Map<String, dynamic>)
              .toList();
          isLoading = false;
        });
        print(tripList);
      } else {
        print(response.statusCode);
        setState(() {
          isLoading = false;
        });
        print('여행 데이터를 불러오는 데 실패했습니다.');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('여행 데이터를 불러오는 중 문제가 발생했습니다.');
    }
  }

  Future<void> loadStoryBoardList() async {
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${tokenController.token.value}',
    };

    try {
      final storyboardUrl = Uri.parse(
          '${AppConfig.baseUrl}/api/v1/6/storyboards/3');

      final storyboardResponse = await http
          .get(storyboardUrl, headers: headers);
      print(storyboardUrl);
      print(storyboardResponse);
      if (storyboardResponse.statusCode == 200) {
        print(
            'API Call Success: ${storyboardResponse.statusCode}');


        final decodedStoryboard = jsonDecode(utf8.decode(storyboardResponse.bodyBytes));
        print(decodedStoryboard); // 전체 데이터 확인

        final scenes = (decodedStoryboard['scenes'] as List<dynamic>)
            .map((scene) => scene as Map<String, dynamic>)
            .toList();
        // scenes 리스트 확인
        for (var scene in scenes) {
          print('Scene ID: ${scene['sceneId'].toString()}');
          print('Order Num: ${scene['orderNum'].toString()}');
          print('Title: ${scene['title']}');
        }
      } else {
        print(
            'API Call Failed: ${storyboardResponse.statusCode}');
        throw Exception('스토리보드 상세 API 호출 실패');
      }
    } catch (e) {
      print('Error: $e');
      Get.snackbar(
          '오류', '스토리보드 데이터를 불러오는 중 문제가 발생했습니다.');
    }
  }
  Future<void> loadExStoryBoardList() async {
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${tokenController.token.value}',
    };

    try {
      final response = await http.get(
        Uri.parse('${AppConfig.baseUrl}/api/v1/example'),
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
        // print("토큰이 유효하지 않습니다. 다시 로그인하세요.");
        print("code : ${response.statusCode}");
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("API POST Test"),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "회원가입 POST 요청 보내기",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                signUp(request_body);
              },
              child: Text("POST 요청 보내기"),
            ),
            SizedBox(height: 20),
            Text(
              "응답 메시지:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(responseMessage),
            SizedBox(height: 20),
            Text(
              "응답 리스트:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              "로그인 POST 요청 보내기",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Obx(() {
              if (tokenController.token.value == '') {
                return ElevatedButton(
                  onPressed: () => handleLogin(context),
                  child: Text("POST 요청 보내기"),
                );
              } else {
                return Container(); // 빈 공간
              }
            }),
            Text(
              "제목 POST 요청 보내기",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                final realBody = {
                  'landmarkId': 1,
                  'purpose': "연인과 함께", // 선택된 테마를 전달
                  'companions': "연인",
                  'companionCount': 2,
                  'season': "winter",
                };
                final List<String> responseList = await sendDataForTitle(realBody);

              },
              child: Text("제목 요청 보내기"),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: responseList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(responseList[index]),
                  );
                },
              ),
            ),
            Text(
              "조회 GET 요청 보내기",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                loadStoryBoardList();
                print('current token :${tokenController.token.value}');
              },
              child: Text("조회 GET 요청 보내기"),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
