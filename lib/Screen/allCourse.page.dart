import 'package:eduma_app/Screen/home.page.dart';
import 'package:eduma_app/data/Controller/popularCourseController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

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
    final popularCourseProvider = ref.watch(popularCourseController);
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Image.asset("assets/shopimage.png"),
          ),
          Positioned(
            top: 30.h,
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
                  child: popularCourseProvider.when(
                    data: (data) {
                      final filterData = data.where((cours) {
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
                                childAspectRatio: 180 / 170,
                              ),
                          itemBuilder: (context, index) {
                            return PopularCour(data: filterData[index]);
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
