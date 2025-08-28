import 'dart:math';
import 'package:eduma_app/Screen/enrolledCourseDetails.page.dart';
import 'package:eduma_app/data/Controller/enrolleCourseController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class LibraryPage extends ConsumerStatefulWidget {
  const LibraryPage({super.key});

  @override
  ConsumerState<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends ConsumerState<LibraryPage> {
  @override
  Widget build(BuildContext context) {
    final enrolleCourseProvider = ref.watch(enrollCourseController);
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
          enrolleCourseProvider.when(
            data: (data) {
              if (data.courses.isEmpty) {
                return Center(
                  child: Text(
                    "No Enrolled Data",
                    style: GoogleFonts.roboto(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                  ),
                );
              }
              return Padding(
                padding: EdgeInsets.only(left: 20.w, right: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 33.h),
                    Row(
                      children: [
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
                        //SizedBox(width: 50.w),
                        Text(
                          "Library",
                          style: GoogleFonts.roboto(
                            fontSize: 26.sp,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1B1B1B),
                            letterSpacing: -0.4,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15.h),
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: data.courses.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(top: 25.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                        builder: (context) =>
                                            EnrolledDourseDetailsPage(),
                                      ),
                                    );
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                          10.r,
                                        ),
                                        child: Image.network(
                                          // "assets/shop1.png",
                                          data.courses[index].thumbnail,
                                          width: 170.w,
                                          height: 100.h,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(width: 10.w),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 210.w,
                                            // color: Colors.amber,
                                            child: Text(
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              // "Sajivddin Ansari hellow hot are you sajiv",
                                              data.courses[index].title,
                                              style: GoogleFonts.roboto(
                                                fontSize: 20.sp,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.blue,
                                                height: 1.5.h,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 6.h),
                                          Text(
                                            //"data",
                                            data.courses[index].instructor.name,
                                            style: GoogleFonts.roboto(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
            error: (error, stackTrace) => Center(child: Text(e.toString())),
            loading: () => Center(child: CircularProgressIndicator()),
          ),
        ],
      ),
    );
  }
}
