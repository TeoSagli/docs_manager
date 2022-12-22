import 'package:flutter/material.dart';

class ContentHome extends StatefulWidget {
  const ContentHome({super.key});

  @override
  State<ContentHome> createState() => ContentHomeState();
}

class ContentHomeState extends State<ContentHome> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Home"));
  }
}
