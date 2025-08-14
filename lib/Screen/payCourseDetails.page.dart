import 'package:eduma_app/data/Controller/popularCourseController.dart';
import 'package:eduma_app/data/Controller/wishlistControllerClass.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';

class PayCourseDetailsPage extends ConsumerStatefulWidget {
  final String id;
  const PayCourseDetailsPage({super.key, required this.id});

  @override
  ConsumerState<PayCourseDetailsPage> createState() =>
      _PayCourseDetailsPageState();
}

class _PayCourseDetailsPageState extends ConsumerState<PayCourseDetailsPage> {
  bool isLoading = false;
  bool isWishlisted = false;
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
          return Stack(
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
                  SizedBox(height: 20.h),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.only(left: 20.w, right: 20.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10.r),
                                  child: Image.network(
                                    //  "assets/reading.png",
                                    courseDetails.thumbnail,
                                    width: 400.w,
                                    height: 254.h,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: IconButton(
                                    // style: IconButton.styleFrom(
                                    //   minimumSize: Size(0, 0),
                                    //   padding: EdgeInsets.zero,
                                    //   tapTargetSize: MaterialTapTargetSize
                                    //       .shrinkWrap,
                                    // ),
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
                            SizedBox(height: 20.h),
                            Row(
                              children: [
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
                                  "₹ 45k",
                                  style: GoogleFonts.roboto(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF001E6C),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 19.h),
                            Text(
                              //"25th Workshop based on Treasure of Treatise -18",
                              courseDetails.title,
                              style: GoogleFonts.roboto(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF000000),
                                letterSpacing: -1,
                              ),
                            ),
                            SizedBox(height: 14.h),
                            Text(
                              "Unlock ancient wisdom for personal growth",
                              style: GoogleFonts.roboto(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF000000),
                                letterSpacing: -0.4,
                              ),
                            ),
                            SizedBox(height: 15.h),
                            Row(
                              children: [
                                Image.asset("assets/modul.png"),
                                SizedBox(width: 10.w),
                                Text(
                                  "5 Modules",
                                  style: GoogleFonts.roboto(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF000000),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 15.h),
                            Row(
                              children: [
                                Image.asset("assets/time.png"),
                                SizedBox(width: 10.w),
                                Text(
                                  "Life time Access",
                                  style: GoogleFonts.roboto(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF000000),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 25.h),
                            Text(
                              "Overview",
                              style: GoogleFonts.roboto(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF000000),
                                letterSpacing: -0.2,
                              ),
                            ),
                            SizedBox(height: 12.h),
                            Text(
                              // "The 25th Workshop based on Treasure of Treatise -18 is a deep dive into the ancient scriptures and texts, uncovering hidden gems of knowledge and wisdom. Participants will explore the rich heritage of ancient treatises and unlock valuable insights for personal growth and development.",
                              courseDetails.description,
                              style: GoogleFonts.roboto(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF000000),
                                letterSpacing: -0.4,
                              ),
                            ),
                            SizedBox(height: 25.h),
                            Text(
                              "Key highlights",
                              style: GoogleFonts.roboto(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF000000),
                                letterSpacing: -0.2,
                              ),
                            ),
                            SizedBox(height: 15.h),
                            Row(
                              children: [
                                SizedBox(width: 6.w),
                                CircleAvatar(
                                  backgroundColor: Color(0xFF000000),
                                  radius: 3.r,
                                ),
                                SizedBox(width: 10.w),
                                Text(
                                  "Ancient wisdom exploration",
                                  style: GoogleFonts.roboto(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF000000),
                                    letterSpacing: -0.4,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.h),
                            Row(
                              children: [
                                SizedBox(width: 6.w),
                                CircleAvatar(
                                  backgroundColor: Color(0xFF000000),
                                  radius: 3.r,
                                ),
                                SizedBox(width: 10.w),
                                Text(
                                  "Personal growth insights",
                                  style: GoogleFonts.roboto(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF000000),
                                    letterSpacing: -0.4,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.h),
                            Row(
                              children: [
                                SizedBox(width: 6.w),
                                CircleAvatar(
                                  backgroundColor: Color(0xFF000000),
                                  radius: 3.r,
                                ),
                                SizedBox(width: 10.w),
                                Text(
                                  "Interactive learning sessions",
                                  style: GoogleFonts.roboto(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF000000),
                                    letterSpacing: -0.4,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.h),
                            Row(
                              children: [
                                SizedBox(width: 6.w),
                                CircleAvatar(
                                  backgroundColor: Color(0xFF000000),
                                  radius: 3.r,
                                ),
                                SizedBox(width: 10.w),
                                Text(
                                  "Ancient wisdom exploration",
                                  style: GoogleFonts.roboto(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF000000),
                                    letterSpacing: -0.4,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.h),
                            Row(
                              children: [
                                SizedBox(width: 6.w),
                                CircleAvatar(
                                  backgroundColor: Color(0xFF000000),
                                  radius: 3.r,
                                ),
                                SizedBox(width: 10.w),
                                Text(
                                  "Personal growth insights",
                                  style: GoogleFonts.roboto(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF000000),
                                    letterSpacing: -0.4,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.h),
                            Row(
                              children: [
                                SizedBox(width: 6.w),
                                CircleAvatar(
                                  backgroundColor: Color(0xFF000000),
                                  radius: 3.r,
                                ),
                                SizedBox(width: 10.w),
                                Text(
                                  "Interactive learning sessions",
                                  style: GoogleFonts.roboto(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF000000),
                                    letterSpacing: -0.4,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16.h),
                            Text(
                              "What you will learn",
                              style: GoogleFonts.roboto(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF000000),
                                letterSpacing: -0.2,
                              ),
                            ),
                            SizedBox(height: 15.h),
                            Container(
                              padding: EdgeInsets.only(
                                left: 20.w,
                                right: 20.w,
                                top: 16.h,
                                bottom: 16.h,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                color: Color.fromARGB(40, 16, 30, 108),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset("assets/play.png"),
                                  SizedBox(height: 12.h),
                                  Text(
                                    "Explore Ancient Treatises",
                                    style: GoogleFonts.roboto(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF000000),
                                      letterSpacing: -0.4,
                                    ),
                                  ),
                                  SizedBox(height: 10.h),
                                  Text(
                                    "Dive into the depths of ancient scriptures and texts to unravel timeless wisdom.",
                                    style: GoogleFonts.roboto(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF000000),
                                      letterSpacing: -0.4,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20.h),
                            Text(
                              "Modules",
                              style: GoogleFonts.roboto(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF000000),
                                letterSpacing: -0.4,
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Container(
                              padding: EdgeInsets.only(
                                left: 10.w,
                                right: 10.w,
                                top: 10.h,
                                bottom: 10.h,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                color: Color(0xFFFFFFFF),
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset(0, 1),
                                    spreadRadius: 0,
                                    blurRadius: 4,
                                    color: Color.fromARGB(63, 0, 0, 0),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  modules(
                                    "PDF for 25th Workshop - Tongu Diagram Treatise 18",
                                  ),
                                  SizedBox(height: 6.h),
                                  Divider(color: Color(0xFFBFBFBF)),
                                  SizedBox(height: 6.h),
                                  modules("Day-1"),
                                  Divider(color: Color(0xFFBFBFBF)),
                                  SizedBox(height: 6.h),
                                  modules("Day-2"),
                                  Divider(color: Color(0xFFBFBFBF)),
                                  SizedBox(height: 6.h),
                                  modules("Day-3"),
                                  Divider(color: Color(0xFFBFBFBF)),
                                  SizedBox(height: 6.h),
                                  modules("Day-4"),
                                ],
                              ),
                            ),
                            SizedBox(height: 20.h),
                            Text(
                              "FAQs ",
                              style: GoogleFonts.roboto(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF000000),
                                letterSpacing: -0.4,
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Container(
                              padding: EdgeInsets.only(
                                left: 10.w,
                                right: 10.w,
                                top: 10.h,
                                bottom: 10.h,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                color: Color(0xFFFFFFFF),
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset(0, 1),
                                    spreadRadius: 0,
                                    blurRadius: 4,
                                    color: Color.fromARGB(63, 0, 0, 0),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  faq("How can I enrol in a course?"),
                                  SizedBox(height: 6.h),
                                  Divider(color: Color(0xFFBFBFBF)),
                                  faq(
                                    "Canl access the course materials any device?",
                                  ),
                                  SizedBox(height: 6.h),
                                  Divider(color: Color(0xFFBFBFBF)),
                                  SizedBox(height: 6.h),
                                  faq("How can I access the course materials?"),
                                  SizedBox(height: 6.h),
                                  Divider(color: Color(0xFFBFBFBF)),
                                  faq("How can I access the course materials?"),
                                  SizedBox(height: 6.h),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
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
                                SizedBox(height: 20.h),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        minimumSize: Size(101.w, 39.h),
                                        backgroundColor: Color(0xFF001E6C),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            5.r,
                                          ),
                                        ),
                                      ),
                                      onPressed: () {},
                                      child: Text(
                                        "Restore",
                                        style: GoogleFonts.roboto(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xFFFFFFFF),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 20.w),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        minimumSize: Size(101.w, 39.h),
                                        backgroundColor: Color(0xFF001E6C),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            5.r,
                                          ),
                                        ),
                                      ),
                                      onPressed: () {},
                                      child: Text(
                                        "Add to Cart",
                                        style: GoogleFonts.roboto(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xFFFFFFFF),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
        error: (error, stackTrace) => Center(child: Text(error.toString())),
        loading: () => Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Widget modules(String name) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 275.w,
              child: Text(
                name,
                style: GoogleFonts.roboto(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF000000),
                  letterSpacing: -0.4,
                  height: 1.1,
                ),
              ),
            ),
            Icon(
              Icons.keyboard_arrow_down_outlined,
              color: Color(0xFF001E6C),
              size: 30.sp,
            ),
          ],
        ),
        SizedBox(height: 10.h),
        Text(
          "1 Attachment(s)",
          style: GoogleFonts.roboto(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: Color(0xFF000000),
            letterSpacing: -0.3,
          ),
        ),
      ],
    );
  }

  Widget faq(String name) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 275.w,
          child: Text(
            name,
            style: GoogleFonts.roboto(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: Color(0xFF000000),
              letterSpacing: -0.4,
              height: 1.1,
            ),
          ),
        ),
        Icon(
          Icons.keyboard_arrow_down_outlined,
          color: Color(0xFF001E6C),
          size: 30.sp,
        ),
      ],
    );
  }
}
