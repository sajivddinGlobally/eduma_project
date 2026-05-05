import 'dart:developer';
import 'package:eduma_app/Screen/addressFormPage.dart';
import 'package:eduma_app/Screen/home.page.dart';
import 'package:eduma_app/Screen/orderList.page.dart';
import 'package:eduma_app/config/core/showFlushbar.dart';
import 'package:eduma_app/config/network/api.state.dart';
import 'package:eduma_app/config/utils/navigatorKey.dart';
import 'package:eduma_app/config/utils/pretty.dio.dart';
import 'package:eduma_app/data/Controller/applyCuponController.dart';
import 'package:eduma_app/data/Controller/calculateDynamicController.dart';
import 'package:eduma_app/data/Controller/getCuponController.dart';
import 'package:eduma_app/data/Controller/userAddressController.dart';
import 'package:eduma_app/data/Model/createBodyModel.dart' hide Shipping;
import 'package:eduma_app/data/Model/razorpayBodyModel.dart';
import 'package:eduma_app/data/Model/userAddressResModel.dart';
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
  bool _hasNavigatedToForm = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _checkAndNavigateIfNoAddress();
      try {
        final data = await ref.read(userAddressController.future);

        if (data.hasBilling && data.billing?.state != null) {
          await ref
              .read(calculateDynamicProvider.notifier)
              .calculateDyanmicAmmount(stateName: data.billing!.state);
        }
      } catch (e) {
        log("InitState Error: $e");
      }
    });
  }

  void _checkAndNavigateIfNoAddress() async {
    final addres = ref.read(userAddressController);
    addres.whenData((data) {
      if ((!data.hasBilling || !data.hasShipping) && !_hasNavigatedToForm) {
        setState(() {
          _hasNavigatedToForm = true;
        });
        Navigator.push(
          context,
          CupertinoPageRoute(builder: (context) => const AddressFormPage()),
        ).then((result) {
          setState(() {
            _hasNavigatedToForm = false;
          });
          if (result == true) {
            // Save किया, fresh data load करें
            ref.invalidate(userAddressController);
          } else {
            // Save नहीं किया, previous screen पर वापस जाएं (loop break)
            if (context.mounted) {
              Navigator.pop(context);
            }
          }
        });
      }
    });
  }

  TextEditingController couponController = TextEditingController();
  String? couponCode;

  @override
  Widget build(BuildContext context) {
    // double totalPrice = widget.Item.fold(0.0, (sum, item) {
    //   final subtotal = item['price'] * item['quantity'];
    //   return sum + subtotal;
    // });

    // double subtotal = widget.Item.fold(0.0, (sum, item) {
    //   return sum + (item['price'] * item['quantity']);
    // });
    // double finalTotal = subtotal - discountAmount + deliveryCharge;

    final addres = ref.watch(userAddressController);
    final calculateDynamicState = ref.watch(calculateDynamicProvider);
    final applyCuponState = ref.watch(applyCuponProvider);
    final isCupon = applyCuponState.isLoading;
    final getCouponState = ref.watch(getCuponController);
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
                if (!data.hasBilling || !data.hasShipping) {
                  return Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Please add an address to proceed.',
                          style: GoogleFonts.inter(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20.h),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => const AddressFormPage(),
                                ),
                              ).then((result) async {
                                if (result == true) {
                                  ref.invalidate(userAddressController);

                                  final data = await ref.read(
                                    userAddressController.future,
                                  );

                                  if (data.hasBilling &&
                                      data.billing?.state != null) {
                                    await ref
                                        .read(calculateDynamicProvider.notifier)
                                        .calculateDyanmicAmmount(
                                          stateName: data.billing!.state,
                                        );
                                  }
                                }
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              padding: EdgeInsets.symmetric(vertical: 16.h),
                            ),
                            child: Text(
                              'Add Address',
                              style: GoogleFonts.inter(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
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
                        padding: EdgeInsets.only(
                          top: 5.h,
                          bottom: 5.h,
                          left: 5.w,
                          right: 5.w,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 6,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: couponController,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 10.w),
                                  hintText: "Enter Coupon Code",
                                  hintStyle: GoogleFonts.poppins(
                                    fontSize: 14.sp,
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),

                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.zero,
                                // backgroundColor: Color(0xFF001E6C),
                                backgroundColor: Color(0xFF24ADD7),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                              ),
                              onPressed: () async {
                                if (couponController.text.isEmpty) {
                                  return;
                                }
                                await ref
                                    .read(applyCuponProvider.notifier)
                                    .appluCupon(
                                      cuponCode: couponController.text.trim(),
                                      context: context,
                                    );

                                final state = ref.read(applyCuponProvider);

                                state.whenOrNull(
                                  data: (data) {
                                    if (data?.success == true) {
                                      couponController.clear();
                                    }
                                  },
                                );
                              },
                              child: isCupon
                                  ? Center(
                                      child: SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 1.5,
                                        ),
                                      ),
                                    )
                                  : Text(
                                      "Apply",
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ),

                      getCouponState.when(
                        data: (data) {
                          couponCode = data.couponCode;
                          return Padding(
                            padding: EdgeInsets.only(top: 6.h),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                  size: 18.sp,
                                ),
                                SizedBox(width: 5.w),

                                Text(
                                  "Coupon Applied: ${data.couponCode} (${data.discountLabel})",
                                  style: GoogleFonts.poppins(
                                    fontSize: 14.sp,
                                    color: Colors.green,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        loading: () => SizedBox(),
                        error: (error, stackTrace) {
                          log("Get Cupon Error : - $stackTrace");
                          return Center(
                            child: Text("Get Cupon Error : - $error"),
                          );
                        },
                      ),

                      calculateDynamicState.when(
                        data: (dataCalculate) {
                          // return Container(
                          //   margin: EdgeInsets.only(top: 15.h),
                          //   padding: EdgeInsets.all(16.w),
                          //   decoration: BoxDecoration(
                          //     color: Colors.white,
                          //     borderRadius: BorderRadius.circular(12.r),
                          //     boxShadow: [
                          //       BoxShadow(
                          //         color: Colors.black12,
                          //         blurRadius: 6,
                          //         offset: const Offset(0, 2),
                          //       ),
                          //     ],
                          //   ),
                          //   child: Column(
                          //     children: [
                          //       Row(
                          //         mainAxisAlignment:
                          //             MainAxisAlignment.spaceBetween,
                          //         children: [
                          //           Text(
                          //             "Subtotal",
                          //             style: GoogleFonts.poppins(
                          //               fontSize: 16.sp,
                          //               fontWeight: FontWeight.w500,
                          //               color: const Color(0xFF001E6C),
                          //             ),
                          //           ),
                          //           Text(
                          //             "₹${data?.subtotal ?? 0}",
                          //             style: GoogleFonts.poppins(
                          //               fontSize: 16.sp,
                          //               fontWeight: FontWeight.w500,
                          //               color: Colors.black87,
                          //             ),
                          //           ),
                          //         ],
                          //       ),
                          //       Row(
                          //         mainAxisAlignment:
                          //             MainAxisAlignment.spaceBetween,
                          //         children: [
                          //           Text(
                          //             "Coupon:$couponCode",
                          //             style: GoogleFonts.poppins(
                          //               fontSize: 16.sp,
                          //               fontWeight: FontWeight.w500,
                          //               color: const Color(0xFF001E6C),
                          //             ),
                          //           ),
                          //           Text(
                          //             "- ₹${data?.discount20Percent ?? 0}",
                          //             style: GoogleFonts.poppins(
                          //               fontSize: 16.sp,
                          //               fontWeight: FontWeight.w600,
                          //               color: Colors.green,
                          //             ),
                          //           ),
                          //         ],
                          //       ),
                          //       Row(
                          //         mainAxisAlignment:
                          //             MainAxisAlignment.spaceBetween,
                          //         children: [
                          //           Text(
                          //             "ATATC Surat Shipping",
                          //             style: GoogleFonts.poppins(
                          //               fontSize: 14.sp,
                          //               fontWeight: FontWeight.w400,
                          //               color: Colors.grey[700],
                          //             ),
                          //           ),
                          //           Text(
                          //             "₹${data?.shippingCost ?? 0}",
                          //             style: GoogleFonts.poppins(
                          //               fontSize: 14.sp,
                          //               fontWeight: FontWeight.w500,
                          //               color: Colors.black87,
                          //             ),
                          //           ),
                          //         ],
                          //       ),
                          //       Divider(),
                          //       Row(
                          //         mainAxisAlignment:
                          //             MainAxisAlignment.spaceBetween,
                          //         children: [
                          //           Text(
                          //             "Total Amount",
                          //             style: GoogleFonts.poppins(
                          //               fontSize: 20.sp,
                          //               fontWeight: FontWeight.w700,
                          //               color: const Color(0xFF001E6C),
                          //             ),
                          //           ),
                          //           Text(
                          //             "₹${data?.finalTotal ?? 0}",
                          //             style: GoogleFonts.poppins(
                          //               fontSize: 20.sp,
                          //               fontWeight: FontWeight.w700,
                          //               color: Colors.green[700],
                          //             ),
                          //           ),
                          //         ],
                          //       ),
                          //     ],
                          //   ),
                          // );

                          return Container(
                            margin: EdgeInsets.only(top: 15.h),
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                /// Title
                                Text(
                                  "Cart totals",
                                  style: GoogleFonts.poppins(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF1D1D1F),
                                  ),
                                ),

                                SizedBox(height: 15.h),

                                /// Subtotal
                                _rowItem(
                                  "Subtotal",
                                  "₹${dataCalculate?.subtotal ?? 0}",
                                ),

                                Divider(),

                                /// Coupon Row
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Coupon: ${couponCode ?? "auto20"}",
                                      style: GoogleFonts.poppins(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "-₹${dataCalculate?.discount20Percent ?? 0}",
                                          style: TextStyle(color: Colors.red),
                                        ),
                                        SizedBox(width: 5.w),
                                        // GestureDetector(
                                        //   onTap: () {
                                        //   },
                                        //   child: Text(
                                        //     "[Remove]",
                                        //     style: TextStyle(
                                        //       color: Colors.red,
                                        //       decoration:
                                        //           TextDecoration.underline,
                                        //     ),
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ],
                                ),

                                Divider(),

                                /// Shipping Section
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        "ATATC Surat Shipping",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),

                                    Expanded(
                                      flex: 3,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Packing, Forwarding & Courier - Rest of India:",
                                            style: GoogleFonts.poppins(
                                              fontSize: 13.sp,
                                            ),
                                          ),
                                          SizedBox(height: 5.h),
                                          Text(
                                            "₹${dataCalculate?.shippingCost ?? 0}",
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(height: 10.h),

                                /// Address Info
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      /// Normal Text
                                      TextSpan(
                                        text: "Shipping to ",
                                        style: GoogleFonts.poppins(
                                          fontSize: 14.sp,
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),

                                      /// Bold Address Text
                                      TextSpan(
                                        text:
                                            "${data.billing!.address1}, ${data.billing!.city}, ${data.billing!.postcode}, ${data.billing!.state}, ${data.billing!.country}.",
                                        style: GoogleFonts.poppins(
                                          fontSize: 15.sp,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                SizedBox(height: 5.h),

                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                        builder: (context) =>
                                            const AddressFormPage(),
                                      ),
                                    ).then((result) {
                                      if (result == true && context.mounted) {
                                        ref.invalidate(userAddressController);
                                      }
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        "Change address",
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.w500,
                                          decorationColor: Colors.red,
                                          decoration: TextDecoration.underline,
                                          decorationThickness: 2,
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      Icon(
                                        Icons.local_shipping,
                                        color: Colors.red,
                                        size: 16,
                                      ),
                                    ],
                                  ),
                                ),

                                Divider(height: 25.h),

                                /// Total
                                _rowItem(
                                  "Total",
                                  "₹${dataCalculate?.finalTotal ?? 0}",
                                  isBold: true,
                                ),
                              ],
                            ),
                          );
                        },
                        error: (error, stackTrace) {
                          return Center(child: Text(error.toString()));
                        },
                        loading: () => Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),

                      // SizedBox(height: 15.h),
                      // Text(
                      //   "Billing Address",
                      //   style: GoogleFonts.inter(
                      //     fontSize: 20.sp,
                      //     fontWeight: FontWeight.bold,
                      //     color: Colors.black,
                      //   ),
                      // ),
                      // SizedBox(height: 10.h),
                      // Card(
                      //   elevation: 4,
                      //   shape: RoundedRectangleBorder(
                      //     borderRadius: BorderRadius.circular(12.r),
                      //   ),
                      //   child: Padding(
                      //     padding: EdgeInsets.all(16.w),
                      //     child: Column(
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       children: [
                      //         /// 🔥 Top Row (Name + Change Button)
                      //         Row(
                      //           crossAxisAlignment: CrossAxisAlignment.start,
                      //           children: [
                      //             /// ✅ Name (Flexible to avoid overflow)
                      //             Expanded(
                      //               child: Text(
                      //                 "${data.billing!.firstName} ${data.billing!.lastName}",
                      //                 maxLines: 1,
                      //                 overflow: TextOverflow.ellipsis,
                      //                 style: GoogleFonts.inter(
                      //                   fontSize: 18.sp,
                      //                   fontWeight: FontWeight.bold,
                      //                   color: Colors.black,
                      //                 ),
                      //               ),
                      //             ),
                      //             SizedBox(width: 10.w),
                      //             /// ✅ Change Button (fixed size)
                      //             InkWell(
                      //               onTap: () {
                      //                 Navigator.push(
                      //                   context,
                      //                   CupertinoPageRoute(
                      //                     builder: (context) =>
                      //                         const AddressFormPage(),
                      //                   ),
                      //                 ).then((result) {
                      //                   if (result == true && context.mounted) {
                      //                     ref.invalidate(userAddressController);
                      //                   }
                      //                 });
                      //               },
                      //               child: Container(
                      //                 padding: EdgeInsets.symmetric(
                      //                   horizontal: 10.w,
                      //                   vertical: 6.h,
                      //                 ),
                      //                 decoration: BoxDecoration(
                      //                   borderRadius: BorderRadius.circular(
                      //                     10.r,
                      //                   ),
                      //                   color: Colors.lightBlueAccent,
                      //                 ),
                      //                 child: Text(
                      //                   "Change Address",
                      //                   style: GoogleFonts.inter(
                      //                     fontSize: 14.sp,
                      //                     fontWeight: FontWeight.w500,
                      //                     color: Colors.white,
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //         SizedBox(height: 10.h),
                      //         /// 🔥 Address Line 1
                      //         Text(
                      //           "${data.billing!.address1}, ${data.billing!.city}",
                      //           maxLines: 2,
                      //           overflow: TextOverflow.ellipsis,
                      //           style: GoogleFonts.inter(
                      //             fontSize: 14.sp,
                      //             fontWeight: FontWeight.w500,
                      //             color: Colors.blue,
                      //           ),
                      //         ),
                      //         SizedBox(height: 4.h),
                      //         /// 🔥 Address Line 2
                      //         Text(
                      //           "${data.billing!.state}, ${data.billing!.country}, ${data.billing!.postcode}",
                      //           maxLines: 2,
                      //           overflow: TextOverflow.ellipsis,
                      //           style: GoogleFonts.inter(
                      //             fontSize: 14.sp,
                      //             fontWeight: FontWeight.w500,
                      //             color: Colors.blue,
                      //           ),
                      //         ),
                      //         SizedBox(height: 6.h),
                      //         /// 🔥 Phone
                      //         Text(
                      //           "Phone: ${data.billing!.phone}",
                      //           maxLines: 1,
                      //           overflow: TextOverflow.ellipsis,
                      //           style: GoogleFonts.inter(
                      //             fontSize: 14.sp,
                      //             fontWeight: FontWeight.w500,
                      //             color: Colors.blue,
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      SizedBox(height: 24.h),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            final dynamicState = ref.read(
                              calculateDynamicProvider,
                            );
                            int finalAmount = dynamicState.when(
                              data: (data) => (data?.finalTotal ?? 0).toInt(),
                              loading: () => 0,
                              error: (_, __) => 0,
                            );
                            log("Final Ammount $finalAmount");
                            // final body = CreateBodyModel(
                            //   cart: [
                            //     Cart(
                            //       productId: int.parse(widget.productId),
                            //       quantity: int.parse(widget.quantity),
                            //     ),
                            //   ],
                            //   billing: Billing(
                            //     firstName: data.billing!.firstName,
                            //     lastName: data.billing!.lastName,
                            //     address1: data.billing!.address1,
                            //     city: data.billing!.city,
                            //     postcode: data.billing!.postcode,
                            //     phone: data.billing!.phone.toString(),
                            //     email: data.billing!.email.toString(),
                            //   ),
                            //   shipping: Shipping(state: data.shipping!.state),
                            // );

                            final body = RazoarpayBodyModel(
                              shipping: Shipping(state: data.shipping!.state),
                            );

                            try {
                              setState(() => isLoading = true);
                              final service = APIStateNetwork(createDio());
                              final response = await service.create(body);
                              if (response != null) {
                                final razorpay = Razorpay();
                                final options = {
                                  "order_id": response.orderId,
                                  // "amount": response.amount * 100,
                                  "amount": finalAmount,
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

  Widget _rowItem(String title, String value, {bool isBold = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: isBold ? 16.sp : 14.sp,
              fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: isBold ? 16.sp : 14.sp,
              fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
