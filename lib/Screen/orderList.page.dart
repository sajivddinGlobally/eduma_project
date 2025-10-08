import 'dart:developer';
import 'package:eduma_app/Screen/apiCall/api.register.dart';
import 'package:eduma_app/Screen/home.page.dart';
import 'package:eduma_app/config/core/showFlushbar.dart';
import 'package:eduma_app/data/Controller/orderListController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class OrderListPage extends ConsumerStatefulWidget {
  const OrderListPage({super.key});

  @override
  ConsumerState<OrderListPage> createState() => _OrderListPageState();
}

class _OrderListPageState extends ConsumerState<OrderListPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var box = Hive.box("userBox");
      var id = box.get("storeId");
      ref.invalidate(orderListController(id.toString()));
    });
  }

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
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: Color(0xFF001E6C),
          ),
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await ref.refresh(orderListController(id.toString()).future);
        },
        child: Stack(
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
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 8.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                                    ...order.lineItems.map<Widget>((lineItem) {
                                      return Padding(
                                        padding: EdgeInsets.only(bottom: 8.h),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8.r),
                                              child: Image.network(
                                                lineItem.image.src.toString(),
                                                width: 80.w,
                                                height: 80.h,
                                                fit: BoxFit.cover,
                                                errorBuilder:
                                                    (
                                                      context,
                                                      error,
                                                      stackTrace,
                                                    ) {
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
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  SizedBox(height: 4.h),
                                                  Text(
                                                    "₹${lineItem.total}",
                                                    style: GoogleFonts.roboto(
                                                      fontSize: 15.sp,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color(0xFF001E6C),
                                                    ),
                                                  ),
                                                  SizedBox(height: 6.h),
                                                  Text(
                                                    "Delivered on: ${order.dateCompleted?.toString().substring(0, 10) ?? ''}",
                                                    style: GoogleFonts.roboto(
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
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
                                    Row(
                                      children: [
                                        Text(
                                          "Status :",
                                          style: GoogleFonts.roboto(
                                            fontSize: 15.sp,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        SizedBox(width: 4.w),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 12.w,
                                            vertical: 6.h,
                                          ),
                                          decoration: BoxDecoration(
                                            color: order.status == 'processing'
                                                ? Colors.orange
                                                : (order.status == 'completed'
                                                      ? Colors.green
                                                      : Colors.red),
                                            borderRadius: BorderRadius.circular(
                                              20.r,
                                            ),
                                          ),
                                          child: Text(
                                            order.status,
                                            style: GoogleFonts.roboto(
                                              color: Colors.white,
                                              fontSize: 12.sp,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 4.h),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Total: ₹${order.total}",
                                          style: GoogleFonts.roboto(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF001E6C),
                                          ),
                                        ),
                                        if (order.status == "pending" ||
                                            order.status == "failed")
                                          OutlinedButton(
                                            style: OutlinedButton.styleFrom(
                                              padding: EdgeInsets.zero,
                                              minimumSize: Size(80.w, 40.h),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.r),
                                              ),
                                            ),
                                            onPressed: () {
                                              log("Order #${order.id}");
                                              final razorpay = Razorpay();
                                              final options = {
                                                "order_id":
                                                    order.metaData[0].value,
                                                // "key":
                                                //     "rzp_test_RIeIwZBZ2NZi6w",
                                                "key":
                                                    "rzp_live_RQVbHR68ibVPuJ",
                                                "amount":
                                                    (double.tryParse(
                                                          order.total ?? '0',
                                                        ) ??
                                                        0) *
                                                    100,
                                                "currency": "INR",
                                                // "name": "Test Payment",
                                                "wc_order_id": "${order.id}",
                                                "prefill": {
                                                  "name":
                                                      order.billing.firstName,
                                                  "email": order.billing.email,
                                                  "contact":
                                                      order.billing.phone,
                                                },
                                              };
                                              razorpay.open(options);
                                              razorpay.on(
                                                Razorpay.EVENT_PAYMENT_SUCCESS,
                                                (
                                                  PaymentSuccessResponse
                                                  response,
                                                ) {
                                                  log(
                                                    "Payment Success : ${response.paymentId}",
                                                  );
                                                  Navigator.pushReplacement(
                                                    context,
                                                    CupertinoPageRoute(
                                                      builder: (context) =>
                                                          OrderListPage(),
                                                    ),
                                                  );
                                                  showSuccessMessage(
                                                    context,
                                                    "Payment Successful",
                                                  );
                                                },
                                              );
                                              razorpay.on(
                                                Razorpay.EVENT_PAYMENT_ERROR,
                                                (
                                                  PaymentFailureResponse
                                                  response,
                                                ) {
                                                  log(
                                                    "Payment Failed : ${response.message}",
                                                  );

                                                  showErrorMessage(
                                                    "Payment Failed : ${response.message}",
                                                  );
                                                },
                                              );

                                              razorpay.on(
                                                Razorpay.EVENT_EXTERNAL_WALLET,
                                                (
                                                  ExternalWalletResponse
                                                  response,
                                                ) {
                                                  log(
                                                    "External Wallet : ${response.walletName}",
                                                  );
                                                },
                                              );
                                            },
                                            child: Text(
                                              "Pay Now",
                                              style: GoogleFonts.inter(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
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
      ),
    );
  }
}
