import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CoursePage extends StatefulWidget {
  const CoursePage({super.key});

  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Color(0xFFFFFFFF),
    
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
    ),);
  }
}
