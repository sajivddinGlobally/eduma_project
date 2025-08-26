import 'dart:math';
import 'package:eduma_app/data/Controller/cartController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class CartPage extends ConsumerStatefulWidget {
  const CartPage({super.key});

  @override
  ConsumerState<CartPage> createState() => _CartPageState();
}

class _CartPageState extends ConsumerState<CartPage> {
  @override
  Widget build(BuildContext context) {
    final cartProvider = ref.watch(cartController);
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Stack(
        children: [
          Positioned(
            left: -110,
            top: -120.h,
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
          cartProvider.when(
            data: (data) {
              return Padding(
                padding: EdgeInsets.only(left: 20.w, right: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 33.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
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
                        Center(
                          child: Text(
                            "Your Cart",
                            style: GoogleFonts.roboto(
                              fontSize: 26.sp,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1B1B1B),
                              letterSpacing: -0.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      "Review Your Order",
                      style: GoogleFonts.roboto(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF001E6C),
                        letterSpacing: -0.4,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: data.items.length,
                        itemBuilder: (context, index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 15.h),
                                padding: EdgeInsets.only(
                                  left: 10.w,
                                  top: 10.h,
                                  bottom: 10.h,
                                  right: 10.w,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.r),
                                  color: const Color.fromARGB(
                                    255,
                                    232,
                                    228,
                                    228,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10.r),
                                      child: Image.network(
                                        data.items[index].thumbnail,
                                        //"assets/shop1.png",
                                        width: 100.w,
                                        height: 100.h,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(width: 10.w),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 265.w,
                                          child: Text(
                                            //"Product Name",
                                            data.items[index].name,
                                            style: GoogleFonts.roboto(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xFF000000),
                                              letterSpacing: -0.4,
                                              height: 1,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 5.w),
                                        Text(
                                          "Price ${data.items[index].price.toString()}",
                                          style: GoogleFonts.roboto(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFF001E6C),
                                            letterSpacing: -0.4,
                                          ),
                                        ),
                                        SizedBox(height: 5.w),
                                        Container(
                                          width: 270.w,
                                          // color: Colors.amber,
                                          child: Row(
                                            children: [
                                              Text(
                                                "Quantity ${data.items[index].quantity.toString()}",
                                                style: GoogleFonts.roboto(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(0xFF747474),
                                                ),
                                              ),
                                              Spacer(),
                                              Container(
                                                width: 160.w,
                                                height: 50.h,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        10.r,
                                                      ),
                                                  border: Border.all(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "-",
                                                      style: GoogleFonts.roboto(
                                                        fontSize: 30.sp,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
            error: (error, stackTrace) => Center(child: Text(e.toString())),
            //loading: () => Center(child: CircularProgressIndicator()),
            loading: () => ListView.builder(
              padding: EdgeInsets.all(20.w),
              itemCount: 4,
              itemBuilder: (context, index) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 15.h),
                    padding: EdgeInsets.all(10.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 100.w,
                          height: 100.h,
                          color: Colors.grey[400],
                        ),
                        SizedBox(width: 10.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 200.w,
                              height: 16.h,
                              color: Colors.grey[400],
                            ),
                            SizedBox(height: 10.h),
                            Container(
                              width: 120.w,
                              height: 14.h,
                              color: Colors.grey[400],
                            ),
                            SizedBox(height: 10.h),
                            Container(
                              width: 80.w,
                              height: 14.h,
                              color: Colors.grey[400],
                            ),
                          ],
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
  }
}
