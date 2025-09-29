import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:eduma_app/Screen/enrolledCourseDetails.page.dart'
    hide Attachment;
import 'package:eduma_app/Screen/home.page.dart';
import 'package:eduma_app/Screen/library.page.dart';
import 'package:eduma_app/Screen/login.page.dart';
import 'package:eduma_app/config/core/showFlushbar.dart';
import 'package:eduma_app/config/network/api.state.dart';
import 'package:eduma_app/config/utils/pretty.dio.dart';
import 'package:eduma_app/data/Controller/enrolleCourseController.dart';
import 'package:eduma_app/data/Controller/popularCourseController.dart';
import 'package:eduma_app/data/Controller/wishlistControllerClass.dart';
import 'package:eduma_app/data/Model/createOrderBodyModel.dart';
import 'package:eduma_app/data/Model/enrollBodyModel.dart';
import 'package:eduma_app/data/Model/popularCourseDetailsModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

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
  bool isCheck = false;
  bool enrolled = false;
  bool isCheckingEnrollment = true;

  int parseAmountInRupees(String price) {
    // remove ₹ , commas, and spaces
    final cleaned = price.replaceAll(RegExp(r'[^0-9.]'), '');
    return int.tryParse(cleaned.split(".").first) ?? 0;
  }

  @override
  void initState() {
    super.initState();
    _checkEnrollmentStatus();
  }

  Future<void> _checkEnrollmentStatus() async {
    var box = Hive.box("userBox");
    var token = box.get("token");

    List<String> enrolledCourses = box.get(
      "enrolledCourses",
      defaultValue: <String>[],
    );
    if (enrolledCourses.contains(widget.id)) {
      setState(() {
        enrolled = true;
        isCheckingEnrollment = false;
      });
      return;
    }
    if (token != null) {
      try {
        final enrolledCoursesData = await ref.read(
          enrollCourseController.future,
        );

        final isEnrolled =
            enrolledCoursesData.courses?.any(
              (course) => course.id == widget.id,
            ) ??
            false;

        setState(() {
          enrolled = isEnrolled;
          isCheckingEnrollment = false;
        });

        if (isEnrolled && !enrolledCourses.contains(widget.id)) {
          enrolledCourses.add(widget.id);
          box.put("enrolledCourses", enrolledCourses);
        }
      } catch (e) {
        log("Error checking enrollment status: $e");

        setState(() {
          isCheckingEnrollment = false;
        });
        if (context.mounted) {
          showSuccessMessage(
            context,
            "Failed to check enrollment status. Please try again.",
          );
        }
      }
    } else {
      setState(() {
        isCheckingEnrollment = false;
      });
    }
  }

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
              (courseDetails.price is num && courseDetails.price == 0) ||
              courseDetails.price.toString() == "0" ||
              courseDetails.price.toString() == "0.0" ||
              courseDetails.price.toString().toLowerCase() == "free";

          log("Is Free: $isFree");

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
                                          'https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/832px-No-Image-Placeholder.png',
                                      width: 400.w,
                                      height: 254.h,
                                      fit: BoxFit.fill,
                                      errorBuilder: (context, error, stackTrace) {
                                        return Image.network(
                                          "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/832px-No-Image-Placeholder.png",

                                          width: 400.w,
                                          height: 254.h,
                                          fit: BoxFit.cover,
                                        );
                                      },
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: IconButton(
                                      onPressed: isLoading
                                          ? null
                                          : () async {
                                              if (token == null) {
                                                Navigator.push(
                                                  context,
                                                  CupertinoPageRoute(
                                                    builder: (context) =>
                                                        LoginPage(),
                                                  ),
                                                );
                                                showSuccessMessage(
                                                  context,
                                                  "please login first",
                                                );
                                                return;
                                              }
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
                                                  : Colors.black,
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
                                    // "${(courseDetails.price == null || courseDetails.price.toString().isEmpty) ? "0" : courseDetails.price}",
                                    courseDetails.price.toString(),
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
                                // child: Column(
                                //   crossAxisAlignment: CrossAxisAlignment.start,
                                //   children: [
                                //     // ...courseDetails.topics!.map(
                                //     //   (lesson) => modules(
                                //     //     lesson.lessons!
                                //     //         .map((e) => e.lessonTitle)
                                //     //         .toString(),
                                //     //     lesson.lessons!
                                //     //         .map(
                                //     //           (e) => e.lessonMeta!.video
                                //     //               .toString(),
                                //     //         )
                                //     //         .toString(),
                                //     //   ),
                                //     // ),

                                //     // ...courseDetails.topics!.expand(
                                //     //   (topic) => topic.lessons!.map(
                                //     //     (lesson) => modules(
                                //     //       lesson.lessonTitle ??
                                //     //           "Untitled Lesson",
                                //     //       lesson.lessonMeta?.video
                                //     //               ?.toString() ??
                                //     //           "",
                                //     //     ),
                                //     //   ),
                                //     // ),
                                //     ///////////////////////////////////////////
                                //     ...courseDetails.topics!.expand(
                                //       (topic) => topic.lessons!.map(
                                //         (lesson) => newmodules(
                                //           lesson.lessonTitle ?? "",
                                //           lesson.lessonMeta?.video?.firstOrNull
                                //                   ?.toString() ??
                                //               "",
                                //           attachments: lesson
                                //               .attachments, // Lesson से attachments पास करें
                                //         ),
                                //       ),
                                //     ),
                                //   ],
                                // ),
                                child: Column(
                                  children: courseDetails.topics!
                                      .expand(
                                        (topic) => topic.lessons!.map(
                                          (lesson) => ModuleWidget(
                                            title: lesson.lessonTitle ?? "",
                                            videoUrl:
                                                lesson
                                                    .lessonMeta
                                                    ?.video
                                                    ?.firstOrNull ??
                                                "",
                                            attachments: lesson.attachments,
                                            isFree: isFree,
                                          ),
                                        ),
                                      )
                                      .toList(),
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
                                    faq(
                                      "How can I enrol in a course?",
                                      "Enroling in a course is simple! Just browse through our website, select the course you are interest in, and click on the Enroll Now button. Follow the prompts to complete the enrolment process, and you'll gain immediate access to the course materials.",
                                    ),
                                    SizedBox(height: 6.h),
                                    Divider(color: Color(0xFFBFBFBF)),
                                    faq(
                                      "Can l access the course materials any device?",
                                      "Yes, our platform is designed to be accessible on various devices, including computers, laptops, tabletsm and smartphones. you can access the course materials anytime, anywherem as long as you have an internet connection.",
                                    ),
                                    SizedBox(height: 6.h),
                                    Divider(color: Color(0xFFBFBFBF)),
                                    faq(
                                      "How can I access the course materials?",
                                      "Once you enrol in a course you well gain access to a dedicated online learning plaform. All course materials, including video lessons, lecture notes and supplementary resourseces, can be accessed conveniently through the plarform at any time.",
                                    ),
                                    SizedBox(height: 6.h),
                                    Divider(color: Color(0xFFBFBFBF)),
                                    faq(
                                      "Can I interact with the instructor during the course?",
                                      "Absolutely! we are committed to providing an engaging and interactive learning experience, You will have oppourtunities to interact with them through our community. Take full advantage to enhance your understanding to enhance your understanding and gain insights directly from the expert.",
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
                              backgroundColor: Color(0xFF3e64de),
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
                                    // Store in Hive
                                    var box = Hive.box("userBox");
                                    List<String> enrolledCourses = box.get(
                                      "enrolledCourses",
                                      defaultValue: <String>[],
                                    );
                                    if (!enrolledCourses.contains(
                                      courseDetails.id.toString(),
                                    )) {
                                      enrolledCourses.add(
                                        courseDetails.id.toString(),
                                      );
                                      box.put(
                                        "enrolledCourses",
                                        enrolledCourses,
                                      );
                                    }

                                    // Invalidate provider to refresh enrolled courses
                                    ref.invalidate(enrollCourseController);
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
                                                  0xFF3e64de,
                                                ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                              ),
                                              onPressed: () {
                                                // ✅ pehle enrollCourseController ko refresh kar do
                                                ref.refresh(
                                                  enrollCourseController,
                                                );
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
                              enrolled ? "Continue" : "Get for free",
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
                : Container(
                    margin: EdgeInsets.only(
                      left: 20.w,
                      right: 20.w,
                      top: 10.h,
                      bottom: 10.h,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          courseDetails.price != null
                              ? "${courseDetails.price.toString()}"
                              : "N/A",
                          style: GoogleFonts.roboto(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(60.w, 50.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            backgroundColor: Color(0xFF3e64de),
                          ),
                          onPressed: () async {
                            setState(() {
                              isCheck = true;
                            });
                            try {
                              final body = CreateOrderCourseBodyModel(
                                courseId: courseDetails.id.toString(),
                                price: parseAmountInRupees(
                                  courseDetails.price.toString(),
                                ).toString(),
                              );

                              final sevice = APIStateNetwork(createDio());
                              final respnse = await sevice.courseCreateOrder(
                                body,
                              );

                              if (respnse == null) {
                                showErrorMessage(
                                  "Order create failed, please try again",
                                );
                                setState(() => isCheck = false);
                                return;
                              }

                              final razorpay = Razorpay();

                              final options = {
                                "order_id": respnse.orderId,
                                "amount": respnse.amount,
                                "currency": respnse.currency,
                                "receipt": respnse.receipt,
                                "key": respnse.razorpayKey,
                                "tutor_order_id": 8,
                                "user": {
                                  "name": respnse.user.name,
                                  "email": respnse.user.email,
                                  "contact": respnse.user.contact,
                                },
                                "course_id": respnse.courseId,
                              };

                              razorpay.open(options);

                              razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, (
                                PaymentSuccessResponse response,
                              ) {
                                log("Payment Success : ${response.paymentId}");
                                showSuccessMessage(
                                  context,
                                  "Payment Successful",
                                );
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => HomePage(),
                                  ),
                                  (route) => false,
                                );
                              });

                              razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, (
                                PaymentFailureResponse response,
                              ) {
                                log("Payment Failed : ${response.message}");
                                showErrorMessage(
                                  "Payment Failed : ${response.message}",
                                );
                              });

                              razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, (
                                ExternalWalletResponse response,
                              ) {
                                log("External Wallet : ${response.walletName}");
                              });
                            } catch (e) {
                              showErrorMessage("Something went wrong: $e");
                              log(e.toString());
                            } finally {
                              setState(() => isCheck = false);
                            }
                          },
                          child: isCheck
                              ? SizedBox(
                                  height: 22,
                                  width: 22,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              : Text(
                                  "Buy Now",
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
          );
        },
        error: (error, stackTrace) => Center(child: Text(error.toString())),
        loading: () => Center(child: CircularProgressIndicator()),
      ),
    );
  }

  // Widget modules(String title, String videoUrl, {String? pdfUrl}) {
  //   final videoId = _extractYouTubeId(videoUrl);
  //   final displayTitle = videoId.isNotEmpty ? title : "No Video";
  //   return Card(
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
  //     margin: EdgeInsets.symmetric(vertical: 8.h),
  //     elevation: 2,
  //     child: ExpansionTile(
  //       tilePadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
  //       childrenPadding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 12.h),
  //       collapsedShape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(12.r),
  //       ),
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(12.r),
  //       ),
  //       backgroundColor: Colors.white,
  //       collapsedBackgroundColor: Colors.white,
  //       title: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text(
  //             title,
  //             maxLines: 1,
  //             overflow: TextOverflow.ellipsis,
  //             style: GoogleFonts.roboto(
  //               fontSize: 16.sp,
  //               fontWeight: FontWeight.w600,
  //               color: const Color.fromARGB(255, 1, 1, 1),
  //             ),
  //           ),
  //           SizedBox(height: 4.h),
  //           Text(
  //             videoId.isNotEmpty ? "1 Video" : "No Video Available",
  //             style: GoogleFonts.roboto(
  //               fontSize: 13.sp,
  //               fontWeight: FontWeight.w400,
  //               color: Colors.grey[600],
  //             ),
  //           ),
  //         ],
  //       ),
  //       children: [
  //         InkWell(
  //           borderRadius: BorderRadius.circular(8.r),
  //           onTap: () {},
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             mainAxisAlignment: MainAxisAlignment.start,
  //             children: [
  //               Divider(color: Color(0xFFBFBFBF), thickness: 0.90.w),
  //               SizedBox(height: 10.h),
  //               Row(
  //                 children: [
  //                   Icon(Icons.ondemand_video, size: 50.sp),
  //                   SizedBox(width: 12.w),
  //                   Expanded(
  //                     child: Text(
  //                       displayTitle,
  //                       maxLines: 2,
  //                       overflow: TextOverflow.ellipsis,
  //                       style: GoogleFonts.roboto(
  //                         fontSize: 15.sp,
  //                         fontWeight: FontWeight.w500,
  //                         color: Colors.black87,
  //                       ),
  //                     ),
  //                   ),
  //                   if (title.toLowerCase().contains("pdf"))
  //                     IconButton(
  //                       icon: Icon(Icons.downloading_sharp, size: 25.sp),
  //                       onPressed: () async {
  //                         final filePath = await downloadPdf();

  //                         if (filePath != null) {
  //                           if (context.mounted) {
  //                             ScaffoldMessenger.of(context).showSnackBar(
  //                               SnackBar(
  //                                 content: Text("PDF Downloaded at: $filePath"),
  //                               ),
  //                             );
  //                           }
  //                           await OpenFilex.open(filePath);
  //                         }
  //                       },
  //                     ),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  String _extractYouTubeId(String url) {
    RegExp regExp = RegExp(
      r'^.*((youtu.be\/)|(v\/)|(\/u\/\w\/)|(embed\/)|(watch\?v=))([^#\&\?]*).*',
      caseSensitive: false,
    );
    Match? match = regExp.firstMatch(url);
    return match != null && match.group(7)!.length == 11 ? match.group(7)! : '';
  }

  Widget faq(String name, String answer) {
    return ExpansionTile(
      childrenPadding: EdgeInsets.only(left: 16.w, right: 16.w),
      collapsedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      backgroundColor: Colors.white,
      collapsedBackgroundColor: Colors.white,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
        ],
      ),
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              //color: Colors.amber,
              width: MediaQuery.of(context).size.width / 1.2,
              child: Text(
                answer,
                style: GoogleFonts.roboto(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.grey[700],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  //////////
  Widget newmodules(
    String title,
    String videoUrl, {
    List<Attachment>? attachments,
    bool isdownloading = false,
  }) {
    final videoId = newextractYouTubeId(videoUrl);

    final pdfAttachment = attachments?.firstWhere(
      (attachment) => attachment.type?.toLowerCase() == "application/pdf",
      orElse: () => Attachment(),
    );

    final isPdfAvailable =
        pdfAttachment != null &&
        pdfAttachment.url != null &&
        pdfAttachment.url!.isNotEmpty;

    final isVideoAvailable = videoId.isNotEmpty;
    // ✅ check if title me "pdf" hai
    final bool isPdfTitle = title.toLowerCase().contains("pdf");

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
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.roboto(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              isPdfTitle
                  ? (isPdfAvailable ? "1 PDF" : "No PDF Available")
                  : (isVideoAvailable ? "1 Video" : "No Video Available"),
              style: GoogleFonts.roboto(
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
        children: [
          if (isPdfTitle && isPdfAvailable)
            Row(
              children: [
                Icon(Icons.picture_as_pdf, size: 50.sp, color: Colors.red),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    "${pdfAttachment!.title ?? title} (PDF)",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.roboto(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ),
                isdownloading
                    ? CircularProgressIndicator()
                    : IconButton(
                        icon: Icon(Icons.downloading_sharp, size: 25.sp),
                        onPressed: () async {
                          setState(() {
                            isdownloading = true;
                          });
                          final filePath = await newdownloadPdf(
                            pdfAttachment.url!,
                            pdfAttachment.title ?? "$title.pdf",
                          );

                          if (filePath != null && context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "PDF download complete: $filePath",
                                ),
                              ),
                            );
                            await OpenFilex.open(
                              filePath,
                              type: "application/pdf",
                            );
                          } else if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Download failed")),
                            );
                          }
                        },
                      ),
              ],
            ),

          //  if (isVideoAvailable)
          if (!isPdfTitle && isVideoAvailable)
            InkWell(
              onTap: () {
                // yahan apna video player open karna
                log("Play video with id: $videoId");
              },
              child: Row(
                children: [
                  Icon(Icons.ondemand_video, size: 50.sp, color: Colors.blue),
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
                ],
              ),
            ),
        ],
      ),
    );
  }

  String newextractYouTubeId(String url) {
    RegExp regExp = RegExp(
      r'^.*((youtu.be\/)|(v\/)|(\/u\/\w\/)|(embed\/)|(watch\?v=))([^#\&\?]*).*',
      caseSensitive: false,
    );
    Match? match = regExp.firstMatch(url);
    return match != null && match.group(7)!.length == 11 ? match.group(7)! : '';
  }

  Future<String?> newdownloadPdf(String url, String fileName) async {
    try {
      if (Platform.isAndroid) {
        if (!await Permission.storage.isGranted) {
          await Permission.storage.request();
        }
      }

      Directory dir =
          await getExternalStorageDirectory() ??
          await getApplicationDocumentsDirectory();

      if (!dir.existsSync()) dir.createSync(recursive: true);

      fileName = fileName.replaceAll(RegExp(r'[\\/:*?"<>|]'), '_');

      final filePath = "${dir.path}/$fileName";

      await Dio().download(
        url,
        filePath,
        options: Options(
          followRedirects: true,
          responseType: ResponseType.bytes,
          headers: {"Accept": "application/pdf"},
          validateStatus: (status) => status != null && status < 500,
        ),
      );
      log("✅ PDF download complete: $filePath");
      return filePath;
    } catch (e) {
      log("Error: $e");
      return null;
    }
  }
}

