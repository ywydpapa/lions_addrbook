import 'package:flutter/material.dart';
import 'clubList.dart';
import 'memberList.dart';
import 'login.dart';
import 'searchresult.dart';
import 'member.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Navigation Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/', // 초기 화면 설정
      routes: {
        '/': (context) => HomeScreen(),
        '/clubList': (context) => ClubListScreen(),
        '/search': (context) => SearchScreen(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('15지역 회원 주소록'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/clubList');
              },
              child: Text('클럽 리스트'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/search');
              },
              child: Text('키워드 검색'),
            ),
          ],
        ),
      ),
    );
  }
}
