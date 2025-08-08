import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  List<Map<String, dynamic>> shopList = [
    {
      "image": "assets/reading2.png",
      "paid": "₹ 45.00",
      "name": "Introduction learn Press - LMS Plugin",
    },
    {
      "image": "assets/shop1.png",
      "paid": "Free",
      "name": "Create an LMS Website With LearnPress",
    },
    {
      "image": "assets/reading2.png",
      "paid": "₹ 45.00",
      "name": "Introduction learn Press - LMS Plugin",
    },
    {
      "image": "assets/shop1.png",
      "paid": "Free",
      "name": "Create an LMS Website With LearnPress",
    },
    {
      "image": "assets/reading2.png",
      "paid": "₹ 45.00",
      "name": "Introduction learn Press - LMS Plugin",
    },
    {
      "image": "assets/shop1.png",
      "paid": "Free",
      "name": "Create an LMS Website With LearnPress",
    },
    {
      "image": "assets/reading2.png",
      "paid": "₹ 45.00",
      "name": "Introduction learn Press - LMS Plugin",
    },
    {
      "image": "assets/shop1.png",
      "paid": "Free",
      "name": "Create an LMS Website With LearnPress",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Image.asset("assets/shopimage.png"),
          ),
          Positioned(
            top: 45.h,
            child: Row(
              children: [
                SizedBox(width: 20.w),
                Image.asset("assets/eduimage.png"),
                SizedBox(width: 10.w),
                Text(
                  "EDUCATION",
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
            right: 20.w,
            top: 64.h,
            child: Icon(
              Icons.notifications_none_outlined,
              color: Color(0xFF000000),
              size: 30.sp,
            ),
          ),
          Positioned(
            top: 85.h,
            left: 0,
            right: 0,
            bottom: 0,
            child: Column(
              children: [
                Text(
                  "Shop",
                  style: GoogleFonts.inter(
                    fontSize: 26.sp,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF001E6C),
                    letterSpacing: -1,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 20.w,
                      right: 20.w,
                      top: 20.h,
                    ),
                    child: GridView.builder(
                      itemCount: shopList.length,
                      padding: EdgeInsets.zero,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 20.w,
                        mainAxisSpacing: 15.h,
                        childAspectRatio: 190 / 171,
                      ),
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10.r),
                                  child: Image.asset(
                                    // "assets/reading2.png",
                                    shopList[index]['image'].toString(),
                                    width: 190.w,
                                    height: 125.h,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Container(
                                    margin: EdgeInsets.only(
                                      top: 8.h,
                                      right: 13.w,
                                    ),
                                    child: IconButton(
                                      style: IconButton.styleFrom(
                                        minimumSize: Size(0, 0),
                                        padding: EdgeInsets.zero,
                                        tapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                      ),
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.favorite_border,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 8.h,
                                  left: 13.w,
                                  child: Container(
                                    width: 57.w,
                                    height: 27.h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.r),
                                      color: Color(0xFF001E6C),
                                    ),
                                    child: Center(
                                      child: Text(
                                        //"₹ 45.00",
                                        shopList[index]['paid'].toString(),
                                        style: GoogleFonts.roboto(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              //  "Introduction learn Press - LMS Plugin",
                              shopList[index]['name'].toString(),
                              style: GoogleFonts.roboto(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF000000),
                                letterSpacing: -0.4,
                                height: 1,
                              ),
                            ),
                          ],
                        );
                      },
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
