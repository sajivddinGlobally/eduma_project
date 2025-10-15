import 'dart:developer';
import 'package:eduma_app/Screen/addressFormPage.dart';
import 'package:eduma_app/Screen/home.page.dart';
import 'package:eduma_app/Screen/orderList.page.dart';
import 'package:eduma_app/config/core/showFlushbar.dart';
import 'package:eduma_app/config/network/api.state.dart';
import 'package:eduma_app/config/utils/navigatorKey.dart';
import 'package:eduma_app/config/utils/pretty.dio.dart';
import 'package:eduma_app/data/Controller/userAddressController.dart';
import 'package:eduma_app/data/Model/createBodyModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class FillAddressPage extends ConsumerStatefulWidget {
  final List<dynamic> Item;
  final int totalPrice;
  final String productId;
  final String quantity;
  const FillAddressPage({
    super.key,
    required this.productId,
    required this.quantity,
    required this.Item,
    required this.totalPrice,
  });

  @override
  ConsumerState<FillAddressPage> createState() => _FillAddressPageState();
}

class _FillAddressPageState extends ConsumerState<FillAddressPage> {
  bool isCheck = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    double totalPrice = widget.Item.fold(0.0, (sum, item) {
      final subtotal = item['price'] * item['quantity'];
      return sum + subtotal;
    });
    final addres = ref.watch(userAddressController);
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        title: Text('Order Review'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            addres.when(
              data: (data) {
                if (data.hasBilling == false || data.shipping == false) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => AddressFormPage(),
                        fullscreenDialog: true,
                      ),
                    ).then((_) {
                      ref.refresh(userAddressController);
                    });
                  });
                  return SizedBox.shrink();
                } else {
                  return Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ✅ Multiple Product Cards
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: widget.Item.length,
                          itemBuilder: (context, index) {
                            final item = widget.Item[index];
                            final subtotal = item['price'] * item['quantity'];

                            return Card(
                              elevation: 3,
                              margin: EdgeInsets.only(bottom: 16.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(12.w),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Product Image
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10.r),
                                      child: Image.network(
                                        item['thumbnail'] ?? '',
                                        width: 90.w,
                                        height: 90.h,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stack) =>
                                            const Icon(
                                              Icons.image_not_supported,
                                              size: 80,
                                              color: Colors.grey,
                                            ),
                                      ),
                                    ),
                                    SizedBox(width: 16.w),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item['name'] ?? 'Product',
                                            style: GoogleFonts.poppins(
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.w600,
                                              color: const Color(0xFF001E6C),
                                            ),
                                          ),
                                          SizedBox(height: 6.h),
                                          Text(
                                            "Quantity: ${item['quantity']}",
                                            style: GoogleFonts.poppins(
                                              fontSize: 14.sp,
                                              color: Colors.grey[700],
                                            ),
                                          ),
                                          SizedBox(height: 8.h),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Price:",
                                                style: GoogleFonts.poppins(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.grey[600],
                                                ),
                                              ),
                                              Text(
                                                "₹${item['price'].toStringAsFixed(2)}",
                                                style: GoogleFonts.poppins(
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.green[700],
                                                ),
                                              ),
                                            ],
                                          ),
                                          // SizedBox(height: 5.h),
                                          // Row(
                                          //   mainAxisAlignment:
                                          //       MainAxisAlignment.spaceBetween,
                                          //   children: [
                                          //     Text(
                                          //       "Subtotal:",
                                          //       style: GoogleFonts.poppins(
                                          //         fontSize: 14.sp,
                                          //         fontWeight: FontWeight.w500,
                                          //         color: Colors.grey[600],
                                          //       ),
                                          //     ),
                                          //     Text(
                                          //       "₹${subtotal.toStringAsFixed(2)}",
                                          //       style: GoogleFonts.poppins(
                                          //         fontSize: 16.sp,
                                          //         fontWeight: FontWeight.w600,
                                          //         color: Colors.green[700],
                                          //       ),
                                          //     ),
                                          //   ],
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        Container(
                          padding: EdgeInsets.all(16.w),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Total Amount:",
                                style: GoogleFonts.poppins(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF001E6C),
                                ),
                              ),
                              Text(
                                "₹${totalPrice.toString()}",
                                style: GoogleFonts.poppins(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.green[700],
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 15.h),
                        Text(
                          "Billing Address",
                          style: GoogleFonts.inter(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Card(
                          elevation: 4,
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${data.billing!.firstName} ${data.billing!.lastName}",
                                      style: GoogleFonts.inter(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),

                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                            builder: (context) =>
                                                AddressFormPage(),
                                            fullscreenDialog: true,
                                          ),
                                        );
                                      },
                                      child: Container(
                                        padding: EdgeInsets.only(
                                          left: 10.w,
                                          right: 10.w,
                                          top: 5.h,
                                          bottom: 5.h,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            10.r,
                                          ),
                                          color: Colors.lightBlueAccent,
                                        ),
                                        child: Text(
                                          "Change",
                                          style: GoogleFonts.inter(
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8.h),
                                Text(
                                  "${data.billing!.address1}, ${data.billing!.city}",
                                  style: GoogleFonts.inter(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.blue,
                                  ),
                                ),
                                Text(
                                  " ${data.billing!.state},  ${data.billing!.country}, ${data.billing!.postcode}",
                                  style: GoogleFonts.inter(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.blue,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  'Phone: ${data.billing!.phone}',
                                  style: GoogleFonts.inter(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // SizedBox(height: 10.h),
                        // Row(
                        //   children: [
                        //     Checkbox(
                        //       value: isCheck,
                        //       onChanged: (value) {
                        //         setState(() {
                        //           isCheck = !isCheck;
                        //         });
                        //       },
                        //     ),
                        //     Text(
                        //       'Shipping Address',
                        //       style: GoogleFonts.inter(
                        //         fontSize: 20.sp,
                        //         fontWeight: FontWeight.bold,
                        //         color: Colors.black,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // SizedBox(height: 10.h),
                        // if (isCheck)
                        //   Card(
                        //     elevation: 4,
                        //     child: Padding(
                        //       padding: EdgeInsets.all(16.0),
                        //       child: Column(
                        //         crossAxisAlignment: CrossAxisAlignment.start,
                        //         children: [
                        //           Row(
                        //             mainAxisAlignment:
                        //                 MainAxisAlignment.spaceBetween,
                        //             children: [
                        //               Text(
                        //                 "${data.shipping!.firstName} ${data.shipping!.lastName}",
                        //                 style: GoogleFonts.inter(
                        //                   fontSize: 18.sp,
                        //                   fontWeight: FontWeight.bold,
                        //                   color: Colors.black,
                        //                 ),
                        //               ),
                        //               // IconButton(
                        //               //   icon: Icon(Icons.edit, color: Colors.blue),
                        //               //   onPressed: _editAddress,
                        //               //   tooltip: 'Address Change Karo',
                        //               // ),
                        //               InkWell(
                        //                 onTap: () {
                        //                   Navigator.push(
                        //                     context,
                        //                     CupertinoPageRoute(
                        //                       builder: (context) =>
                        //                           AddressFormPage(),
                        //                       fullscreenDialog: true,
                        //                     ),
                        //                   );
                        //                 },
                        //                 child: Container(
                        //                   padding: EdgeInsets.only(
                        //                     left: 10.w,
                        //                     right: 10.w,
                        //                     top: 5.h,
                        //                     bottom: 5.h,
                        //                   ),
                        //                   decoration: BoxDecoration(
                        //                     borderRadius: BorderRadius.circular(
                        //                       10.r,
                        //                     ),
                        //                     color: Colors.lightBlueAccent,
                        //                   ),
                        //                   child: Text(
                        //                     "Change",
                        //                     style: GoogleFonts.inter(
                        //                       fontSize: 15.sp,
                        //                       fontWeight: FontWeight.w400,
                        //                       color: Colors.white,
                        //                     ),
                        //                   ),
                        //                 ),
                        //               ),
                        //             ],
                        //           ),
                        //           SizedBox(height: 8.h),
                        //           Text(
                        //             "${data.shipping!.address1}, ${data.shipping!.city}",
                        //             style: GoogleFonts.inter(
                        //               fontSize: 15.sp,
                        //               fontWeight: FontWeight.w500,
                        //               color: Colors.blue,
                        //             ),
                        //           ),
                        //           Text(
                        //             "${data.shipping!.state}, ${data.shipping!.country}, ${data.shipping!.postcode}",
                        //             style: GoogleFonts.inter(
                        //               fontSize: 15.sp,
                        //               fontWeight: FontWeight.w500,
                        //               color: Colors.blue,
                        //             ),
                        //           ),
                        //           SizedBox(height: 4.h),
                        //           Text(
                        //             'Phone: ',
                        //             style: GoogleFonts.inter(
                        //               fontSize: 15.sp,
                        //               fontWeight: FontWeight.w500,
                        //               color: Colors.blue,
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        SizedBox(height: 24.h),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              final body = CreateBodyModel(
                                cart: [
                                  Cart(
                                    productId: int.parse(widget.productId),
                                    quantity: int.parse(widget.quantity),
                                  ),
                                ],
                                billing: Billing(
                                  firstName: data.billing!.firstName,
                                  lastName: data.billing!.lastName,
                                  address1: data.billing!.address1,
                                  city: data.billing!.city,
                                  postcode: data.billing!.postcode,
                                  phone: data.billing!.phone.toString(),
                                  email: data.billing!.email.toString(),
                                ),
                              );
                              try {
                                setState(() => isLoading = true);
                                final service = APIStateNetwork(createDio());
                                final response = await service.create(body);
                                if (response != null) {
                                  final razorpay = Razorpay();
                                  final options = {
                                    "order_id": response.orderId,
                                    "amount": response.amount * 100,
                                    "currency": "INR",
                                    "receipt": response.receipt,
                                    // "key": "rzp_test_RIeIwZBZ2NZi6w",
                                    "key": "rzp_live_RQVbHR68ibVPuJ",
                                    "wc_order_id": response.wcOrderId,
                                    "prefill": {
                                      "name": response.user.name,
                                      "email": response.user.email,
                                      "contact": response.user.contact,
                                    },
                                  };
                                  razorpay.open(options);
                                  razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, (
                                    PaymentSuccessResponse response,
                                  ) {
                                    log(
                                      "Payment Success : ${response.paymentId}",
                                    );
                                    // Navigator.pushAndRemoveUntil(
                                    //   context,
                                    //   CupertinoPageRoute(
                                    //     builder: (context) => HomePage(),
                                    //   ),
                                    //   (route) => false,
                                    // );
                                    Navigator.pushReplacement(
                                      context,
                                      CupertinoPageRoute(
                                        builder: (context) => OrderListPage(),
                                      ),
                                    );
                                    showSuccessMessage(
                                      context,
                                      "Payment Successful",
                                    );
                                    setState(() => isLoading = false);
                                  });
                                  razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, (
                                    PaymentFailureResponse response,
                                  ) {
                                    log("Payment Failed : ${response.message}");
                                    setState(() => isLoading = false);
                                    showErrorMessage(
                                      "Payment Failed : ${response.message}",
                                    );
                                  });
                                  razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, (
                                    ExternalWalletResponse response,
                                  ) {
                                    log(
                                      "External Wallet : ${response.walletName}",
                                    );
                                    setState(() => isLoading = false);
                                  });
                                } else {
                                  setState(() => isLoading = false);
                                  log("Unknow Error");
                                }
                              } catch (e, st) {
                                setState(() => isLoading = false);
                                //showErrorMessage("Something went wrong: $e");
                                log("Error: $e");
                                log("StackTrace: $st");
                                log(e.toString());
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              padding: EdgeInsets.symmetric(vertical: 16),
                            ),
                            child: isLoading
                                ? Center(
                                    child: SizedBox(
                                      width: 30.w,
                                      height: 30.h,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 1.5,
                                      ),
                                    ),
                                  )
                                : Text(
                                    'Place Order',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
              error: (error, stackTrace) {
                log(stackTrace.toString());
                return Center(child: Text(error.toString()));
              },
              loading: () => Center(child: CircularProgressIndicator()),
            ),
          ],
        ),
      ),
    );
  }
}
