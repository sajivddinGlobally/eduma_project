import 'dart:developer';
import 'package:eduma_app/Screen/enrolledCourseDetails.page.dart';
import 'package:eduma_app/Screen/library.page.dart';
import 'package:eduma_app/Screen/login.page.dart';
import 'package:eduma_app/Screen/video.page.dart';
import 'package:eduma_app/config/core/showFlushbar.dart';
import 'package:eduma_app/config/network/api.state.dart';
import 'package:eduma_app/config/utils/pretty.dio.dart';
import 'package:eduma_app/data/Controller/popularCourseController.dart';
import 'package:eduma_app/data/Controller/wishlistControllerClass.dart';
import 'package:eduma_app/data/Model/enrollBodyModel.dart';
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
  bool enrolled = false;

  @override
  Widget build(BuildContext context) {
    var box = Hive.box("userBox");
    var token = box.get("token");
    final courseDetailsProvider = ref.watch(
      popularCourseDetailsController(widget.id),
    );
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: courseDetailsProvider.when(
        data: (courseDetails) {
          bool isFree =
              courseDetails.price == null ||
              courseDetails.price.toString().isEmpty ||
              courseDetails.price.toString() == "0";
          return Scaffold(
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
                                      courseDetails.thumbnail ??
                                          'https://www.google.com/url?sa=i&url=https%3A%2F%2Fcommons.wikimedia.org%2Fwiki%2FFile%3ANo-Image-Placeholder.svg&psig=AOvVaw1MZ0Y-EQnAjmnyZjr5zMZ3&ust=1755926612664000&source=images&cd=vfe&opi=89978449&ved=0CBIQjRxqFwoTCPiV9cHWnY8DFQAAAAAdAAAAABAE',
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
                                                    courseId:
                                                        courseDetails.id ?? 0,
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
                                    "₹ ${(courseDetails.price == null || courseDetails.price.toString().isEmpty) ? "0" : courseDetails.price}",
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
                                courseDetails.title ?? "",
                                style: GoogleFonts.roboto(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF000000),
                                  letterSpacing: -1,
                                ),
                              ),
                              SizedBox(height: 14.h),
                              Text(
                                courseDetails.description ?? "",
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
                                courseDetails.excerpt ?? "",
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
                                  border: Border.all(
                                    color: Color.fromARGB(63, 0, 0, 0),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // ...courseDetails.topics!.map(
                                    //   (lesson) => modules(
                                    //     lesson.lessons!
                                    //         .map((e) => e.lessonTitle)
                                    //         .toString(),
                                    //     lesson.lessons!
                                    //         .map(
                                    //           (e) => e.lessonMeta!.video
                                    //               .toString(),
                                    //         )
                                    //         .toString(),
                                    //   ),
                                    // ),

                                    // for (var topic in courseDetails.topics!)
                                    //   for (var lesson in topic.lessons!)
                                    //     modules(
                                    //       lesson.lessonTitle ??
                                    //           "Untitled Lesson",
                                    //       lesson.lessonMeta?.video
                                    //               ?.toString() ??
                                    //           "",
                                    //     ),
                                    ...courseDetails.topics!.expand(
                                      (topic) => topic.lessons!.map(
                                        (lesson) => modules(
                                          lesson.lessonTitle ??
                                              "Untitled Lesson",
                                          lesson.lessonMeta?.video
                                                  ?.toString() ??
                                              "",
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 15.h),
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
                                      "Can I access the course materials on any device?",
                                    ),
                                    SizedBox(height: 6.h),
                                    Divider(color: Color(0xFFBFBFBF)),
                                    faq(
                                      "How can I access the course materials?",
                                    ),
                                    SizedBox(height: 6.h),
                                    Divider(color: Color(0xFFBFBFBF)),
                                    faq(
                                      "How can I access the course materials?",
                                    ),
                                    SizedBox(height: 6.h),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(height: 20.h),
                                  Text(
                                    "About the Creator",
                                    style: GoogleFonts.roboto(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 20.h),
                                    width: 50.w,
                                    height: 50.h,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.grey,
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          courseDetails.author?.avatarUrl ??
                                              "https://www.google.com/url?sa=i&url=https%3A%2F%2Fcommons.wikimedia.org%2Fwiki%2FFile%3ANo-Image-Placeholder.svg&psig=AOvVaw1MZ0Y-EQnAjmnyZjr5zMZ3&ust=1755926612664000&source=images&cd=vfe&opi=89978449&ved=0CBIQjRxqFwoTCPiV9cHWnY8DFQAAAAAdAAAAABAE",
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10.h),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                    courseDetails.author?.name ?? "",
                                    style: GoogleFonts.roboto(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF666666),
                                      letterSpacing: -0.4,
                                    ),
                                  ),
                                  SizedBox(height: 20.h),
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
            ),

            bottomNavigationBar: isFree
                ? Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: Offset(0, -2),
                        ),
                      ],
                    ),
                    child: BottomAppBar(
                      color: Colors.transparent,
                      elevation: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(60.w, 50.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              backgroundColor: Color(0xFF001E6C),
                            ),
                            onPressed: () async {
                              if (token == null) {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => LoginPage(),
                                  ),
                                );
                                showSuccessMessage(
                                  context,
                                  "Please Login First",
                                );
                                return;
                              }

                              if (enrolled) {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) =>
                                        EnrolledDourseDetailsPage(
                                          id: courseDetails.id.toString(),
                                        ),
                                  ),
                                );
                              } else {
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (context) {
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          CircularProgressIndicator(),
                                          SizedBox(height: 16),
                                          Text(
                                            "Loading...",
                                            style: GoogleFonts.roboto(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black87,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );

                                final body = EnrollBodyModel(
                                  courseId: courseDetails.id ?? 0,
                                );
                                try {
                                  final service = APIStateNetwork(createDio());
                                  final response = await service.enroll(body);

                                  Navigator.pop(context);

                                  if (response.success == true) {
                                    setState(() {
                                      enrolled = true;
                                    });
                                    await showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              16,
                                            ),
                                          ),
                                          title: Row(
                                            children: [
                                              Icon(
                                                Icons.check_circle,
                                                color: Colors.green,
                                                size: 28,
                                              ),
                                              SizedBox(width: 8),
                                              Text(
                                                "Success",
                                                style: GoogleFonts.roboto(
                                                  fontSize: 18.sp,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                            ],
                                          ),
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                response.message.toString(),
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.roboto(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.black54,
                                                ),
                                              ),
                                            ],
                                          ),
                                          actionsAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              style: TextButton.styleFrom(
                                                foregroundColor:
                                                    Colors.redAccent,
                                              ),
                                              child: Text(
                                                "Close",
                                                style: GoogleFonts.roboto(
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Color(
                                                  0xFF001E6C,
                                                ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                              ),
                                              onPressed: () {
                                                Navigator.pushAndRemoveUntil(
                                                  context,
                                                  CupertinoPageRoute(
                                                    builder: (context) =>
                                                        const LibraryPage(),
                                                    settings:
                                                        const RouteSettings(
                                                          name: "LibraryPage",
                                                        ),
                                                  ),
                                                  (route) => route.isFirst,
                                                );
                                              },
                                              child: Text(
                                                "Go to Library",
                                                style: GoogleFonts.roboto(
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }
                                } catch (err) {
                                  Navigator.pop(context);
                                  log(err.toString());
                                }
                              }
                            },
                            child: Text(
                              enrolled ? "Continue" : "Free to Get",
                              style: GoogleFonts.roboto(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : null,
          );
        },
        error: (error, stackTrace) => Center(child: Text(error.toString())),
        loading: () => Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Widget modules(String title, String videoUrl) {
    final videoId = _extractYouTubeId(videoUrl);
    final displayTitle = videoId.isNotEmpty ? title : "No Video";
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      margin: EdgeInsets.symmetric(vertical: 8.h),
      elevation: 2,
      child: ExpansionTile(
        tilePadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        childrenPadding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 12.h),
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        backgroundColor: Colors.white,
        collapsedBackgroundColor: Colors.white,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              displayTitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.roboto(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: const Color.fromARGB(255, 1, 1, 1),
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              videoId.isNotEmpty ? "1 Video" : "No Video Available",
              style: GoogleFonts.roboto(
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(8.r),
            onTap: () {
              if (videoId.isNotEmpty) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => VideoPge(videoId: videoId)),
                );
              } else {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text("No video")));
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Divider(color: Color(0xFFBFBFBF), thickness: 0.90.w),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.r),
                      child: Image.network(
                        videoId.isNotEmpty
                            ? "https://img.youtube.com/vi/$videoId/0.jpg"
                            : "https://via.placeholder.com/120x90.png?text=No+Video",
                        width: 120.w,
                        height: 70.h,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(10.r),
                            child: Image.network(
                              "https://t4.ftcdn.net/jpg/05/97/47/95/360_F_597479556_7bbQ7t4Z8k3xbAloHFHVdZIizWK1PdOo.jpg",
                              width: 120.w,
                              height: 70.h,
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.roboto(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.play_circle_fill,
                      size: 28.sp,
                      color: Colors.redAccent,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _extractYouTubeId(String url) {
    // Extract YouTube video ID from URL
    RegExp regExp = RegExp(
      r'^.*((youtu.be\/)|(v\/)|(\/u\/\w\/)|(embed\/)|(watch\?v=))([^#\&\?]*).*',
      caseSensitive: false,
    );
    Match? match = regExp.firstMatch(url);
    return match != null && match.group(7)!.length == 11 ? match.group(7)! : '';
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
