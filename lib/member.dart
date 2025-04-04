import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MemberDetailScreen extends StatefulWidget {
  final int memberNo;

  MemberDetailScreen({required this.memberNo});

  @override
  _MemberDetailScreenState createState() => _MemberDetailScreenState();
}

class _MemberDetailScreenState extends State<MemberDetailScreen> {
  late Future<Map<String, dynamic>> _memberDetail;

  @override
  void initState() {
    super.initState();
    _memberDetail = fetchMemberDetail(widget.memberNo);
  }

  Future<Map<String, dynamic>> fetchMemberDetail(int memberNo) async {
    final response = await http.get(Uri.parse('http://192.168.11.2:8000/phapp/memberDtl/$memberNo'));

    if (response.statusCode == 200) {
      final decodedResponse = utf8.decode(response.bodyBytes);
      Map<String, dynamic> data = json.decode(decodedResponse);
      return json.decode(decodedResponse);
    } else {
      throw Exception('Failed to load member detail');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Member Detail'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _memberDetail,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No data found'));
          } else {
            final member = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Name: ${member['memberName']}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text('Rank: ${member['rankTitle']}'),
                  SizedBox(height: 8),
                  Text('Phone: ${member['memberPhone'] ?? 'N/A'}'),
                  SizedBox(height: 16),
                  Text(
                    'Additional Info:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(member['additionalInfo'] ?? 'No additional information available.'),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