////////////////////////////////////////////////
/////////////////////////////////////

class ModuleWidget extends StatefulWidget {
  final String title;
  final String videoUrl;
  final List<Attachment>? attachments;
  final bool isFree;
  const ModuleWidget({
    super.key,
    required this.title,
    required this.videoUrl,
    this.attachments,
    required this.isFree,
  });

  @override
  State<ModuleWidget> createState() => _ModuleWidgetState();
}

class _ModuleWidgetState extends State<ModuleWidget> {
  bool isDownloading = false;
  double downloadProgress = 0.0;
  bool isDownloadComplete = false;

  String extractYouTubeId(String url) {
    RegExp regExp = RegExp(
      r'^.*((youtu.be\/)|(v\/)|(\/u\/\w\/)|(embed\/)|(watch\?v=))([^#\&\?]*).*',
      caseSensitive: false,
    );
    Match? match = regExp.firstMatch(url);
    return match != null && match.group(7)!.length == 11 ? match.group(7)! : '';
  }

  Future<String?> downloadPdf(String url, String fileName) async {
    try {
      if (Platform.isAndroid) {
        if (!await Permission.storage.isGranted) {
          await Permission.storage.request();
        }
      }

      Directory dir =
          await getExternalStorageDirectory() ??
          await getApplicationDocumentsDirectory();

      if (!dir.existsSync()) dir.createSync(recursive: true);

      fileName = fileName.replaceAll(RegExp(r'[\\/:*?"<>|]'), '_');

      final filePath = "${dir.path}/$fileName";

      await Dio().download(
        url,
        filePath,
        options: Options(
          followRedirects: true,
          responseType: ResponseType.bytes,
          headers: {"Accept": "application/pdf"},
          validateStatus: (status) => status != null && status < 500,
        ),

        onReceiveProgress: (received, total) {
          if (total != -1 && mounted) {
            setState(() {
              downloadProgress = (received / total * 100).clamp(0, 100);
            });
          }
        },
      );
      log("✅ PDF download complete: $filePath");
      if (mounted) {
        setState(() {
          isDownloadComplete = true;
        });
      }
      return filePath;
    } catch (e) {
      log("❌ Error: $e");
      if (mounted) {
        setState(() {
          isDownloading = false;
          downloadProgress = 0.0;
        });
      }
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final videoId = extractYouTubeId(widget.videoUrl);

    final pdfAttachment = widget.attachments?.firstWhere(
      (attachment) => attachment.type?.toLowerCase() == "application/pdf",
      orElse: () => Attachment(),
    );

    final isPdfAvailable =
        pdfAttachment != null &&
        pdfAttachment.url != null &&
        pdfAttachment.url!.isNotEmpty;

    final isVideoAvailable = widget.videoUrl.isNotEmpty;

    final bool isPdfTitle = widget.title.toLowerCase().contains("pdf");

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
              widget.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.roboto(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              isPdfTitle
                  ? (isPdfAvailable ? "1 PDF" : "No PDF Available")
                  : (isVideoAvailable ? "1 Video" : "No Video Available"),
              style: GoogleFonts.roboto(
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
        children: [
          if (isPdfTitle && isPdfAvailable)
            Row(
              children: [
                Icon(
                  Icons.picture_as_pdf,
                  size: 50.sp,
                  color: Color(0xFF3e64de),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    "${pdfAttachment!.title ?? widget.title} (PDF)",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.roboto(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ),
                widget.isFree
                    ? isDownloading
                          ? Stack(
                              alignment: Alignment.center,
                              children: [
                                SizedBox(
                                  height: 28.w,
                                  width: 28.w,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    value: downloadProgress / 100,
                                    color: Color(0xFF3e64de),
                                  ),
                                ),
                                Text(
                                  "${downloadProgress.toStringAsFixed(0)}%",
                                  style: GoogleFonts.roboto(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            )
                          : IconButton(
                              icon: Icon(
                                isDownloadComplete
                                    ? Icons.check_circle
                                    : Icons.downloading_sharp,
                                size: 28.sp,
                                color: isDownloadComplete
                                    ? Colors.green
                                    : Colors.black,
                              ),
                              onPressed: isDownloadComplete
                                  ? null // Disable button after download is complete
                                  : () async {
                                      setState(() {
                                        isDownloading = true;
                                        downloadProgress = 0.0;
                                        isDownloadComplete = false;
                                      });
                                      final filePath = await downloadPdf(
                                        pdfAttachment.url!,
                                        pdfAttachment.title ??
                                            "${widget.title}.pdf",
                                      );
                                      if (filePath != null && context.mounted) {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              "PDF download complete: $filePath",
                                            ),
                                          ),
                                        );
                                        await OpenFilex.open(
                                          filePath,
                                          type: "application/pdf",
                                        );
                                      } else if (context.mounted) {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          const SnackBar(
                                            content: Text("Download failed"),
                                          ),
                                        );
                                      }
                                      if (mounted) {
                                        setState(() {
                                          isDownloading = false;
                                        });
                                      }
                                    },
                            )
                    : SizedBox.shrink(),
              ],
            ),
          if (!isPdfTitle && isVideoAvailable)
            InkWell(
              onTap: () {
                log("▶️ Play video with id: $videoId");
              },
              child: Row(
                children: [
                  Image.asset("assets/vi.png"),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      widget.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.roboto(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
