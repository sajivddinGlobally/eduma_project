import 'dart:developer';

import 'package:eduma_app/Screen/apiCall/api.register.dart';
import 'package:eduma_app/Screen/productDetails.page.dart';
import 'package:eduma_app/data/Controller/orderListController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderListPage extends ConsumerStatefulWidget {
  const OrderListPage({super.key});

  @override
  ConsumerState<OrderListPage> createState() => _OrderListPageState();
}

class _OrderListPageState extends ConsumerState<OrderListPage> {
  @override
  Widget build(BuildContext context) {
    final orderListProvider = ref.watch(orderListController);
    return Scaffold(
      backgroundColor: Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF001E6C), size: 24.sp),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Order History",
          style: GoogleFonts.roboto(
            fontSize: 22.sp,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1B1B1B),
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Background decoration
          Positioned(
            left: -100.w,
            top: -100.h,
            child: Opacity(
              opacity: 0.1,
              child: Image.asset(
                "assets/vect.png",
                width: 300.w,
                height: 250.h,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Positioned(
            bottom: -50.h,
            right: -50.w,
            child: Opacity(
              opacity: 0.1,
              child: Image.asset(
                "assets/vec.png",
                width: 300.w,
                height: 300.h,
                fit: BoxFit.contain,
              ),
            ),
          ),
          // Main content
          orderListProvider.when(
            data: (orderList) {
              if (orderList.isEmpty) {
                return Center(child: Text("No History Available"));
              }
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Your Products",
                      style: GoogleFonts.roboto(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF001E6C),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: orderList.length,
                        itemBuilder: (context, index) {
                          final order = orderList[index];
                          return Card(
                            margin: EdgeInsets.only(bottom: 12.h),
                            color: Colors.white,
                            elevation: 2,

                            child: InkWell(
                              borderRadius: BorderRadius.circular(12.r),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => ProductDetailsPage(
                                      id: orderList[index].parentId.toString(),
                                    ),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: EdgeInsets.all(12.w),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8.r),
                                      child: Image.network(
                                        order.lineItems[0].image.src.toString(),
                                        width: 80.w,
                                        height: 80.h,
                                        //fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) {
                                          return Image.network(
                                            "https://t4.ftcdn.net/jpg/05/97/47/95/360_F_597479556_7bbQ7t4Z8k3xbAloHFHVdZIizWK1PdOo.jpg",
                                            width: 80.w,
                                            height: 80.h,
                                            fit: BoxFit.fill,
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
                                            order.lineItems.first.name,
                                            style: GoogleFonts.roboto(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xFF1B1B1B),
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(height: 4.h),
                                          Text(
                                            order.lineItems.first.total,
                                            style: GoogleFonts.roboto(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xFF001E6C),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Icon(
                                      Icons.add_shopping_cart,
                                      color: Color(0xFF001E6C),
                                      size: 24.sp,
                                    ),
                                  ],
                                ),
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
            error: (error, stackTrace) {
              log(stackTrace.toString());
              return Center(
                child: Text(
                  "Error: $error",
                  style: GoogleFonts.roboto(
                    fontSize: 16.sp,
                    color: Colors.redAccent,
                  ),
                ),
              );
            },
            loading: () => Center(child: ShimmerHomePage()),
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () {
      //     // Implement add entire list to cart functionality
      //   },
      //   backgroundColor: Color(0xFF001E6C),
      //   label: Text(
      //     "Add All to Cart",
      //     style: GoogleFonts.roboto(
      //       fontSize: 16.sp,
      //       fontWeight: FontWeight.w500,
      //       color: Colors.white,
      //     ),
      //   ),
      //   icon: Icon(Icons.add_shopping_cart, color: Colors.white),
      // ),
    );
  }
}
