import 'dart:developer';
import 'package:eduma_app/data/Controller/popularCourseController.dart';
import 'package:eduma_app/data/Controller/wishlistControllerClass.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CourseDetailsPage extends ConsumerStatefulWidget {
  final String id;

  const CourseDetailsPage({super.key, required this.id});

  @override
  ConsumerState<CourseDetailsPage> createState() => _CourseDetailsPageState();
}

class _CourseDetailsPageState extends ConsumerState<CourseDetailsPage> {
  bool isWishlisted = false;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    var box = Hive.box("userBox");
    final courseDetailsProvider = ref.watch(
      popularCourseDetailsController(widget.id),
    );
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: courseDetailsProvider.when(
        data: (courseDetails) {
          // if (courseDetails.isEmpty) {
          //   return Center(child: Text("No Course Available"));
          // }
          return Stack(
            children: [
              Positioned(
                left: -100,
                top: -60.h,
                child: Image.asset(
                  "assets/vec.png",
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
                      SizedBox(width: 20.w),
                      Container(
                        width: 37.w,
                        height: 37.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromARGB(25, 0, 0, 0),
                        ),
                        child: IconButton(
                          style: IconButton.styleFrom(
                            minimumSize: Size(0, 0),
                            padding: EdgeInsets.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            color: Color(0xFF001E6C),
                            size: 20.sp,
                          ),
                        ),
                      ),
                      SizedBox(width: 50.w),
                      Text(
                        "Course Details",
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
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              left: 20.w,
                              right: 20.w,
                              top: 20.h,
                            ),
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10.r),
                                  child: Image.network(
                                    // "assets/reading.png",
                                    courseDetails.thumbnail.toString(),
                                    width: 400.w,
                                    height: 254.h,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: IconButton(
                                    onPressed: isLoading
                                        ? null
                                        : () async {
                                            setState(() => isLoading = true);

                                            isWishlisted =
                                                await WishlistControllerClass.toggle(
                                                  context: context,
                                                  courseId: courseDetails.id,
                                                  userId: box.get("storeId"),
                                                  currentStatus: isWishlisted,
                                                );
                                            setState(() => isLoading = false);

                                            // final body = WishlistBodyModel(
                                            //   courseId: courseDetails.id,
                                            //   userId: box.get("storeId"),
                                            // );
                                            // try {
                                            //   final service = APIStateNetwork(
                                            //     createDio(),
                                            //   );
                                            //   final response = await service
                                            //       .wishlist(body);
                                            //   if (response != null) {
                                            //     showSuccessMessage(
                                            //       context,
                                            //       response.message,
                                            //     );
                                            //   }
                                            //   setState(() {
                                            //     isWishlisted = !isWishlisted;
                                            //   });
                                            // } catch (e) {
                                            //   log(e.toString());
                                            // }
                                          },
                                    icon: isLoading
                                        ? SizedBox(
                                            height: 20,
                                            width: 20,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                              color: Color(0xFF001E6C),
                                            ),
                                          )
                                        : Icon(
                                            isWishlisted
                                                ? Icons.favorite
                                                : Icons.favorite_border,
                                            color: isWishlisted
                                                ? Colors.red
                                                : Colors.white,
                                            size: 25.sp,
                                          ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20.h),
                          Row(
                            children: [
                              SizedBox(width: 20.w),
                              Icon(
                                Icons.access_time,
                                color: Color(0xFFFE4A55),
                                size: 18.sp,
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                "10 week",
                                style: GoogleFonts.roboto(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF747272),
                                  letterSpacing: -0.4,
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Icon(
                                Icons.person,
                                color: Color(0xFFFE4A55),
                                size: 18.sp,
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                "332",
                                style: GoogleFonts.roboto(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF747272),
                                  letterSpacing: -0.4,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "Free",
                                style: GoogleFonts.roboto(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF000000),
                                ),
                              ),
                              SizedBox(width: 20.w),
                            ],
                          ),
                          SizedBox(height: 20.w),
                          Padding(
                            padding: EdgeInsets.only(left: 20.w, right: 20.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Overview",
                                  style: GoogleFonts.roboto(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF000000),
                                    letterSpacing: -0.2,
                                  ),
                                ),
                                SizedBox(height: 10.h),
                                Text(
                                  // "With over 5 years of experience, I've guided 300+ students to land jobs in top companies like Google, TCS, and Deloitte. My sessions focus on mock interviews, resume building, and effective communication",
                                  courseDetails.excerpt.toString(),
                                  style: GoogleFonts.roboto(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF666666),
                                    letterSpacing: -0.4,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 20.w, top: 20.h),
                            child: Text(
                              "Curriculum",
                              style: GoogleFonts.roboto(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF000000),
                                letterSpacing: -0.2,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10.w, right: 20.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Curriculum(
                                  number: 3,
                                  icon: Icons.arrow_drop_up,
                                ),
                                SizedBox(height: 20.h),
                                learnbuild("LMS Website and learn Press"),
                                SizedBox(height: 10.h),
                                learnbuild("LMS Website and learn Press"),
                                SizedBox(height: 10.h),
                                learnbuild("LMS Website and learn Press"),
                                SizedBox(height: 10.h),
                                Curriculum(
                                  number: 2,
                                  icon: Icons.arrow_drop_down,
                                ),
                                Curriculum(
                                  number: 4,
                                  icon: Icons.arrow_drop_down,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 16.h),
                          Padding(
                            padding: EdgeInsets.only(left: 20.w, right: 20.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Divider(),
                                Container(
                                  margin: EdgeInsets.only(top: 20.h),
                                  width: 45.w,
                                  height: 45.h,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey,
                                    image: DecorationImage(
                                      image: AssetImage("assets/tesla.png"),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10.h),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      "assets/birds.png",
                                      color: Color(0xFFA0A0A0),
                                    ),
                                    SizedBox(width: 10.w),
                                    Image.asset(
                                      "assets/call.png",
                                      color: Color(0xFFA0A0A0),
                                    ),
                                    SizedBox(width: 10.w),
                                    Image.asset(
                                      "assets/insta.png",
                                      color: Color(0xFFA0A0A0),
                                    ),
                                    SizedBox(width: 10.w),
                                    Image.asset(
                                      "assets/a.png",
                                      color: Color(0xFFA0A0A0),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20.h),
                                Text(
                                  "With over 5 years of experience, I've guided 300+ students to land jobs in top companies like Google, TCS, and Deloitte. My sessions focus on mock interviews, resume building, and effective communication",
                                  style: GoogleFonts.roboto(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF666666),
                                    letterSpacing: -0.4,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 20.h,
                              right: 20.w,
                              top: 20.h,
                            ),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(400.w, 56.h),
                                backgroundColor: Color(0xFF001E6C),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.r),
                                ),
                              ),
                              onPressed: () {
                                // Navigator.push(
                                //   context,
                                //   CupertinoPageRoute(
                                //     builder: (context) => PayCourseDetailsPage(
                                //       id: courseDetails.id.toString(),
                                //     ),
                                //   ),
                                // );
                              },
                              child: Text(
                                "Start Now",
                                style: GoogleFonts.roboto(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFFFFFFFF),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20.h),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
        error: (error, stackTrace) {
          log(error.toString());
          return Center(child: Text(error.toString()));
        },
        loading: () => Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Widget learnbuild(String txt) {
    return Row(
      children: [
        SizedBox(width: 10.w),
        Image.asset(
          "assets/notebook.png",
          width: 20.w,
          height: 20.h,
          fit: BoxFit.contain,
          color: Color(0xFF001E6C),
        ),
        SizedBox(width: 10.w),
        Text(
          txt,
          style: GoogleFonts.roboto(
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
            color: Color.fromARGB(153, 0, 0, 0),
            letterSpacing: -0.4,
          ),
        ),
        Spacer(),
        Icon(Icons.visibility_outlined, color: Color(0xFF1BB93D)),
        SizedBox(width: 8.w),
        Text(
          "30 Minutes",
          style: GoogleFonts.roboto(
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
            color: Color.fromARGB(153, 0, 0, 0),
            letterSpacing: -0.4,
          ),
        ),
      ],
    );
  }
}

class Curriculum extends StatelessWidget {
  final int number;
  final IconData icon;
  const Curriculum({super.key, required this.number, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 35.w,
          height: 35.h,
          padding: EdgeInsets.zero,
          //color: Colors.amberAccent,
          child: Icon(icon, size: 40.sp, color: Color(0xFF000000)),
        ),
        Padding(
          padding: EdgeInsets.only(top: 5.h),
          child: Text(
            "Learn Press Introduction",
            style: GoogleFonts.roboto(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Color(0xFF000000),
            ),
          ),
        ),
        Spacer(),
        Padding(
          padding: EdgeInsets.only(top: 5.h),
          child: Text(
            number.toString(),
            style: GoogleFonts.roboto(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Color(0xFF000000),
            ),
          ),
        ),
      ],
    );
  }
}
