import 'package:eduma_app/Screen/course.page.dart';
import 'package:eduma_app/data/Controller/allCategoryController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AllCategoryPage extends ConsumerStatefulWidget {
  const AllCategoryPage({super.key});

  @override
  ConsumerState<AllCategoryPage> createState() => _AllProductScreenState();
}

class _AllProductScreenState extends ConsumerState<AllCategoryPage> {
  @override
  Widget build(BuildContext context) {
    final allCategoryProvider = ref.watch(allCategoryController);
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
                  "All Category",
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
                Expanded(
                  child: allCategoryProvider.when(
                    data: (allCategory) {
                      return Padding(
                        padding: EdgeInsets.only(
                          left: 20.w,
                          right: 20.w,
                          top: 20.h,
                        ),
                        child: GridView.builder(
                          itemCount: allCategory.data.length,
                          padding: EdgeInsets.zero,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 20.w,
                                mainAxisSpacing: 15.h,
                                childAspectRatio: 180 / 190,
                              ),
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(width: 20.w),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                            builder: (context) => CoursePage(
                                              categoryId: allCategory
                                                  .data[index]
                                                  .id
                                                  .toString(),
                                            ),
                                          ),
                                        );
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                          10.r,
                                        ),
                                        child: Image.network(
                                          // "assets/course.png",
                                          allCategory.data[index].thumbnail,
                                          width: 200.w,
                                          height: 130.h,
                                          fit: BoxFit.fill,
                                          errorBuilder:
                                              (context, error, stackTrace) {
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
                                    Container(
                                      margin: EdgeInsets.only(top: 10.h),
                                      width: 200.w,
                                      child: Text(
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        allCategory.data[index].name,
                                        style: GoogleFonts.roboto(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xFF000000),
                                          letterSpacing: -0.4,
                                          height: 1.2,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 6.h),
                                    Text(
                                      "Total Course ${allCategory.data[index].count.toString()}",
                                      style: GoogleFonts.roboto(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF000000),
                                      ),
                                    ),
                                  ],
                                ),
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
