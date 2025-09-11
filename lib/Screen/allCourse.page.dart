import 'package:eduma_app/Screen/home.page.dart';
import 'package:eduma_app/Screen/login.page.dart';
import 'package:eduma_app/Screen/payCourseDetails.page.dart';
import 'package:eduma_app/config/core/showFlushbar.dart';
import 'package:eduma_app/data/Controller/allCoursesController.dart';
import 'package:eduma_app/data/Controller/popularCourseController.dart';
import 'package:eduma_app/data/Controller/wishlistControllerClass.dart';
import 'package:eduma_app/data/Model/allCoursesModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

class AllCoursePage extends ConsumerStatefulWidget {
  const AllCoursePage({super.key});

  @override
  ConsumerState<AllCoursePage> createState() => _AllCoursePageState();
}

class _AllCoursePageState extends ConsumerState<AllCoursePage> {
  final TextEditingController _searchController = TextEditingController();
  String searchQuery = "";
  @override
  Widget build(BuildContext context) {
    // final popularCourseProvider = ref.watch(popularCourseController);
    final allcourseProvider = ref.watch(allCoursesController);
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Image.asset("assets/shopimage.png"),
          ),
          Positioned(
            top: 15.h,
            child: Row(
              children: [
                SizedBox(width: 20.w),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios, color: Color(0xFF001E6C)),
                ),
                SizedBox(width: 10.w),
                Text(
                  "Search Course",
                  style: GoogleFonts.inter(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF001E6C),
                    letterSpacing: -1,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 85.h,
            left: 0,
            right: 0,
            bottom: 0,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 20.w, right: 20.w),
                  child: TextField(
                    controller: _searchController,
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value.toLowerCase();
                      });
                    },
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
                Expanded(
                  child: allcourseProvider.when(
                    data: (data) {
                      final filterData = data.data.where((cours) {
                        final title = cours.title.toLowerCase();
                        return title.contains(searchQuery);
                      }).toList();

                      if (filterData.isEmpty) {
                        return Center(child: Text("No Course Available"));
                      }
                      return Padding(
                        padding: EdgeInsets.only(
                          left: 20.w,
                          right: 20.w,
                          top: 20.h,
                        ),
                        child: GridView.builder(
                          itemCount: filterData.length,
                          padding: EdgeInsets.zero,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 20.w,
                                mainAxisSpacing: 15.h,
                                childAspectRatio: 180 / 180,
                              ),
                          itemBuilder: (context, index) {
                            return AllBody(data: filterData[index]);
                          },
                        ),
                      );
                    },
                    error: (error, stackTrace) =>
                        Center(child: Text(error.toString())),
                    loading: () => Center(child: CircularProgressIndicator()),
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

class AllBody extends StatefulWidget {
  final Datum data;
  const AllBody({super.key, required this.data});

  @override
  State<AllBody> createState() => _AllBodyState();
}

class _AllBodyState extends State<AllBody> {
  bool loading = false;
  bool isWishlisted = false;
  @override
  Widget build(BuildContext context) {
    var box = Hive.box("userBox");
    var token = box.get("token");
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
                  widget.data.thumbnail.medium,
                  width: 190.w,
                  height: 125.h,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.network(
                      "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/832px-No-Image-Placeholder.png",
                      width: 190.w,
                      height: 125.h,
                      fit: BoxFit.fill,
                    );
                  },
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
                  if (token == null) {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(builder: (context) => LoginPage()),
                    );
                    showSuccessMessage(context, "Please Login First");
                    return;
                  }
                  final result = await WishlistControllerClass.toggle(
                    context: context,
                    courseId: widget.data.id,
                    userId: box.get("storeId"),
                    currentStatus: isWishlisted,
                  );
                  setState(() {
                    isWishlisted = result;
                  });
                },
                icon: AnimatedSwitcher(
                  //duration: const Duration(milliseconds: 500),
                  duration: Durations.short1,
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
                  widget.data.pricing.priceLabel.name,
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
        SizedBox(height: 10.h),
        Text(
          //"₹ 45.00",
          //shopList[index]['paid'].toString(),
          "₹ ${widget.data.pricing.salePrice ?? "No price"}",
          style: GoogleFonts.roboto(
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
            color: Color(0xFF001E6C),
          ),
        ),
      ],
    );
  }
}
