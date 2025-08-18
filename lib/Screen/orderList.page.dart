import 'package:eduma_app/Screen/orderDetails.page.dart';
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

          orderListProvider.when(
            data: (orderList) {
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
                            "Order List",
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
                    SizedBox(height: 40.h),
                    Text(
                      "Products",
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
                        itemCount: orderList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(top: 16.h),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => OrderDetailsPage(
                                      id: orderList[index].id.toString(),
                                    ),
                                  ),
                                );
                              },
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10.r),
                                    child: Image.asset(
                                      "assets/shop1.png",
                                      // orderList[index]
                                      //     .lineItems[index]
                                      //     .image
                                      //     .src
                                      //     .toString(),
                                      width: 84.w,
                                      height: 69.h,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) {
                                        return Image.network(
                                          "https://upload.wikimedia.org/wikipedia/commons/6/65/No-Image-Placeholder.svg",
                                          width: 84.w,
                                          height: 69.h,
                                          fit: BoxFit.cover,
                                        );
                                      },
                                    ),
                                  ),

                                  SizedBox(width: 10.w),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 190.w,
                                        child: Text(
                                          // "Create an LMS Website With LearnPress",
                                          orderList[index]
                                              .lineItems[index]
                                              .name,

                                          style: GoogleFonts.roboto(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFF000000),
                                            letterSpacing: -0.4,
                                            height: 1,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        // "₹ 45k",
                                        orderList[index].lineItems[index].total,
                                        style: GoogleFonts.roboto(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xFF001E6C),
                                          letterSpacing: -0.4,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.add_shopping_cart,
                                    color: Color(0xFF001E6C),
                                    size: 25.sp,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(400.w, 58.h),
                        backgroundColor: Color(0xFF001E6C),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      onPressed: () {},
                      child: Text(
                        "Add Entire List to Cart",
                        style: GoogleFonts.roboto(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFFFFFFFF),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                  ],
                ),
              );
            },
            error: (error, stackTrace) {
              return Center(child: Text(error.toString()));
            },
            loading: () => Center(child: CircularProgressIndicator()),
          ),
        ],
      ),
    );
  }
}
