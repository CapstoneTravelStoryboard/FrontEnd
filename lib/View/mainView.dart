import 'package:flutter/material.dart';

import 'homeView.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: HomeView(),
      ),
    );
  }
}
