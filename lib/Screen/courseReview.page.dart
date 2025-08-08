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
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 215.h,
                decoration: BoxDecoration(color: Color(0xFF001E6C)),
                child: Column(
                  children: [
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
                            child: Center(
                              child: Icon(
                                Icons.arrow_back_ios,
                                color: Color.fromARGB(255, 4, 0, 0),
                                size: 15.w,
                              ),
                            ),
                          ),
                        ),
                        // Spacer(),
                        Text(
                          "College Review",
                          style: GoogleFonts.roboto(
                            fontSize: 18.w,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 100.h),
              Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 111.h),
                    Text(
                      "dgjkhfdz",
                      style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.95,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 100.w, right: 100.w),
                      child: Text(
                        "{snap.data.collageDescription}",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          letterSpacing: -0.55,
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
                                "snap.data.city",
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
                                    color: Color(0xFF9088F1),
                                    size: 16,
                                  ),
                                  SizedBox(width: 5.w),
                                  Text(
                                    "snap. Review",
                                    style: GoogleFonts.roboto(fontSize: 10.w),
                                  ),
                                ],
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
                                  Text(
                                    "Seat intake",
                                    style: GoogleFonts.roboto(fontSize: 10.w),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15.h),
                    Divider(color: Colors.grey.shade300, height: 2),
                    SizedBox(height: 15.h),
                    Padding(
                      padding: EdgeInsets.only(left: 15.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Branches",
                            style: GoogleFonts.roboto(
                              color: const Color.fromARGB(255, 0, 0, 0),
                              fontWeight: FontWeight.w600,
                              fontSize: 15.w,
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 50.h,
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: EdgeInsets.only(left: 8.0.w),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 2,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.all(4.0.w),
                              child: Container(
                                height: 26,
                                decoration: BoxDecoration(
                                  color: Color(0xFFDEDDEC),
                                  borderRadius: BorderRadius.circular(40.r),
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      left: 15,
                                      right: 15,
                                    ),
                                    child: Text(
                                      "departments[index]",
                                      style: GoogleFonts.roboto(fontSize: 10.w),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 15.h),
                    Divider(color: Colors.grey.shade300, height: 2),
                    SizedBox(height: 15.h),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 20.w,
                        right: 20.w,
                        top: 10.h,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Reviews & Testimonials",
                                style: GoogleFonts.roboto(
                                  color: const Color.fromARGB(255, 0, 0, 0),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15.w,
                                ),
                              ),
                              Spacer(),
                              GestureDetector(
                                onTap: () {},
                                child: Text(
                                  "View All",
                                  style: GoogleFonts.roboto(
                                    fontSize: 11.w,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF9088F1),
                                    textBaseline: TextBaseline.ideographic,
                                  ),
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
                child: Image.network("snap.data.image", fit: BoxFit.cover),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
