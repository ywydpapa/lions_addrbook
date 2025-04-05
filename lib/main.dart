import 'package:flutter/material.dart';
import 'clubList.dart';
import 'searchresult.dart';
import 'rankMember.dart';

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
      initialRoute: '/login', // 초기 화면을 로그인 화면으로 설정
      routes: {
        '/login': (context) => LoginScreen(),
        '/': (context) => HomeScreen(),
        '/clubList': (context) => ClubListScreen(),
        '/search': (context) => SearchScreen(),
        '/rankMembers': (context) => RankMemberScreen(),
      },
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _errorMessage = '';

  void _login() {
    // 간단한 로그인 검증 로직
    if (_usernameController.text == 'admin' && _passwordController.text == '1234') {
      // 로그인 성공 시 메인 화면으로 이동
      Navigator.pushReplacementNamed(context, '/');
    } else {
      // 로그인 실패 시 에러 메시지 표시
      setState(() {
        _errorMessage = '아이디 또는 암호가 잘못되었습니다.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('로그인'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: '아이디',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              obscureText: true, // 비밀번호 입력 시 마스킹 처리
              decoration: InputDecoration(
                labelText: '암호',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            if (_errorMessage.isNotEmpty)
              Text(
                _errorMessage,
                style: TextStyle(color: Colors.red),
              ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _login,
              child: Text('로그인'),
            ),
          ],
        ),
      ),
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
              child: Text('클럽별 회원 리스트'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/rankMembers');
              },
              child: Text('직책별 회원 리스트'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/search');
              },
              child: Text('키워드 회원 검색'),
            ),
          ],
        ),
      ),
    );
  }
}
