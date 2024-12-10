import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginView extends StatelessWidget {
  // 준비된 URL (구글 로그인 URL)
  final String googleLoginUrl = "https://your-api.com/auth/google";

  // URL 실행 함수
  Future<void> launchGoogleLoginUrl() async {
    final Uri url = Uri.parse(googleLoginUrl);

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $googleLoginUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Login Example'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            try {
              await launchGoogleLoginUrl();
            } catch (e) {
              // URL 실행 실패 처리
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Error'),
                  content: Text('Failed to open Google login: $e'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('OK'),
                    ),
                  ],
                ),
              );
            }
          },
          child: Text('Login with Google'),
        ),
      ),
    );
  }
}
