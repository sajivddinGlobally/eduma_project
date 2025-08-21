import 'package:eduma_app/Screen/productDetails.page.dart';
import 'package:eduma_app/data/Controller/productListController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ShopPage extends ConsumerStatefulWidget {
  const ShopPage({super.key});

  @override
  ConsumerState<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends ConsumerState<ShopPage> {
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
    final productListProvider = ref.watch(productListController);
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
                productListProvider.when(
                  data: (snap) {
                    return Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 20.w,
                          right: 20.w,
                          top: 20.h,
                        ),
                        child: GridView.builder(
                          itemCount: snap.length,
                          padding: EdgeInsets.zero,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 20.w,
                                mainAxisSpacing: 15.h,
                                childAspectRatio: 190 / 180,
                              ),
                          itemBuilder: (context, index) {
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
                                                ProductDetailsPage(
                                                  id: snap[index].id.toString(),
                                                ),
                                          ),
                                        );
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                          10.r,
                                        ),
                                        child: Image.network(
                                          // "assets/reading2.png",
                                          //shopList[index]['image'].toString(),
                                          snap[index].images![0].medium
                                              .toString(),
                                          width: 190.w,
                                          height: 125.h,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    // Align(
                                    //   alignment: Alignment.topRight,
                                    //   child: Container(
                                    //     margin: EdgeInsets.only(
                                    //       top: 8.h,
                                    //       right: 13.w,
                                    //     ),
                                    //     child: IconButton(
                                    //       style: IconButton.styleFrom(
                                    //         minimumSize: Size(0, 0),
                                    //         padding: EdgeInsets.zero,
                                    //         tapTargetSize: MaterialTapTargetSize
                                    //             .shrinkWrap,
                                    //       ),
                                    //       onPressed: () {},
                                    //       icon: Icon(
                                    //         Icons.favorite_border,
                                    //         color: Colors.white,
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
                                    // Positioned(
                                    //   bottom: 8.h,
                                    //   left: 13.w,
                                    //   child: Container(
                                    //     width: 57.w,
                                    //     height: 27.h,
                                    //     decoration: BoxDecoration(
                                    //       borderRadius: BorderRadius.circular(
                                    //         5.r,
                                    //       ),
                                    //       color: Color(0xFF001E6C),
                                    //     ),
                                    //     child: Center(
                                    //       child: Text(
                                    //         //"₹ 45.00",
                                    //         //shopList[index]['paid'].toString(),
                                    //         snap[index].price.toString(),
                                    //         style: GoogleFonts.roboto(
                                    //           fontSize: 12.sp,
                                    //           fontWeight: FontWeight.w500,
                                    //           color: Colors.white,
                                    //         ),
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
                                  ],
                                ),
                                SizedBox(height: 10.h),
                                Text(
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  //  "Introduction learn Press - LMS Plugin",
                                  // shopList[index]['name'].toString(),
                                  snap[index].name.toString(),
                                  style: GoogleFonts.roboto(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF000000),
                                    letterSpacing: -0.4,
                                    height: 1,
                                  ),
                                ),
                                SizedBox(height: 6.h),
                                Text(
                                  //"₹ 45.00",
                                  //shopList[index]['paid'].toString(),
                                  snap[index].price.toString(),
                                  style: GoogleFonts.roboto(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF001E6C),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    );
                  },
                  error: (error, stackTrace) =>
                      Center(child: Text(error.toString())),
                  loading: () => Center(child: CircularProgressIndicator()),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
