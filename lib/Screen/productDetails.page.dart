import 'dart:developer';

import 'package:eduma_app/Screen/cart.page.dart';
import 'package:eduma_app/config/core/showFlushbar.dart';
import 'package:eduma_app/config/network/api.state.dart';
import 'package:eduma_app/config/utils/pretty.dio.dart';
import 'package:eduma_app/data/Controller/productDetailsController.dart';
import 'package:eduma_app/data/Model/addCartBodyModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductDetailsPage extends ConsumerStatefulWidget {
  final String id;
  const ProductDetailsPage({super.key, required this.id});

  @override
  ConsumerState<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends ConsumerState<ProductDetailsPage> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final productDetaisProvider = ref.watch(
      productDetailsController(widget.id),
    );
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
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
          productDetaisProvider.when(
            data: (data) {
              return Padding(
                padding: EdgeInsets.only(left: 20.w, right: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 33.h),
                    Row(
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
                        Text(
                          "Product Details",
                          style: GoogleFonts.roboto(
                            fontSize: 26.sp,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1B1B1B),
                            letterSpacing: -0.4,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30.h),
                    // ClipRRect(
                    //   borderRadius: BorderRadius.circular(10.r),
                    //   child: Image.network(
                    //     data.images.isNotEmpty
                    //         ? data.images[0].thumbnail.toString()
                    //         : "https://upload.wikimedia.org/wikipedia/commons/6/65/No-Image-Placeholder.svg",
                    //     // "assets/shop1.png",
                    //     width: MediaQuery.of(context).size.width,
                    //     height: 198.h,
                    //     fit: BoxFit.cover,
                    //     errorBuilder: (context, error, stackTrace) {
                    //       return Image.network(
                    //         "https://upload.wikimedia.org/wikipedia/commons/6/65/No-Image-Placeholder.svg",
                    //         width: MediaQuery.of(context).size.width,
                    //         height: 69.h,
                    //         fit: BoxFit.cover,
                    //       );
                    //     },
                    //   ),
                    // ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.r),
                      child: Image.network(
                        data.images.isNotEmpty
                            ? data.images[0].thumbnail.toString()
                            : "https://via.placeholder.com/300x200.png?text=No+Image",
                        width: MediaQuery.of(context).size.width,
                        height: 198.h,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.network(
                            "https://via.placeholder.com/300x200.png?text=No+Image",
                            width: MediaQuery.of(context).size.width,
                            height: 198.h,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),

                    SizedBox(height: 10.h),
                    Row(
                      children: [
                        Text(
                          //  "Create an LMS Website With LearnPress",
                          data.name.toString(),
                          style: GoogleFonts.roboto(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF000000),
                            letterSpacing: -0.4,
                          ),
                        ),
                        Spacer(),
                        Container(
                          // padding: EdgeInsets.only(
                          //   left: 8.w,
                          //   right: 8.w,
                          //   top: 6.h,
                          //   bottom: 6.h,
                          // ),
                          width: 80.w,
                          height: 36.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            color: Color(0xFF001E6C),
                          ),
                          child: TextButton(
                            style: IconButton.styleFrom(
                              minimumSize: Size(0, 0),
                              padding: EdgeInsets.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            onPressed: () async {
                              final body = ProductAddCartBodyModel(
                                productId: data.id,
                                quantity: 1,
                              );

                              setState(() {
                                isLoading = true;
                              });

                              try {
                                final service = APIStateNetwork(createDio());
                                final response = await service.addToCart(body);

                                if (response.success == true) {
                                  setState(() {
                                    isLoading = false;
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
                                              response.message,
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.roboto(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black54,
                                              ),
                                            ),
                                            SizedBox(height: 12),
                                            Icon(
                                              Icons.shopping_cart,
                                              color: Color(0xFF001E6C),
                                              size: 40,
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
                                              foregroundColor: Colors.redAccent,
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
                                              Navigator.push(
                                                context,
                                                CupertinoPageRoute(
                                                  builder: (context) =>
                                                      CartPage(),
                                                ),
                                              );
                                            },
                                            child: Text(
                                              "Go to Cart",
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
                                } else {
                                  setState(() {
                                    isLoading = false;
                                  });
                                }
                              } catch (e) {
                                setState(() {
                                  isLoading = false;
                                });
                                log(e.toString());
                              }
                            },
                            child: isLoading
                                ? SizedBox(
                                    width: 20.w,
                                    height: 20.h,
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                : Text(
                                    "Add to Cart",
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
                    Text(
                      "Product description",
                      style: GoogleFonts.roboto(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF000000),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      // "The 25th Workshop based on Treasure of Treatise -18 is a deep dive into the ancient scriptures and texts, uncovering hidden gems of knowledge and wisdom. Participants will explore the rich heritage of ancient treatises and unlock valuable insights for personal growth and development.",
                      data.description.toString(),
                      style: GoogleFonts.roboto(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF000000),
                        letterSpacing: -1,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      children: [
                        Text(
                          "₹ 45k",

                          style: GoogleFonts.roboto(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF001E6C),
                          ),
                        ),
                        SizedBox(width: 10.h),
                        Text(
                          "24% off",
                          style: GoogleFonts.roboto(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF1BB93D),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 13.h),
                    Row(
                      children: [
                        Text(
                          "₹ 50k",
                          style: GoogleFonts.roboto(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF001E6C),
                            decoration: TextDecoration.lineThrough,
                            decorationThickness: 2,
                          ),
                        ),
                        SizedBox(width: 10.h),
                        Text(
                          "MRP",
                          style: GoogleFonts.roboto(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF000000),
                          ),
                        ),
                        SizedBox(width: 10.h),
                        Text(
                          "(incl. off all texes)",
                          style: GoogleFonts.roboto(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFFA49F9F),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30.h),
                    SizedBox(height: 10.h),
                    Text(
                      "shipping policy",
                      style: GoogleFonts.roboto(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF000000),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      // "shipping_policy",
                      data.wcfmProductPolicyData.shippingPolicy.toString(),
                      style: GoogleFonts.roboto(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF000000),
                      ),
                    ),
                  ],
                ),
              );
            },
            error: (error, stackTrace) => Center(child: Text(error.toString())),
            loading: () => Center(child: CircularProgressIndicator()),
          ),
        ],
      ),
    );
  }
}
