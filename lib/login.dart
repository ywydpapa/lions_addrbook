import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('검색 화면'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context); // 이전 화면으로 돌아가기
          },
          child: Text('홈 화면으로 돌아가기'),
        ),
      ),
    );
  }
}
