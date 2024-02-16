
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(HttpClienteDemo());
}

class HttpClienteDemo extends StatefulWidget {
  @override
  _HttpClienteDemoState createState() => _HttpClienteDemoState();
}

class _HttpClienteDemoState extends State<HttpClienteDemo> {
  List<dynamic> _posts = [];

  @override
  void initState() {
    super.initState();
    _fetchPosts();
  }

  Future<void> _fetchPosts() async {
    final response = await http.get(Uri.https('jsonplaceholder.typicode.com', '/posts'));
    if (response.statusCode == 200) {
      setState(() {
        _posts = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load posts');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HttpClienteDemo',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Deber de HTTP Cliente'),
        ),
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.network(
                'https://i.pinimg.com/236x/81/72/f3/8172f32cc85e02fe8c7cec5f5fd176fb.jpg',
                fit: BoxFit.cover, // Esto hará que tu imagen cubra todo el fondo
              ),
            ),
            ListView.builder(
              itemCount: _posts.length > 5 ? 5 : _posts.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.all(10),
                  elevation: 5,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Text(
                      _posts[index]['title'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
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

