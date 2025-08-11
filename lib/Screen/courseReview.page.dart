import 'package:eduma_app/Screen/chating.page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CourseReviewPage extends StatefulWidget {
  const CourseReviewPage({super.key});

  @override
  State<CourseReviewPage> createState() => _CourseReviewPageState();
}

class _CourseReviewPageState extends State<CourseReviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 215.h,
                  decoration: BoxDecoration(color: Color(0xFF001E6C)),
                  child: Column(
                    children: [
                      SizedBox(height: 30.h),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(width: 30.w),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              height: 44.w,
                              width: 44.w,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 255, 255, 255),
                                borderRadius: BorderRadius.circular(500.r),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: 6.w),
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  color: Color.fromARGB(255, 4, 0, 0),
                                  size: 15.w,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10.h, left: 15.w),
                            child: Text(
                              "College Review",
                              style: GoogleFonts.roboto(
                                fontSize: 18.w,
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 100.h),
                      Text(
                        "James Parlour Courses",
                        style: GoogleFonts.roboto(
                          color: Color(0xFF1B1B1B),
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          letterSpacing: -0.4,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 100.w, right: 100.w),
                        child: Text(
                          "Helping students land their dream jobs with 5+ years of placement coaching experience",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(
                            color: Color(0xFF666666),
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w400,
                            letterSpacing: -0.4,
                          ),
                        ),
                      ),
                      SizedBox(height: 18.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 26,
                            decoration: BoxDecoration(
                              color: Color(0xFFDEDDEC),
                              borderRadius: BorderRadius.circular(40.r),
                            ),
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.only(left: 15, right: 15),
                                child: Text(
                                  "Jaipur",
                                  style: GoogleFonts.roboto(fontSize: 10.w),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Container(
                            height: 26,
                            decoration: BoxDecoration(
                              color: Color(0xFFDEDDEC),
                              borderRadius: BorderRadius.circular(40.r),
                            ),
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.only(left: 15, right: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Color(0xFF001E6C),
                                      size: 16,
                                    ),
                                    SizedBox(width: 5.w),
                                    Text(
                                      "4.5 Review",
                                      style: GoogleFonts.roboto(
                                        fontSize: 10.w,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xFF2E2E2E),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 25.h),
                      Divider(color: Colors.grey.shade300, height: 2),
                      SizedBox(height: 20.h),
                      Padding(
                        padding: EdgeInsets.only(left: 20.w, right: 20.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Reviews & Testimonials",
                              style: GoogleFonts.roboto(
                                color: const Color(0xFF1B1B1B),
                                fontWeight: FontWeight.w600,
                                fontSize: 15.sp,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "View All",
                              style: GoogleFonts.roboto(
                                color: const Color(0xFF001E6C),
                                fontWeight: FontWeight.w600,
                                fontSize: 13.sp,
                                decoration: TextDecoration.underline,
                                decorationColor: Color(0xFF001E6C),
                                decorationThickness: 2.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Padding(
                        padding: EdgeInsets.only(left: 20.w, right: 20.w),
                        child: ListView.builder(
                          itemCount: 4,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => ChatingPage(),
                                  ),
                                );
                              },
                              child: Container(
                                margin: EdgeInsets.only(top: 10.h),
                                // width: 400.w,
                                // height: 110.h,
                                padding: EdgeInsets.only(
                                  left: 16.w,
                                  right: 16.w,
                                  top: 16.h,
                                  bottom: 16.h,
                                ),
                                decoration: BoxDecoration(
                                  color: Color(0xFFF1F2F6),
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: Color(0xFF001E6C),
                                          size: 20.sp,
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: Color(0xFF001E6C),
                                          size: 20.sp,
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: Color(0xFF001E6C),
                                          size: 20.sp,
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: Color(0xFF001E6C),
                                          size: 20.sp,
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: Color(0xFF001E6C),
                                          size: 20.sp,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10.h),
                                    Text(
                                      "Rahul helped me prepare for my TCS interview, and I got the job! His tips are spot-on!",
                                      style: GoogleFonts.roboto(
                                        fontSize: 13.sp,
                                        color: Color(0xFF666666),
                                        fontWeight: FontWeight.w400,
                                        fontStyle: FontStyle.italic,
                                        letterSpacing: -0.4,
                                      ),
                                    ),
                                    SizedBox(height: 10.h),
                                    Text(
                                      "- Vinod Shyam ",
                                      style: GoogleFonts.roboto(
                                        fontSize: 13.sp,
                                        color: Color(0xFF666666),
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: -0.4,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: 100.h, // Adjust for circle height
              child: Container(
                height: 182.w,
                width: 182.w,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 5),
                ),
                child: ClipOval(
                  child: Image.asset(
                    "assets/reviewimage.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
