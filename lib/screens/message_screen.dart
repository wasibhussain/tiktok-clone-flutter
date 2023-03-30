import 'package:flutter/material.dart';


class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(backgroundColor: Colors.red,centerTitle: true, title: Text('Messages'),),
      body: const Center(
          child: Text(
        'No Messages yet!',
        style: TextStyle(
            fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
      )),
    );
  }
}
