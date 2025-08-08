import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CourseReviewPage extends StatefulWidget {
  const CourseReviewPage({super.key});

  @override
  State<CourseReviewPage> createState() => _CourseReviewPageState();
}

class _CourseReviewPageState extends State<CourseReviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 215.h,
            decoration: BoxDecoration(color: Color(0xFF001E6C),
            
            
            ),
            child: Column(),),
        ],
      ),
    );
  }
}
