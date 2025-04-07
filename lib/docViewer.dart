import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class DocViewerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 전달받은 문서 번호 가져오기
    final dynamic docNo = ModalRoute.of(context)?.settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('문서 보기'),
      ),
      body: Center(
        child: docNo != null && docNo is int // 전달된 값이 int인지 확인
            ? FutureBuilder<String>(
          future: fetchDocument(docNo.toString()), // int를 String으로 변환
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(); // 로딩 표시
            } else if (snapshot.hasError) {
              return Text('문서를 가져오는 중 오류가 발생했습니다: ${snapshot.error}');
            } else if (snapshot.hasData) {
              return SingleChildScrollView(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '문서 내용:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    Text(snapshot.data ?? '', style: TextStyle(fontSize: 16)),
                    SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: () {
                        // 프린트 기능은 텍스트를 복사하여 사용자가 직접 처리하도록 안내
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('프린트 안내'),
                            content: Text('문서 내용을 복사하여 프린트 프로그램에서 출력하세요.'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text('닫기'),
                              ),
                            ],
                          ),
                        );
                      },
                      child: Text('프린트 안내 보기'),
                    ),
                  ],
                ),
              );
            } else {
              return Text('문서가 비어 있습니다.');
            }
          },
        )
            : Text('문서 번호가 없거나 잘못된 형식입니다.'),
      ),
    );
  }

  // 문서를 서버에서 가져오는 함수
  Future<String> fetchDocument(String docNo) async {
    final url = 'http://192.168.11.2:8000/phapp/docviewer/$docNo';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return utf8.decode(response.bodyBytes); // 문서 내용을 UTF-8로 디코딩
    } else {
      throw Exception('문서를 가져올 수 없습니다: ${response.statusCode}');
    }
  }
}
