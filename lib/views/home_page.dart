import 'package:flutter/material.dart';

class HomePage extends StatelessWidget{
  final String username;
  const HomePage({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: Text(
          'Hello, $username',
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
        )
      ),
    );
  }
}