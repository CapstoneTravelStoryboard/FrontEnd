import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tripdraw/View/LogIn/signUp.dart';
import '../../api test/login_api.dart';
import '../mainView.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(16, 50, 20, 16),
        child: ListView(
          children: [
            Text(
              '로그인',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            TextField(
              controller: emailController,
              decoration: InputDecoration(hintText: '이메일'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(hintText: '비밀번호'),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Text("아직 회원이 아니신가요?  "),
                GestureDetector(
                  onTap: () {
                    Get.to(() => SignUpScreen());
                  },
                  child: Text(
                    "회원가입",
                    style: TextStyle(color: Colors.blueAccent),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Colors.blue,
                ),
                onPressed: () {
                  final email = emailController.text.trim();
                  final password = passwordController.text.trim();
                  login(context, email: email, password: password); // Call the login function
                  Get.offAll(()=> MainView());
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Text('로그인'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
