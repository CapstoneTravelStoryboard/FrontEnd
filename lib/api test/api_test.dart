import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

import '../data/model_data.dart';

class ReqResScreen extends StatefulWidget {
  @override
  _ReqResScreenState createState() => _ReqResScreenState();
}

class _ReqResScreenState extends State<ReqResScreen> {
  final Dio dio = Dio();
  String message = "버튼을 눌러 데이터를 가져오세요!";
  UsersList? usersList;

  Future<void> fetchUsers() async {
    setState(() {
      message = "데이터를 가져오는 중...";
    });

    try {
      final response = await dio.get('https://octopus-epic-shrew.ngrok-free.app');
      final usersList = UsersList.fromJson(response.data);

      setState(() {
        this.usersList = usersList;
        message = "데이터 가져오기 성공!";
      });
    } catch (e) {
      setState(() {
        message = "데이터 가져오기 실패: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ReqRes API Example'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: fetchUsers,
                child: Text('GET: Users List'),
              ),
              if (usersList != null)
                Expanded(
                  child: ListView.builder(
                    itemCount: usersList!.users.length,
                    itemBuilder: (context, index) {
                      final user = usersList!.users[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(user.avatar),
                        ),
                        title: Text('${user.firstName} ${user.lastName}'),
                        subtitle: Text(user.email),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}