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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 33.h),
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
            SizedBox(height: 30.h),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,
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
                  Container(
                    width: 400.w,
                    //  height: 361.h,
                    margin: EdgeInsets.only(left: 20.w, right: 20.h),
                    //padding: EdgeInsets.only(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20.r),
                              child: Image.asset(
                                "assets/reading.png",
                                width: 400.w,
                                height: 263.h,
                                fit: BoxFit.cover,
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
                                  top: 10.h,
                                  bottom: 10.h,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4.r),
                                  color: Color(0xFF001E6C),
                                ),
                                child: Text(
                                  "Free",
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
                          "Angular",
                          style: GoogleFonts.roboto(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                            color: Color.fromARGB(140, 0, 0, 0),
                            letterSpacing: -0.4,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          "Angular Course",
                          style: GoogleFonts.roboto(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF001E6C),
                            letterSpacing: -0.4,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Row(
                          children: [
                            Icon(Icons.access_time, color: Color(0xFFFE4A55)),
                            SizedBox(width: 8.w),
                            Text(
                              "Durations : ",
                              style: GoogleFonts.roboto(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF000000),
                                letterSpacing: -0.4
                              ),
                            ),
                            Text(
                              "10 week",
                              style: GoogleFonts.roboto(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                letterSpacing: -0.4
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget language(String txt) {
    return Container(
      margin: EdgeInsets.only(right: 10.w),
      padding: EdgeInsets.only(
        left: 20.w,
        right: 20.w,
        bottom: 10.h,
        top: 10.h,
      ),
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
