import 'dart:math';
import 'package:eduma_app/Screen/continueMyCourse.page.dart';
import 'package:eduma_app/Screen/course.page.dart';
import 'package:eduma_app/Screen/courseDetails.page.dart';
import 'package:eduma_app/Screen/customProfileDrawer.dart';
import 'package:eduma_app/Screen/instructor.page.dart';
import 'package:eduma_app/Screen/login.page.dart';
import 'package:eduma_app/Screen/payCourseDetails.page.dart';
import 'package:eduma_app/Screen/productDetails.page.dart';
import 'package:eduma_app/Screen/register.page.dart';
import 'package:eduma_app/Screen/shop.page.dart';
import 'package:eduma_app/Screen/youtube.page.dart';
import 'package:eduma_app/data/Controller/allCoursesController.dart';
import 'package:eduma_app/data/Controller/popularCourseController.dart';
import 'package:eduma_app/data/Controller/productListController.dart';
import 'package:eduma_app/data/Controller/wishlistControllerClass.dart';
import 'package:eduma_app/data/Model/popularCourseModel.dart';
import 'package:eduma_app/data/Model/productListModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int selectIndex = 0;
  bool isWishlisted = false;
  @override
  Widget build(BuildContext context) {
    var box = Hive.box("userBox");
    final popularCourseProvider = ref.watch(popularCourseController);
    final allCoursesProvider = ref.watch(allCoursesController);
    final productListProvider = ref.watch(productListController);

    // ✅ Agar loading hai to pura Scaffold loading show kare
    if (popularCourseProvider.isLoading || allCoursesProvider.isLoading) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: CircularProgressIndicator(color: Color(0xFF001E6C)),
        ),
      );
    }

    // ✅ Agar error hai to pura Scaffold error show kare
    if (popularCourseProvider.hasError || allCoursesProvider.hasError) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Text(
            popularCourseProvider.error?.toString() ?? "Something went wrong",
            style: GoogleFonts.inter(fontSize: 20.sp, color: Colors.red),
          ),
        ),
      );
    }
    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomProfileDrawer(),
      backgroundColor: Color(0xFFFFFFFF),
      appBar: selectIndex == 0
          ? AppBar(
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
                          CupertinoPageRoute(
                            builder: (context) => RegisterPage(),
                          ),
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
            )
          : null,
      body: selectIndex == 0
          ? SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 18.h),
                  Padding(
                    padding: EdgeInsets.only(left: 20.w, right: 20.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Welcome Back, ${box.get("storeName")}",
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
                        contentPadding: EdgeInsets.only(
                          left: 20.w,
                          right: 20.w,
                        ),
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
                      Image.asset(
                        "assets/book.png",
                        width: 31.w,
                        height: 25.h,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        "Continue Learning",
                        style: GoogleFonts.roboto(
                          fontSize: 23.sp,
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
                        size: 23.sp,
                      ),
                      SizedBox(width: 20.w),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => ContinueMyCoursePage(),
                        ),
                      );
                    },
                    child: LearningBody(),
                  ),
                  // SizedBox(height: 10.h),
                  Row(
                    children: [
                      SizedBox(width: 20.w),
                      Icon(
                        Icons.grid_view_rounded,
                        color: Color(0xFF000000),
                        size: 28.sp,
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        "All Category",
                        style: GoogleFonts.roboto(
                          fontSize: 23.sp,
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
                        size: 23.sp,
                      ),
                      SizedBox(width: 20.w),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  allCoursesProvider.when(
                    data: (allCourses) {
                      return Container(
                        height: 150.h,
                        //color: Colors.amber,
                        child: ListView.builder(
                          itemCount: allCourses.data.length,
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(width: 20.w),
                                Container(
                                  margin: EdgeInsets.only(left: 20.w),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                          builder: (context) =>
                                              CourseDetailsPage(
                                                id: allCourses.data[index].id
                                                    .toString(),
                                              ),
                                        ),
                                      );
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10.r),
                                      child: Image.network(
                                        // "assets/course.png",
                                        allCourses.data[index].thumbnail.large
                                            .toString(),
                                        width: 200.w,
                                        height: 130.h,
                                        fit: BoxFit.fill,
                                        errorBuilder: (context, error, stackTrace) {
                                          return Image.network(
                                            "https://upload.wikimedia.org/wikipedia/commons/6/65/No-Image-Placeholder.svg",
                                            width: 200.w,
                                            height: 130.h,
                                            fit: BoxFit.fill,
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                // SizedBox(width: 20.w),
                                // ClipRRect(
                                //   borderRadius: BorderRadius.circular(10.r),
                                //   child: Image.asset(
                                //     "assets/course.png",
                                //     width: 200.w,
                                //     height: 130.h,
                                //     fit: BoxFit.fill,
                                //   ),
                                // ),
                                // SizedBox(width: 20.w),
                              ],
                            );
                          },
                        ),
                      );
                    },
                    error: (error, stackTrace) =>
                        Center(child: Text(error.toString())),
                    loading: () => Center(child: CircularProgressIndicator()),
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      SizedBox(width: 20.w),
                      Image.asset(
                        "assets/notebook.png",
                        width: 31.w,
                        height: 31.h,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        "Popular Courses",
                        style: GoogleFonts.roboto(
                          fontSize: 23.sp,
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
                        size: 23.sp,
                      ),
                      SizedBox(width: 20.w),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  popularCourseProvider.when(
                    data: (course) {
                      return Container(
                        height: 190.h,
                        //color: Colors.amber,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.zero,
                          itemCount: course.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.only(left: 20.w),
                              child: PopularCour(data: course[index]),
                            );
                          },
                        ),
                      );
                    },
                    error: (error, stackTrace) =>
                        Center(child: Text(error.toString())),
                    loading: () => Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF001E6C),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      SizedBox(width: 16.w),
                      Icon(Icons.star, color: Color(0xFF000000), size: 28.sp),
                      SizedBox(width: 10.w),
                      Text(
                        "Newly Added",
                        style: GoogleFonts.roboto(
                          fontSize: 23.sp,
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
                        size: 23.sp,
                      ),
                      SizedBox(width: 20.w),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  PopularBody(
                    popularList: [
                      {
                        "image": "assets/new1.png",
                        "paid": "₹ 45.00",
                        "title": "Introduction learn Press - LMS Plugin",
                      },
                      {
                        "image": "assets/new2.png",
                        "paid": "Free",
                        "title": "Create an LMS Website With LearnPress",
                      },
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      SizedBox(width: 16.w),
                      Icon(
                        Icons.grid_view_rounded,
                        color: Color(0xFF000000),
                        size: 28.sp,
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        "All Product",
                        style: GoogleFonts.roboto(
                          fontSize: 23.sp,
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
                        size: 23.sp,
                      ),
                      SizedBox(width: 20.w),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  productListProvider.when(
                    data: (productList) {
                      return Container(
                        height: 190.h,
                        // color: Colors.amber,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.zero,
                          itemCount: productList.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(left: 20.w),
                              child: allProduct(data: productList[index]),
                            );
                          },
                        ),
                      );
                    },
                    error: (error, stackTrace) =>
                        Center(child: Text(error.toString())),
                    loading: () => Center(child: CircularProgressIndicator()),
                  ),
                  SizedBox(height: 15.h),
                  Container(
                    margin: EdgeInsets.only(left: 20.w),
                    child: Text(
                      "instructor",
                      style: GoogleFonts.roboto(
                        fontSize: 26.sp,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1B1B1B),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: 20.w),
                      Container(
                        padding: EdgeInsets.only(
                          left: 10.w,
                          right: 10.w,
                          bottom: 13.h,
                          top: 13.h,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.r),
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
                        child: Row(
                          children: [
                            Container(
                              width: 45.w,
                              height: 45.h,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.blue,
                              ),
                              child: ClipOval(
                                child: Image.asset(
                                  "assets/mahesh.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(width: 7.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Mahesh Yogi",
                                  style: GoogleFonts.roboto(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF001E6C),
                                    letterSpacing: -0.4,
                                  ),
                                ),
                                Text(
                                  "3 Courses    257 Student",
                                  style: GoogleFonts.roboto(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF000000),
                                    letterSpacing: -0.4,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Row(
                                  children: [
                                    Image.asset("assets/birds.png"),
                                    SizedBox(width: 10.w),
                                    Image.asset("assets/call.png"),
                                    SizedBox(width: 10.w),
                                    Image.asset("assets/insta.png"),
                                    SizedBox(width: 10.w),
                                    Image.asset("assets/a.png"),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => InstructorPage(),
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                            left: 10.w,
                            right: 10.w,
                            bottom: 13.h,
                            top: 13.h,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.r),
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
                          child: Row(
                            children: [
                              Container(
                                width: 45.w,
                                height: 45.h,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.blue,
                                ),
                                child: ClipOval(
                                  child: Image.asset(
                                    "assets/annu.png",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(width: 7.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Annu Agarwal",
                                    style: GoogleFonts.roboto(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF001E6C),
                                      letterSpacing: -0.4,
                                    ),
                                  ),
                                  Text(
                                    "3 Courses    257 Student",
                                    style: GoogleFonts.roboto(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF000000),
                                      letterSpacing: -0.4,
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  Row(
                                    children: [
                                      Image.asset("assets/birds.png"),
                                      SizedBox(width: 10.w),
                                      Image.asset("assets/call.png"),
                                      SizedBox(width: 10.w),
                                      Image.asset("assets/insta.png"),
                                      SizedBox(width: 10.w),
                                      Image.asset("assets/a.png"),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 20.w),
                    ],
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            )
          : selectIndex == 1
          ? CoursePage()
          : selectIndex == 2
          ? YoutubePage()
          : ShopPage(),

      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.r),
            topRight: Radius.circular(10.r),
          ),
          color: Color(0xFFFFFFFF),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 1),
              spreadRadius: 0,
              blurRadius: 6,
              color: Color.fromARGB(63, 0, 0, 0),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.r),
            topRight: Radius.circular(10.r),
          ),
          child: BottomNavigationBar(
            onTap: (value) {
              if (value == 4) {
                _scaffoldKey.currentState?.openDrawer();
              } else {
                setState(() {
                  selectIndex = value;
                });
              }
            },
            currentIndex: selectIndex,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.transparent, // 🔥 important
            elevation: 0, // 🔥 important

            showSelectedLabels: true,
            showUnselectedLabels: true,

            selectedLabelStyle: GoogleFonts.inter(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: Color(0xFFFE4A55),
            ),
            unselectedLabelStyle: GoogleFonts.inter(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: Color(0xFF001E6C),
            ),

            selectedItemColor: Color(0xFFFE4A55),
            unselectedItemColor: Color(0xFF001E6C),

            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(
                icon: Icon(Icons.menu_book_rounded),
                label: "Library",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.video_library_outlined),
                label: "Youtube",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_bag_outlined),
                label: "Shop",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline_outlined),
                label: "Account",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PopularCour extends StatefulWidget {
  final PopularCourseModel data;
  const PopularCour({required this.data, super.key});

  @override
  State<PopularCour> createState() => _PopularCourState();
}

class _PopularCourState extends State<PopularCour> {
  bool loading = false;
  bool isWishlisted = false;
  @override
  Widget build(BuildContext context) {
    var box = Hive.box("userBox");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) =>
                        PayCourseDetailsPage(id: widget.data.id.toString()),
                  ),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: Image.network(
                  // "assets/learning1.png",
                  widget.data.thumbnail,
                  width: 190.w,
                  height: 125.h,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              right: 8.w,
              top: 10.h,
              // child: IconButton(
              //   style: IconButton.styleFrom(
              //     minimumSize: Size(0, 0),
              //     padding: EdgeInsets.zero,
              //     tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              //   ),
              //   onPressed: loading
              //       ? null
              //       : () async {
              //           setState(() => loading = true);
              //           isWishlisted = await WishlistControllerClass.toggle(
              //             context: context,
              //             courseId: widget.data.id,
              //             userId: box.get("storeId"),
              //             currentStatus: isWishlisted,
              //           );
              //           setState(() => loading = false);
              //         },
              //   icon: loading
              //       ? SizedBox(
              //           height: 20,
              //           width: 20,
              //           child: CircularProgressIndicator(
              //             strokeWidth: 2,
              //             color: Color(0xFF001E6C),
              //           ),
              //         )
              //       : Icon(
              //           isWishlisted ? Icons.favorite : Icons.favorite_border,
              //           color: isWishlisted ? Colors.red : Colors.white,
              //           size: 25.sp,
              //         ),
              // ),
              child: IconButton(
                style: IconButton.styleFrom(
                  minimumSize: Size(0, 0),
                  padding: EdgeInsets.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                onPressed: () async {
                  // 👇 API call se direct result lo
                  final result = await WishlistControllerClass.toggle(
                    context: context,
                    courseId: widget.data.id,
                    userId: box.get("storeId"),
                    currentStatus: isWishlisted,
                  );

                  // 👇 bas yehi update karna hai
                  setState(() {
                    isWishlisted = result;
                  });
                },
                icon: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  transitionBuilder: (child, animation) {
                    return ScaleTransition(
                      scale: CurvedAnimation(
                        parent: animation,
                        curve: Curves.easeInOutBack,
                      ),
                      child: child,
                    );
                  },
                  child: Icon(
                    isWishlisted ? Icons.favorite : Icons.favorite_border,
                    key: ValueKey<bool>(
                      isWishlisted,
                    ), // 👈 ye key change hone se hi animation hoga
                    color: isWishlisted ? Colors.red : Colors.white,
                    size: 25.sp,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 13.w,
              bottom: 8.h,
              child: Container(
                padding: EdgeInsets.only(
                  left: 10.w,
                  right: 10.w,
                  top: 6.h,
                  bottom: 6.h,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.r),
                  color: Color(0xFF001E6C),
                ),
                child: Text(
                  "₹ 45.00",
                  //course[index].p
                  style: GoogleFonts.roboto(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        SizedBox(
          width: 190.w,
          child: Text(
            overflow: TextOverflow.clip,
            //  "Introduction learn Press - LMS Plugin",
            truncateString(widget.data.title, 35),
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
  List myList = [
    {"imageUrl": "assets/learning1.png"},
    {"imageUrl": "assets/learning2.png"},
  ];
  @override
  Widget build(BuildContext context) {
    double percent = (currentStep / totalSteps) * 100;
    return Container(
      height: 265.h,
      // color: Colors.amber,
      child: ListView.builder(
        itemCount: myList.length,
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
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.r),
                      child: Image.asset(
                        //"assets/learning1.png",
                        myList[index]["imageUrl"],
                        width: 295.w,
                        height: 165.h,
                        fit: BoxFit.cover,
                      ),
                    ),
                    // Progress bar
                    Positioned(
                      left: 10.w,
                      right: 10.w,
                      bottom: 20.h,
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
                      letterSpacing: -0.4,
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

class PopularBody extends StatelessWidget {
  final List<Map<String, dynamic>> popularList;
  const PopularBody({super.key, required this.popularList});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 190.h,
      // color: Colors.amber,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.zero,
        itemCount: popularList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(left: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.r),
                      child: Image.asset(
                        // "assets/learning1.png",
                        popularList[index]['image'],
                        width: 190.w,
                        height: 125.h,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      right: 8.w,
                      top: 10.h,
                      child: IconButton(
                        style: IconButton.styleFrom(
                          minimumSize: Size(0, 0),
                          padding: EdgeInsets.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: () {},
                        icon: Icon(Icons.favorite_outline, color: Colors.white),
                      ),
                    ),
                    Positioned(
                      left: 13.w,
                      bottom: 8.h,
                      child: Container(
                        padding: EdgeInsets.only(
                          left: 10.w,
                          right: 10.w,
                          top: 6.h,
                          bottom: 6.h,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.r),
                          color: Color(0xFF001E6C),
                        ),
                        child: Text(
                          // "₹ 45.00",
                          popularList[index]['paid'],
                          style: GoogleFonts.roboto(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                SizedBox(
                  width: 190.w,
                  child: Text(
                    //  "Introduction learn Press - LMS Plugin",
                    popularList[index]['title'],
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

class allProduct extends StatefulWidget {
  final ProductListModel data;
  const allProduct({super.key, required this.data});

  @override
  State<allProduct> createState() => _allProductState();
}

class _allProductState extends State<allProduct> {
  var box = Hive.box("userBox");
  bool isWishlisted = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => ProductDetailsPage(),
                  ),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                // child: Image.network(
                //   // "assets/learning1.png",
                //   productList[index].images[0].medium,
                //   width: 190.w,
                //   height: 125.h,
                //   fit: BoxFit.cover,
                // ),
                child: Image.network(
                  (widget.data.images != null && widget.data.images!.isNotEmpty)
                      ? widget.data.images![0].medium ?? ""
                      : "https://via.placeholder.com/190x125.png?text=No+Image", // fallback image
                  width: 190.w,
                  height: 125.h,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              right: 8.w,
              top: 10.h,
              child: IconButton(
                style: IconButton.styleFrom(
                  minimumSize: Size(0, 0),
                  padding: EdgeInsets.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                onPressed: () async {
                  log(widget.data.id!);
                  // 👇 API call se direct result lo
                  final result = await WishlistControllerClass.toggle(
                    context: context,
                    courseId: widget.data.id!,
                    userId: box.get("storeId"),
                    currentStatus: isWishlisted,
                  );

                  // 👇 bas yehi update karna hai
                  setState(() {
                    isWishlisted = result;
                  });
                },
                icon: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  transitionBuilder: (child, animation) {
                    return ScaleTransition(
                      scale: CurvedAnimation(
                        parent: animation,
                        curve: Curves.easeInOutBack,
                      ),
                      child: child,
                    );
                  },
                  child: Icon(
                    isWishlisted ? Icons.favorite : Icons.favorite_border,
                    key: ValueKey<bool>(
                      isWishlisted,
                    ), // 👈 ye key change hone se hi animation hoga
                    color: isWishlisted ? Colors.red : Colors.white,
                    size: 25.sp,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 13.w,
              bottom: 8.h,
              child: Container(
                padding: EdgeInsets.only(
                  left: 10.w,
                  right: 10.w,
                  top: 6.h,
                  bottom: 6.h,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.r),
                  color: Color(0xFF001E6C),
                ),
                child: Text(
                  //"₹ 45.00",
                  widget.data.price.toString(),
                  style: GoogleFonts.roboto(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        SizedBox(
          width: 190.w,
          child: Text(
            // "Introduction learn Press - LMS Plugin",
            widget.data.name ?? "",
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
    );
  }
}
