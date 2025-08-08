import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
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
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Stack(
        children: [
          Positioned(
            left: -120,
            top: -100.h,
            child: Image.asset(
              "assets/vect.png",
              width: 363.w,
              height: 270.h,
              fit: BoxFit.fitHeight,
            ),
          ),
          Positioned(
            bottom: -40.h,
            left: 0,
            right: 0,
            child: Image.asset(
              "assets/vec.png",
              width: 470.w,
              height: 450.h,
              fit: BoxFit.fill,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 33.h),
              Row(
                children: [
                  // SizedBox(width: 20.w),
                  // Container(
                  //   width: 37.w,
                  //   height: 37.h,
                  //   decoration: BoxDecoration(
                  //     shape: BoxShape.circle,
                  //     color: Color.fromARGB(25, 0, 0, 0),
                  //   ),
                  //   child: IconButton(
                  //     style: IconButton.styleFrom(
                  //       minimumSize: Size(0, 0),
                  //       padding: EdgeInsets.zero,
                  //       tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  //     ),
                  //     onPressed: () {
                  //       Navigator.pop(context);
                  //     },
                  //     icon: Icon(
                  //       Icons.arrow_back,
                  //       color: Color(0xFF001E6C),
                  //       size: 20.sp,
                  //     ),
                  //   ),
                  // ),
                  SizedBox(width: 50.w),
                  Text(
                    "Wishlist",
                    style: GoogleFonts.roboto(
                      fontSize: 26.sp,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1B1B1B),
                      letterSpacing: -0.4,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
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
                                onTap: () {},
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
                                    Icons.favorite,
                                    color: Colors.red,
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
                                    borderRadius: BorderRadius.circular(7.r),
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
                              Icon(Icons.access_time, color: Color(0xFFFE4A55)),
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
              ),
            ],
          ),
        ],
      ),
    );
  }
}
