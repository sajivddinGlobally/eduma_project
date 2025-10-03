import 'dart:developer';

import 'package:eduma_app/Screen/apiCall/api.register.dart';
import 'package:eduma_app/Screen/productDetails.page.dart';
import 'package:eduma_app/data/Controller/orderListController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';

class OrderListPage extends ConsumerStatefulWidget {
  const OrderListPage({super.key});

  @override
  ConsumerState<OrderListPage> createState() => _OrderListPageState();
}

class _OrderListPageState extends ConsumerState<OrderListPage> {
  @override
  Widget build(BuildContext context) {
    var box = Hive.box("userBox");
    var id = box.get("storeId");
    final orderListProvider = ref.watch(orderListController(id.toString()));
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
          "My Orders",
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
                return Center(
                  child: Column(
                    children: [
                      Text(
                        "No Orders Yet",
                        style: GoogleFonts.roboto(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF001E6C),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        "Looks like you haven't purchased anything yet.\nStart shopping to see your orders here.",
                        style: GoogleFonts.roboto(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey[600],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 24.h),
                    ],
                  ),
                );
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

                    // Expanded(
                    //   child: ListView.builder(
                    //     padding: EdgeInsets.zero,
                    //     itemCount: orderList.length,
                    //     itemBuilder: (context, index) {
                    //       final order = orderList[index];
                    //       if (order.lineItems.isEmpty) {
                    //         return Center(child: Text("No data available"));
                    //       }

                    //       final lineItem = order.lineItems.first;

                    //       return Card(
                    //         margin: EdgeInsets.only(bottom: 12.h),
                    //         color: Colors.white,
                    //         elevation: 2,
                    //         shape: RoundedRectangleBorder(
                    //           borderRadius: BorderRadius.circular(12.r),
                    //         ),
                    //         child: Padding(
                    //           padding: EdgeInsets.all(12.w),
                    //           child: Column(
                    //             crossAxisAlignment: CrossAxisAlignment.start,
                    //             children: [
                    //               Row(
                    //                 mainAxisAlignment:
                    //                     MainAxisAlignment.spaceBetween,
                    //                 children: [
                    //                   Text(
                    //                     "Order ID: #${order.id}",
                    //                     style: GoogleFonts.roboto(
                    //                       fontSize: 15.sp,
                    //                       fontWeight: FontWeight.w500,
                    //                       color: Colors.grey[700],
                    //                     ),
                    //                   ),
                    //                   Text(
                    //                     "Ordered on ${order.dateCreated?.toString().substring(0, 10) ?? ''}",
                    //                     style: GoogleFonts.roboto(
                    //                       fontSize: 14.sp,
                    //                       color: Colors.grey,
                    //                       fontWeight: FontWeight.w500,
                    //                     ),
                    //                   ),
                    //                 ],
                    //               ),
                    //               Divider(),
                    //               Row(
                    //                 crossAxisAlignment:
                    //                     CrossAxisAlignment.start,
                    //                 children: [
                    //                   ClipRRect(
                    //                     borderRadius: BorderRadius.circular(
                    //                       8.r,
                    //                     ),
                    //                     child: Image.network(
                    //                       lineItem.image.src.toString(),
                    //                       width: 80.w,
                    //                       height: 80.h,
                    //                       fit: BoxFit.cover,
                    //                     ),
                    //                   ),
                    //                   SizedBox(width: 12.w),
                    //                   Expanded(
                    //                     child: Column(
                    //                       crossAxisAlignment:
                    //                           CrossAxisAlignment.start,
                    //                       children: [
                    //                         Text(
                    //                           lineItem.name,
                    //                           style: GoogleFonts.roboto(
                    //                             fontSize: 16.sp,
                    //                             fontWeight: FontWeight.w500,
                    //                           ),
                    //                           maxLines: 2,
                    //                           overflow: TextOverflow.ellipsis,
                    //                         ),
                    //                         SizedBox(height: 4.h),
                    //                         Text(
                    //                           "₹${lineItem.total}",
                    //                           style: GoogleFonts.roboto(
                    //                             fontSize: 15.sp,
                    //                             fontWeight: FontWeight.bold,
                    //                             color: Color(0xFF001E6C),
                    //                           ),
                    //                         ),
                    //                         SizedBox(height: 6.h),
                    //                         Text(
                    //                           "Delivered on ${order.dateCreated?.toString().substring(0, 10) ?? ''}",
                    //                           style: GoogleFonts.roboto(
                    //                             fontSize: 14.sp,
                    //                             fontWeight: FontWeight.w500,
                    //                             color: Colors.green,
                    //                           ),
                    //                         ),
                    //                       ],
                    //                     ),
                    //                   ),
                    //                 ],
                    //               ),
                    //               SizedBox(height: 8.h),
                    //               Text(
                    //                 "Delivery Address:",
                    //                 style: GoogleFonts.roboto(
                    //                   fontSize: 16.sp,
                    //                   fontWeight: FontWeight.w600,
                    //                   color: Colors.black,
                    //                 ),
                    //               ),
                    //               Text(
                    //                 "${order.billing.firstName} ${order.billing.lastName}, "
                    //                 "${order.billing.address1}, "
                    //                 "${order.billing.city}, "
                    //                 "${order.billing.postcode}\n"
                    //                 "Phone: ${order.billing.phone}",
                    //                 style: GoogleFonts.roboto(
                    //                   fontSize: 15.sp,
                    //                   color: Colors.black87,
                    //                 ),
                    //               ),
                    //               SizedBox(height: 8.h),
                    //               Row(
                    //                 mainAxisAlignment:
                    //                     MainAxisAlignment.spaceBetween,
                    //                 children: [
                    //                   Text(
                    //                     "Payment: ${order.paymentMethod ?? "COD"}",
                    //                     style: GoogleFonts.roboto(
                    //                       fontSize: 13.sp,
                    //                       color: Colors.grey[800],
                    //                     ),
                    //                   ),
                    //                   Text(
                    //                     "Total: ₹${order.total}",
                    //                     style: GoogleFonts.roboto(
                    //                       fontSize: 14.sp,
                    //                       fontWeight: FontWeight.bold,
                    //                       color: Color(0xFF001E6C),
                    //                     ),
                    //                   ),
                    //                 ],
                    //               ),
                    //               SizedBox(height: 10.h),
                    //               Row(
                    //                 mainAxisAlignment: MainAxisAlignment.end,
                    //                 children: [
                    //                   OutlinedButton(
                    //                     onPressed: () {},
                    //                     child: Text("Track Order"),
                    //                   ),
                    //                   SizedBox(width: 8.w),
                    //                   ElevatedButton(
                    //                     onPressed: () {},
                    //                     child: Text("Buy Again"),
                    //                   ),
                    //                 ],
                    //               ),
                    //             ],
                    //           ),
                    //         ),
                    //       );
                    //     },
                    //   ),
                    // ),
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: orderList.length,
                        itemBuilder: (context, index) {
                          final order = orderList[index];
                          if (order.lineItems.isEmpty) {
                            return Center(child: Text("No data available"));
                          }

                          return Card(
                            margin: EdgeInsets.only(bottom: 12.h),
                            color: Colors.white,
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(12.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // ऑर्डर आईडी और डेट
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Order ID: #${order.id}",
                                        style: GoogleFonts.roboto(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey[700],
                                        ),
                                      ),
                                      Text(
                                        "Ordered on ${order.dateCreated?.toString().substring(0, 10) ?? ''}",
                                        style: GoogleFonts.roboto(
                                          fontSize: 14.sp,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(),

                                  // प्रोडक्ट्स की लिस्ट (एक से ज्यादा प्रोडक्ट्स के लिए)
                                  ...order.lineItems.map<Widget>((lineItem) {
                                    return Padding(
                                      padding: EdgeInsets.only(bottom: 8.h),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              8.r,
                                            ),
                                            child: Image.network(
                                              lineItem.image.src.toString(),
                                              width: 80.w,
                                              height: 80.h,
                                              fit: BoxFit.cover,
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                    return Container(
                                                      width: 80.w,
                                                      height: 80.h,
                                                      color: Colors.grey[300],
                                                      child: Icon(
                                                        Icons
                                                            .image_not_supported,
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
                                                  lineItem.name,
                                                  style: GoogleFonts.roboto(
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                SizedBox(height: 4.h),
                                                Text(
                                                  "₹${lineItem.total}", // प्रत्येक प्रोडक्ट का टोटल
                                                  style: GoogleFonts.roboto(
                                                    fontSize: 15.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xFF001E6C),
                                                  ),
                                                ),
                                                SizedBox(height: 6.h),
                                                Text(
                                                  "Delivered on: ${order.dateCreated?.toString().substring(0, 10) ?? ''}",
                                                  style: GoogleFonts.roboto(
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.green,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),

                                  Divider(),

                                  // डिलीवरी एड्रेस
                                  Text(
                                    "Delivery Address:",
                                    style: GoogleFonts.roboto(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    "${order.billing.firstName} ${order.billing.lastName}, "
                                    "${order.billing.address1}, "
                                    "${order.billing.city}, "
                                    "${order.billing.postcode}\n"
                                    "Phone: ${order.billing.phone}",
                                    style: GoogleFonts.roboto(
                                      fontSize: 15.sp,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  SizedBox(height: 8.h),

                                  // पेमेंट और टोटल
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Payment: ${order.paymentMethod ?? "COD"}",
                                        style: GoogleFonts.roboto(
                                          fontSize: 13.sp,
                                          color: Colors.grey[800],
                                        ),
                                      ),
                                      Text(
                                        "Total: ₹${order.total}", // पूरा ऑर्डर का टोटल
                                        style: GoogleFonts.roboto(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF001E6C),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10.h),

                                  // बटन्स
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      OutlinedButton(
                                        onPressed: () {},
                                        child: Text("Track Order"),
                                      ),
                                      SizedBox(width: 8.w),
                                      ElevatedButton(
                                        onPressed: () {},
                                        child: Text("Buy Again"),
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
    );
  }
}
