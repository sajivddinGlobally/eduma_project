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
  final searchController = TextEditingController();
  String searchQuery = "";
  @override
  Widget build(BuildContext context) {
    final enrolleCourseProvider = ref.watch(enrollCourseController);
    return Scaffold(
      backgroundColor: Color(0xFFF5F7FA),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFE8F0FE), Color(0xFFF5F7FA)],
              ),
            ),
          ),

          enrolleCourseProvider.when(
            data: (data) {
              final filter = data.courses.where((search) {
                final title = search.title?.toLowerCase() ?? "";
                return title.contains(searchQuery);
              }).toList();

              if (data.courses.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.book_outlined,
                        size: 80.sp,
                        color: Color(0xFF747474),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        "No Enrolled Courses",
                        style: GoogleFonts.poppins(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF747474),
                        ),
                      ),
                    ],
                  ),
                );
              }

              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h),
                    Text(
                      "My Library",
                      style: GoogleFonts.poppins(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF001E6C),
                      ),
                    ),
                    SizedBox(height: 15.h),
                    TextField(
                      controller: searchController,
                      onChanged: (value) {
                        setState(() {
                          searchQuery = value.toLowerCase();
                        });
                      },
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
                          "Searching...",
                          style: GoogleFonts.roboto(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF777474),
                            letterSpacing: -0.2,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Expanded(
                      child: filter.isEmpty
                          ? Text(
                              "No Course found",
                              style: GoogleFonts.poppins(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF747474),
                              ),
                            )
                          : ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: filter.length,
                              itemBuilder: (context, index) {
                                final filterData = filter[index];
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                        builder: (context) =>
                                            EnrolledDourseDetailsPage(
                                              id: filterData.id.toString(),
                                            ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(bottom: 16.h),
                                    padding: EdgeInsets.all(12.w),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16.r),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 6,
                                          offset: Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            12.r,
                                          ),
                                          child: Image.network(
                                            filterData.thumbnail,
                                            width: 120.w,
                                            height: 80.h,
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                                  return Container(
                                                    width: 120.w,
                                                    height: 80.h,
                                                    color: Colors.grey[200],
                                                    child: Icon(
                                                      Icons.image_not_supported,
                                                      color: Colors.grey[600],
                                                      size: 40.sp,
                                                    ),
                                                  );
                                                },
                                          ),
                                        ),
                                        SizedBox(width: 12.w),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                filterData.title,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.poppins(
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(0xFF001E6C),
                                                ),
                                              ),
                                              SizedBox(height: 6.h),
                                              Text(
                                                filterData.instructor.name,
                                                style: GoogleFonts.poppins(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color(0xFF747474),
                                                ),
                                              ),
                                              SizedBox(height: 8.h),
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 8.w,
                                                  vertical: 4.h,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: Color(
                                                    0xFF001E6C,
                                                  ).withOpacity(0.1),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        8.r,
                                                      ),
                                                ),
                                                child: Text(
                                                  "Enrolled",
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0xFF001E6C),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                  ],
                ),
              );
            },
            error: (error, stackTrace) => Center(
              child: Text(
                error.toString(),
                style: GoogleFonts.poppins(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.red,
                ),
              ),
            ),
            loading: () => Center(
              child: CircularProgressIndicator(color: Color(0xFF001E6C)),
            ),
          ),
        ],
      ),
    );
  }
}
