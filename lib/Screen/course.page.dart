import 'package:eduma_app/Screen/courseDetails.page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CoursePage extends StatefulWidget {
  const CoursePage({super.key});

  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  List<Map<String, dynamic>> courseList = [
    {
      "image": "assets/reading.png",
      "paid": "Free",
      "course": "Angular",
      "courseName": "Angular Course",
      "time": "10 week",
    },
    {
      "image": "assets/reading2.png",
      "paid": "₹ 45k",
      "course": "Css, Teaching Online",
      "courseName": "introduction learn Press - Lms Plugin",
      "time": "10 Minutes",
    },
    {
      "image": "assets/cour1.png",
      "paid": "Free",
      "course": "Teaching Online",
      "courseName": "Create an LMS Website with learnPress",
      "time": "10 week",
    },
    {
      "image": "assets/cour.png",
      "paid": "Free",
      "course": "Sub Backend",
      "courseName": "Learn Press mycred integration: Step-By Guied",
      "time": "10 week",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30.h),
          Center(
            child: Text(
              "Courses",
              style: GoogleFonts.roboto(
                fontSize: 26.sp,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1B1B1B),
                letterSpacing: -0.4,
              ),
            ),
          ),
          SizedBox(height: 20.h),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                SizedBox(width: 20.w),
                language("Angular"),
                language("Css"),
                language("Java"),
                language("Html"),
                language("Java Script"),
              ],
            ),
          ),
          Expanded(
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Stack(
                  children: [
                    Positioned(
                      left: -120,
                      top: 115.h,
                      child: Image.asset(
                        "assets/vect.png",
                        width: 363.w,
                        height: 270.h,
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 100.h,
                      child: Image.asset(
                        "assets/vec.png",
                        width: 466.w,
                        height: 440.h,
                        fit: BoxFit.fill,
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemCount: courseList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(
                            left: 20.w,
                            right: 20.w,
                            top: 20.h,
                          ),
                          width: 400.w,
                          //  height: 361.h,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                          builder: (context) =>
                                              CourseDetailsPage(),
                                        ),
                                      );
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20.r),
                                      child: Image.asset(
                                        courseList[index]['image'].toString(),
                                        width: 400.w,
                                        height: 263.h,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.favorite_border,
                                        color: Colors.white,
                                        size: 25.sp,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 25.w,
                                    bottom: 25.h,
                                    child: Container(
                                      padding: EdgeInsets.only(
                                        left: 16.w,
                                        right: 16.w,
                                        top: 6.h,
                                        bottom: 6.h,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          7.r,
                                        ),
                                        color: Color(0xFF001E6C),
                                      ),
                                      child: Text(
                                        courseList[index]['paid'].toString(),
                                        style: GoogleFonts.roboto(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                          letterSpacing: -0.4,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 15.h),
                              Text(
                                courseList[index]['course'].toString(),
                                style: GoogleFonts.roboto(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromARGB(140, 0, 0, 0),
                                  letterSpacing: -0.4,
                                ),
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                courseList[index]['courseName'].toString(),
                                style: GoogleFonts.roboto(
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF001E6C),
                                  letterSpacing: -0.4,
                                  height: 1,
                                ),
                              ),
                              SizedBox(height: 8.h),
                              Row(
                                children: [
                                  Icon(
                                    Icons.access_time,
                                    color: Color(0xFFFE4A55),
                                  ),
                                  SizedBox(width: 8.w),
                                  Text(
                                    "Durations : ",
                                    style: GoogleFonts.roboto(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF000000),
                                      letterSpacing: -0.4,
                                    ),
                                  ),
                                  Text(
                                    courseList[index]['time'].toString(),
                                    style: GoogleFonts.roboto(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF747272),
                                      letterSpacing: -0.4,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 30.h),
        ],
      ),
    );
  }

  Widget language(String txt) {
    return Container(
      margin: EdgeInsets.only(right: 10.w),
      padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 3.h, top: 3.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.r),
        border: Border.all(color: Color(0xFF000000), width: 1.w),
      ),
      child: Text(
        txt,
        style: GoogleFonts.roboto(
          fontSize: 20.sp,
          fontWeight: FontWeight.w500,
          color: Color(0xFF000000),
        ),
      ),
    );
  }
}
