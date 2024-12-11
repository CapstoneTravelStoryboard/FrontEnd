import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:tripdraw/View/LogIn/loginView2.dart';

import '../../api test/login_api.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController emailController = TextEditingController();
  String? selectedEmailDomain;

  final ValueNotifier<bool> isButtonEnabled = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    nameController.addListener(_validateInputs);
    passwordController.addListener(_validateInputs);
    confirmPasswordController.addListener(_validateInputs);
    emailController.addListener(_validateInputs);
  }

  void _validateInputs() {
    final isFormValid =
       nameController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        confirmPasswordController.text == passwordController.text &&
        emailController.text.isNotEmpty;
    isButtonEnabled.value = isFormValid;
  }

  void _handleSignUp() async {
    final body = {
      'name': nameController.text,
      'email': emailController.text + selectedEmailDomain!,
      'password': passwordController.text,
      'passwordConfirm': confirmPasswordController.text,
    };
  print('signup body : ${body}');
    final result = await signUp(body);

    if (result.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('회원가입 성공: $result')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('회원가입 실패')),
      );
    }

    Get.offAll(() => LoginView());
  }

  @override
  void dispose() {
    nameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 50.h, 20.w, 16.h),
        child: ListView(
          children: [
            Text(
              '회원가입',
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.h),

            Text('이름'),
            TextField(
              controller: nameController,
              obscureText: false,
              decoration: InputDecoration(
                hintText: '이름',
              ),
            ),

            SizedBox(height: 16.0),
            Text('이메일'),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(hintText: '이메일'),
                  ),
                ),
                SizedBox(width: 8.0),
                DropdownButton<String>(
                  value: selectedEmailDomain,
                  items: ['@naver.com', '@gmail.com', '@kakao.com']
                      .map((String value) => DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  ))
                      .toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedEmailDomain = newValue;
                      _validateInputs();
                    });
                  },
                  hint: Text('선택'),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Text('비밀번호'),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: '비밀번호',
                // helperText: '6~20자/영문 대문자, 소문자, 숫자, 특수문자 중 2가지 이상 조합',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: confirmPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: '비밀번호 확인',
              ),
            ),
            SizedBox(height: 60.h),
            GestureDetector(
              child: Text("입력확인"),
              onTap: (){
                final body = {
                  'name': nameController.text,
                  'email': emailController.text + selectedEmailDomain!,
                  'password': passwordController.text,
                  'passwordConfirm': confirmPasswordController.text,
                };
                print(body);
              },
            ),
            ValueListenableBuilder<bool>(
              valueListenable: isButtonEnabled,
              builder: (context, isEnabled, child) {
                return Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 40.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      backgroundColor: isEnabled ? Colors.blue : Colors.grey[200],
                    ),
                    onPressed: isEnabled ? _handleSignUp : null,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.h),
                      child: Text(
                        '가입하기',
                        style: TextStyle(
                          color: isEnabled ? Colors.white : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),

          ],
        ),
      ),
    );
  }
}
