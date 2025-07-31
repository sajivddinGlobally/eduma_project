import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_education_app/Screen/login.page.dart';
import 'package:new_education_app/Screen/register.page.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: Color(0xFFFFFFFF),
        leading: Padding(
          padding: EdgeInsets.only(left: 20.w),
          child: Image.asset("assets/logo.png"),
        ),
        actions: [
          Row(
            children: [
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: Text(
                  "Login",
                  style: GoogleFonts.roboto(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF000000),
                    letterSpacing: -0.4,
                  ),
                ),
              ),
              Text(
                "|",
                style: GoogleFonts.roboto(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF000000),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(builder: (context) => RegisterPage()),
                  );
                },
                child: Text(
                  "Register",
                  style: GoogleFonts.roboto(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF000000),
                    letterSpacing: -0.4,
                  ),
                ),
              ),
              SizedBox(width: 10.w),
            ],
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 18.h),
          Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Welcome Back, Piyush Kumar",
                  style: GoogleFonts.roboto(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff000000),
                    letterSpacing: -0.4,
                  ),
                ),
                Icon(Icons.search, color: Color(0xFF0F0F0F)),
              ],
            ),
          ),
          SizedBox(height: 12.h),
          Container(
            margin: EdgeInsets.only(left: 20.w, right: 20.w),
            child: TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 20.w, right: 20.w),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.r),
                  borderSide: BorderSide(
                    color: Color.fromARGB(153, 0, 0, 0),
                    width: 2.w,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.r),
                  borderSide: BorderSide(
                    color: Color.fromARGB(153, 0, 0, 0),
                    width: 2.w,
                  ),
                ),
                hint: Text(
                  "Searching Courses...",
                  style: GoogleFonts.roboto(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF777474),
                    letterSpacing: -0.2,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 18.h),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 20.w),
                  padding: EdgeInsets.only(
                    top: 10.h,
                    bottom: 10.h,
                    left: 20.w,
                    right: 20.w,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40.r),
                    color: Color(0xFF001E6C),
                  ),
                  child: Text(
                    "Backend",
                    style: GoogleFonts.roboto(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10.w),
                  padding: EdgeInsets.only(
                    top: 10.h,
                    bottom: 10.h,
                    left: 20.w,
                    right: 20.w,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40.r),
                    color: Color(0xFFDCF881),
                  ),
                  child: Text(
                    "Programing Language",
                    style: GoogleFonts.roboto(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10.w, right: 10.w),
                  padding: EdgeInsets.only(
                    top: 10.h,
                    bottom: 10.h,
                    left: 20.w,
                    right: 20.w,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40.r),
                    color: Color(0xFFEB9481),
                  ),
                  child: Text(
                    "Technology",
                    style: GoogleFonts.roboto(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 30.h),
          Row(
            children: [
              SizedBox(width: 20.w),
              Image.asset("assets/book.png"),
              SizedBox(width: 10.w),
              Text(
                "Continue Learning",
                style: GoogleFonts.roboto(
                  fontSize: 26.sp,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF000000),
                  letterSpacing: -0.4,
                ),
              ),
              Spacer(),
              Icon(
                Icons.arrow_forward_ios,
                color: Color(0xFF001E6C),
                weight: 3,
              ),
              SizedBox(width: 20.w),
            ],
          ),
          SizedBox(height: 20.h),
          LearningBody(),
        ],
      ),
    );
  }
}

class LearningBody extends StatefulWidget {
  const LearningBody({super.key});

  @override
  State<LearningBody> createState() => _LearningBodyState();
}

class _LearningBodyState extends State<LearningBody> {
  final int currentStep = 16; // Dynamic value use kar sakte ho
  final int totalSteps = 100;
  @override
  Widget build(BuildContext context) {
    double percent = (currentStep / totalSteps) * 100;
    return Container(
      height: 265.h,
      // color: Colors.amber,
      child: ListView.builder(
        itemCount: 2,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(left: 20.w, right: 10.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Image.asset("assets/learning1.png"),
                    // Progress bar
                    Positioned(
                      left: 10.w,
                      right: 10.w,
                      bottom: 26.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 180.w,
                            // color: Colors.white,
                            child: StepProgressIndicator(
                              totalSteps: totalSteps,
                              currentStep: currentStep,
                              size: 8.h,
                              padding: 0,
                              selectedColor: Color(0xFF001E6C),
                              unselectedColor: Colors.white,
                              roundedEdges: Radius.circular(10.r),
                            ),
                          ),
                          Text(
                            "${percent.toInt()}% Complete",
                            style: GoogleFonts.roboto(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFFFFFFFF),
                              letterSpacing: -0.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5.h),
                SizedBox(
                  width: 250.w,
                  child: Text(
                    truncateString(
                      "15th Online  Workshop based on treatise Part-7 (09-12 jan 2024)",
                      100,
                    ),
                    style: GoogleFonts.roboto(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF001E6C),
                    ),
                  ),
                ),
                SizedBox(height: 5.h),
                Text(
                  "By Anil Kumar Singh",
                  style: GoogleFonts.roboto(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: Color.fromARGB(132, 0, 30, 108),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

String truncateString(String input, int maxLength) {
  if (input.length <= maxLength) return input;
  return input.substring(0, maxLength) + "...";
}
