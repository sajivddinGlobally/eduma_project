import 'dart:developer';

import 'package:eduma_app/Screen/editProfile.page.dart';
import 'package:eduma_app/config/network/api.state.dart';
import 'package:eduma_app/config/utils/pretty.dio.dart';
import 'package:eduma_app/data/Controller/cartController.dart';
import 'package:eduma_app/data/Model/cartRemoveBodyModel.dart';
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
              double totalPrice = data.items.fold(
                0,
                (sum, item) => sum + (item.price * item.quantity),
              );

              return Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 33.h),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
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
                                    minimumSize: Size.zero,
                                    padding: EdgeInsets.zero,
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                  ),
                                  onPressed: () => Navigator.pop(context),
                                  icon: Icon(
                                    Icons.arrow_back,
                                    color: Color(0xFF001E6C),
                                    size: 20.sp,
                                  ),
                                ),
                              ),
                              SizedBox(width: 50.w),
                              Text(
                                "Your Cart",
                                style: GoogleFonts.roboto(
                                  fontSize: 26.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF1B1B1B),
                                  letterSpacing: -0.4,
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
                            child: data.items.isEmpty
                                ? Center(
                                    child: Text(
                                      "Your cart is empty",
                                      style: GoogleFonts.roboto(
                                        fontSize: 18.sp,
                                        color: Color(0xFF747474),
                                      ),
                                    ),
                                  )
                                : ListView.builder(
                                    padding: EdgeInsets.zero,
                                    itemCount: data.items.length,
                                    itemBuilder: (context, index) {
                                      final item = data.items[index];
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(top: 15.h),
                                            padding: EdgeInsets.all(10.w),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20.r),
                                              color: Color.fromARGB(
                                                255,
                                                232,
                                                228,
                                                228,
                                              ),
                                            ),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        10.r,
                                                      ),
                                                  child: Image.network(
                                                    item.thumbnail,
                                                    width: 100.w,
                                                    height: 100.h,
                                                    fit: BoxFit.cover,
                                                    errorBuilder:
                                                        (
                                                          context,
                                                          error,
                                                          stackTrace,
                                                        ) {
                                                          return Container(
                                                            width: 100.w,
                                                            height: 100.h,
                                                            color: Colors
                                                                .grey[300],
                                                            child: Icon(
                                                              Icons
                                                                  .image_not_supported,
                                                              color: Colors
                                                                  .grey[600],
                                                            ),
                                                          );
                                                        },
                                                  ),
                                                ),
                                                SizedBox(width: 10.w),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          SizedBox(
                                                            width: 200.w,
                                                            child: Text(
                                                              item.name,
                                                              style: GoogleFonts.roboto(
                                                                fontSize: 16.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: Color(
                                                                  0xFF000000,
                                                                ),
                                                                letterSpacing:
                                                                    -0.4,
                                                                height: 1,
                                                              ),
                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                  right: 10.w,
                                                                  top: 10.h,
                                                                ),
                                                            child: IconButton(
                                                              style: IconButton.styleFrom(
                                                                minimumSize:
                                                                    Size(0, 0),
                                                                padding:
                                                                    EdgeInsets
                                                                        .zero,
                                                                tapTargetSize:
                                                                    MaterialTapTargetSize
                                                                        .shrinkWrap,
                                                              ),
                                                              icon: Icon(
                                                                Icons.delete,
                                                                size: 20.sp,
                                                                color: Color(
                                                                  0xFFEF5350,
                                                                ),
                                                              ),
                                                              onPressed: () async {
                                                                // Assuming cartController has a method to remove item
                                                                // ref.read(cartController.notifier).removeItem(item.productId);
                                                                // setState(() {});
                                                                final body =
                                                                    CarRemoveBodyModel(
                                                                      productId:
                                                                          item.productId,
                                                                    );
                                                                try {
                                                                  final service =
                                                                      APIStateNetwork(
                                                                        createDio(),
                                                                      );
                                                                  final response =
                                                                      await service
                                                                          .removeCart(
                                                                            body,
                                                                          );
                                                                  if (response
                                                                          .success ==
                                                                      true) {
                                                                    showSuccessMessage(
                                                                      context,
                                                                      response
                                                                          .message,
                                                                    );
                                                                  }
                                                                  ref.invalidate(
                                                                    cartController,
                                                                  );
                                                                } catch (e) {
                                                                  log(
                                                                    e.toString(),
                                                                  );
                                                                  showSuccessMessage(
                                                                    context,
                                                                    e.toString(),
                                                                  );
                                                                }
                                                              },
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(height: 5.h),
                                                      Text(
                                                        "\$${item.price.toStringAsFixed(2)}",
                                                        style:
                                                            GoogleFonts.roboto(
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color: Color(
                                                                0xFF001E6C,
                                                              ),
                                                              letterSpacing:
                                                                  -0.4,
                                                            ),
                                                      ),
                                                      SizedBox(height: 5.h),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            "Qty: ${item.quantity}",
                                                            style:
                                                                GoogleFonts.roboto(
                                                                  fontSize:
                                                                      14.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: Color(
                                                                    0xFF747474,
                                                                  ),
                                                                ),
                                                          ),
                                                          Container(
                                                            width: 120.w,
                                                            height: 40.h,
                                                            decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                    10.r,
                                                                  ),
                                                              border: Border.all(
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              children: [
                                                                IconButton(
                                                                  style: IconButton.styleFrom(
                                                                    minimumSize:
                                                                        Size(
                                                                          0,
                                                                          0,
                                                                        ),
                                                                    padding:
                                                                        EdgeInsets
                                                                            .zero,
                                                                    tapTargetSize:
                                                                        MaterialTapTargetSize
                                                                            .shrinkWrap,
                                                                  ),
                                                                  icon: Text(
                                                                    "-",
                                                                    style: GoogleFonts.roboto(
                                                                      fontSize:
                                                                          30.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                  ),
                                                                  onPressed: () {
                                                                    if (item.quantity >
                                                                        1) {
                                                                      setState(
                                                                        () {
                                                                          item.quantity--;
                                                                        },
                                                                      );
                                                                    } else {
                                                                      // Optionally remove item if quantity becomes 0
                                                                      // ref.read(cartController.notifier).removeItem(item.productId);
                                                                      // setState(() {});
                                                                    }
                                                                  },
                                                                ),
                                                                Text(
                                                                  "${item.quantity}",
                                                                  style: GoogleFonts.roboto(
                                                                    fontSize:
                                                                        20.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                ),
                                                                IconButton(
                                                                  style: IconButton.styleFrom(
                                                                    minimumSize:
                                                                        Size(
                                                                          0,
                                                                          0,
                                                                        ),
                                                                    padding:
                                                                        EdgeInsets
                                                                            .zero,
                                                                    tapTargetSize:
                                                                        MaterialTapTargetSize
                                                                            .shrinkWrap,
                                                                  ),
                                                                  icon: Text(
                                                                    "+",
                                                                    style: GoogleFonts.roboto(
                                                                      fontSize:
                                                                          27.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                  ),
                                                                  onPressed: () {
                                                                    setState(() {
                                                                      item.quantity++;
                                                                    });
                                                                  },
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
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (data.items.isNotEmpty)
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 20.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10,
                            offset: Offset(0, -2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Total:",
                                style: GoogleFonts.roboto(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF001E6C),
                                ),
                              ),
                              Text(
                                "\$${totalPrice.toStringAsFixed(2)}",
                                style: GoogleFonts.roboto(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF001E6C),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15.h),
                          SizedBox(
                            width: double.infinity,
                            height: 50.h,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF001E6C),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                              ),
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Proceeding to checkout"),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              },
                              child: Text(
                                "Proceed to Checkout",
                                style: GoogleFonts.roboto(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              );
            },
            error: (error, stackTrace) => Center(
              child: Text(
                error.toString(),
                style: GoogleFonts.roboto(fontSize: 16.sp, color: Colors.red),
              ),
            ),
            loading: () => Padding(
              padding: EdgeInsets.all(20.w),
              child: ListView.builder(
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
          ),
        ],
      ),
    );
  }
}

// import 'dart:developer';

// import 'package:eduma_app/Screen/editProfile.page.dart';
// import 'package:eduma_app/config/network/api.state.dart';
// import 'package:eduma_app/config/utils/pretty.dio.dart';
// import 'package:eduma_app/data/Controller/cartController.dart';
// import 'package:eduma_app/data/Model/cartRemoveBodyModel.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:shimmer/shimmer.dart';

// class CartPage extends ConsumerStatefulWidget {
//   const CartPage({super.key});

//   @override
//   ConsumerState<CartPage> createState() => _CartPageState();
// }

// class _CartPageState extends ConsumerState<CartPage> {
//   @override
//   Widget build(BuildContext context) {
//     final cartProvider = ref.watch(cartController);
//     return Scaffold(
//       backgroundColor: Color(0xFFFFFFFF),
//       body: Stack(
//         children: [
//           Positioned(
//             left: -110,
//             top: -120.h,
//             child: Image.asset(
//               "assets/vect.png",
//               width: 363.w,
//               height: 270.h,
//               fit: BoxFit.fitHeight,
//             ),
//           ),
//           Positioned(
//             bottom: -40.h,
//             left: 0,
//             right: 0,
//             child: Image.asset(
//               "assets/vec.png",
//               width: 470.w,
//               height: 450.h,
//               fit: BoxFit.fill,
//             ),
//           ),
//           cartProvider.when(
//             data: (data) {
//               double totalPrice = data.items.fold(
//                 0,
//                 (sum, item) => sum + (item.price * item.quantity),
//               );

//               return Column(
//                 children: [
//                   Expanded(
//                     child: Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 20.w),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           SizedBox(height: 33.h),
//                           Row(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Container(
//                                 width: 37.w,
//                                 height: 37.h,
//                                 decoration: BoxDecoration(
//                                   shape: BoxShape.circle,
//                                   color: Color.fromARGB(25, 0, 0, 0),
//                                 ),
//                                 child: IconButton(
//                                   style: IconButton.styleFrom(
//                                     minimumSize: Size.zero,
//                                     padding: EdgeInsets.zero,
//                                     tapTargetSize:
//                                         MaterialTapTargetSize.shrinkWrap,
//                                   ),
//                                   onPressed: () => Navigator.pop(context),
//                                   icon: Icon(
//                                     Icons.arrow_back,
//                                     color: Color(0xFF001E6C),
//                                     size: 20.sp,
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(width: 50.w),
//                               Text(
//                                 "Your Cart",
//                                 style: GoogleFonts.roboto(
//                                   fontSize: 26.sp,
//                                   fontWeight: FontWeight.w600,
//                                   color: Color(0xFF1B1B1B),
//                                   letterSpacing: -0.4,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           SizedBox(height: 20.h),
//                           Text(
//                             "Review Your Order",
//                             style: GoogleFonts.roboto(
//                               fontSize: 16.sp,
//                               fontWeight: FontWeight.w500,
//                               color: Color(0xFF001E6C),
//                               letterSpacing: -0.4,
//                             ),
//                           ),
//                           SizedBox(height: 10.h),
//                           Expanded(
//                             child: data.items.isEmpty
//                                 ? Center(
//                                     child: Text(
//                                       "Your cart is empty",
//                                       style: GoogleFonts.roboto(
//                                         fontSize: 18.sp,
//                                         color: Color(0xFF747474),
//                                       ),
//                                     ),
//                                   )
//                                 : ListView.builder(
//                                     padding: EdgeInsets.zero,
//                                     itemCount: data.items.length,
//                                     itemBuilder: (context, index) {
//                                       final item = data.items[index];
//                                       return Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Container(
//                                             margin: EdgeInsets.only(top: 15.h),
//                                             padding: EdgeInsets.all(10.w),
//                                             decoration: BoxDecoration(
//                                               borderRadius:
//                                                   BorderRadius.circular(20.r),
//                                               color: Color.fromARGB(
//                                                 255,
//                                                 232,
//                                                 228,
//                                                 228,
//                                               ),
//                                             ),
//                                             child: Row(
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               children: [
//                                                 ClipRRect(
//                                                   borderRadius:
//                                                       BorderRadius.circular(
//                                                         10.r,
//                                                       ),
//                                                   child: Image.network(
//                                                     item.thumbnail,
//                                                     width: 100.w,
//                                                     height: 100.h,
//                                                     fit: BoxFit.cover,
//                                                     errorBuilder:
//                                                         (
//                                                           context,
//                                                           error,
//                                                           stackTrace,
//                                                         ) {
//                                                           return Container(
//                                                             width: 100.w,
//                                                             height: 100.h,
//                                                             color: Colors
//                                                                 .grey[300],
//                                                             child: Icon(
//                                                               Icons
//                                                                   .image_not_supported,
//                                                               color: Colors
//                                                                   .grey[600],
//                                                             ),
//                                                           );
//                                                         },
//                                                   ),
//                                                 ),
//                                                 SizedBox(width: 10.w),
//                                                 Expanded(
//                                                   child: Column(
//                                                     crossAxisAlignment:
//                                                         CrossAxisAlignment
//                                                             .start,
//                                                     children: [
//                                                       Row(
//                                                         mainAxisAlignment:
//                                                             MainAxisAlignment
//                                                                 .spaceBetween,
//                                                         children: [
//                                                           SizedBox(
//                                                             width: 200.w,
//                                                             child: Text(
//                                                               item.name,
//                                                               style: GoogleFonts.roboto(
//                                                                 fontSize: 16.sp,
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .w500,
//                                                                 color: Color(
//                                                                   0xFF000000,
//                                                                 ),
//                                                                 letterSpacing:
//                                                                     -0.4,
//                                                                 height: 1,
//                                                               ),
//                                                               maxLines: 2,
//                                                               overflow:
//                                                                   TextOverflow
//                                                                       .ellipsis,
//                                                             ),
//                                                           ),
//                                                           Padding(
//                                                             padding:
//                                                                 EdgeInsets.only(
//                                                                   right: 10.w,
//                                                                   top: 10.h,
//                                                                 ),
//                                                             child: IconButton(
//                                                               style: IconButton.styleFrom(
//                                                                 minimumSize:
//                                                                     Size(0, 0),
//                                                                 padding:
//                                                                     EdgeInsets
//                                                                         .zero,
//                                                                 tapTargetSize:
//                                                                     MaterialTapTargetSize
//                                                                         .shrinkWrap,
//                                                               ),
//                                                               icon: Icon(
//                                                                 Icons.delete,
//                                                                 size: 20.sp,
//                                                                 color: Color(
//                                                                   0xFFEF5350,
//                                                                 ),
//                                                               ),
//                                                               onPressed: () async {
//                                                                 final body =
//                                                                     CarRemoveBodyModel(
//                                                                       productId:
//                                                                           item.productId,
//                                                                     );
//                                                                 try {
//                                                                   final service =
//                                                                       APIStateNetwork(
//                                                                         createDio(),
//                                                                       );
//                                                                   final response =
//                                                                       await service
//                                                                           .removeCart(
//                                                                             body,
//                                                                           );
//                                                                   if (response
//                                                                           .success ==
//                                                                       true) {
//                                                                     showSuccessMessage(
//                                                                       context,
//                                                                       response
//                                                                           .message,
//                                                                     );
//                                                                   }
//                                                                   ref.invalidate(
//                                                                     cartController,
//                                                                   );
//                                                                 } catch (e) {
//                                                                   log(
//                                                                     e.toString(),
//                                                                   );
//                                                                   showSuccessMessage(
//                                                                     context,
//                                                                     e.toString(),
//                                                                   );
//                                                                 }
//                                                               },
//                                                             ),
//                                                           ),
//                                                         ],
//                                                       ),
//                                                       SizedBox(height: 5.h),
//                                                       Text(
//                                                         "\$${item.price.toStringAsFixed(2)}",
//                                                         style:
//                                                             GoogleFonts.roboto(
//                                                               fontSize: 14.sp,
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .w500,
//                                                               color: Color(
//                                                                 0xFF001E6C,
//                                                               ),
//                                                               letterSpacing:
//                                                                   -0.4,
//                                                             ),
//                                                       ),
//                                                       SizedBox(height: 5.h),
//                                                       Row(
//                                                         mainAxisAlignment:
//                                                             MainAxisAlignment
//                                                                 .spaceBetween,
//                                                         children: [
//                                                           Text(
//                                                             "Qty: ${item.quantity}",
//                                                             style:
//                                                                 GoogleFonts.roboto(
//                                                                   fontSize:
//                                                                       14.sp,
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .w500,
//                                                                   color: Color(
//                                                                     0xFF747474,
//                                                                   ),
//                                                                 ),
//                                                           ),
//                                                           Container(
//                                                             width: 120.w,
//                                                             height: 40.h,
//                                                             decoration: BoxDecoration(
//                                                               borderRadius:
//                                                                   BorderRadius.circular(
//                                                                     10.r,
//                                                                   ),
//                                                               border: Border.all(
//                                                                 color: Colors
//                                                                     .white,
//                                                               ),
//                                                             ),
//                                                             child: Row(
//                                                               mainAxisAlignment:
//                                                                   MainAxisAlignment
//                                                                       .spaceEvenly,
//                                                               children: [
//                                                                 IconButton(
//                                                                   style: IconButton.styleFrom(
//                                                                     minimumSize:
//                                                                         Size(
//                                                                           0,
//                                                                           0,
//                                                                         ),
//                                                                     padding:
//                                                                         EdgeInsets
//                                                                             .zero,
//                                                                     tapTargetSize:
//                                                                         MaterialTapTargetSize
//                                                                             .shrinkWrap,
//                                                                   ),
//                                                                   icon: Text(
//                                                                     "-",
//                                                                     style: GoogleFonts.roboto(
//                                                                       fontSize:
//                                                                           30.sp,
//                                                                       fontWeight:
//                                                                           FontWeight
//                                                                               .w500,
//                                                                       color: Colors
//                                                                           .black,
//                                                                     ),
//                                                                   ),
//                                                                   onPressed: () {
//                                                                     if (item.quantity >
//                                                                         0) {
//                                                                       item.quantity--;
//                                                                     }
//                                                                   },
//                                                                 ),
//                                                                 Text(
//                                                                   "${item.quantity}",
//                                                                   style: GoogleFonts.roboto(
//                                                                     fontSize:
//                                                                         20.sp,
//                                                                     fontWeight:
//                                                                         FontWeight
//                                                                             .w500,
//                                                                     color: Colors
//                                                                         .black,
//                                                                   ),
//                                                                 ),
//                                                                 IconButton(
//                                                                   style: IconButton.styleFrom(
//                                                                     minimumSize:
//                                                                         Size(
//                                                                           0,
//                                                                           0,
//                                                                         ),
//                                                                     padding:
//                                                                         EdgeInsets
//                                                                             .zero,
//                                                                     tapTargetSize:
//                                                                         MaterialTapTargetSize
//                                                                             .shrinkWrap,
//                                                                   ),
//                                                                   icon: Text(
//                                                                     "+",
//                                                                     style: GoogleFonts.roboto(
//                                                                       fontSize:
//                                                                           27.sp,
//                                                                       fontWeight:
//                                                                           FontWeight
//                                                                               .w500,
//                                                                       color: Colors
//                                                                           .black,
//                                                                     ),
//                                                                   ),
//                                                                   onPressed: () {
//                                                                     if (item.quantity >
//                                                                         0) {
//                                                                       item.quantity++;
//                                                                     }
//                                                                   },
//                                                                 ),
//                                                               ],
//                                                             ),
//                                                           ),
//                                                         ],
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         ],
//                                       );
//                                     },
//                                   ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   if (data.items.isNotEmpty)
//                     Container(
//                       padding: EdgeInsets.symmetric(
//                         horizontal: 20.w,
//                         vertical: 20.h,
//                       ),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black12,
//                             blurRadius: 10,
//                             offset: Offset(0, -2),
//                           ),
//                         ],
//                       ),
//                       child: Column(
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 "Total:",
//                                 style: GoogleFonts.roboto(
//                                   fontSize: 18.sp,
//                                   fontWeight: FontWeight.w600,
//                                   color: Color(0xFF001E6C),
//                                 ),
//                               ),
//                               Text(
//                                 "\$${totalPrice.toStringAsFixed(2)}",
//                                 style: GoogleFonts.roboto(
//                                   fontSize: 18.sp,
//                                   fontWeight: FontWeight.w600,
//                                   color: Color(0xFF001E6C),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           SizedBox(height: 15.h),
//                           SizedBox(
//                             width: double.infinity,
//                             height: 50.h,
//                             child: ElevatedButton(
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: Color(0xFF001E6C),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(10.r),
//                                 ),
//                               ),
//                               onPressed: () {
//                                 // Implement checkout functionality
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                   SnackBar(
//                                     content: Text("Proceeding to checkout"),
//                                     duration: Duration(seconds: 2),
//                                   ),
//                                 );
//                               },
//                               child: Text(
//                                 "Proceed to Checkout",
//                                 style: GoogleFonts.roboto(
//                                   fontSize: 16.sp,
//                                   fontWeight: FontWeight.w500,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                 ],
//               );
//             },
//             error: (error, stackTrace) => Center(
//               child: Text(
//                 error.toString(),
//                 style: GoogleFonts.roboto(fontSize: 16.sp, color: Colors.red),
//               ),
//             ),
//             loading: () => Padding(
//               padding: EdgeInsets.all(20.w),
//               child: ListView.builder(
//                 itemCount: 4,
//                 itemBuilder: (context, index) {
//                   return Shimmer.fromColors(
//                     baseColor: Colors.grey[300]!,
//                     highlightColor: Colors.grey[100]!,
//                     child: Container(
//                       margin: EdgeInsets.only(bottom: 15.h),
//                       padding: EdgeInsets.all(10.w),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(20.r),
//                         color: Colors.white,
//                       ),
//                       child: Row(
//                         children: [
//                           Container(
//                             width: 100.w,
//                             height: 100.h,
//                             color: Colors.grey[400],
//                           ),
//                           SizedBox(width: 10.w),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Container(
//                                 width: 200.w,
//                                 height: 16.h,
//                                 color: Colors.grey[400],
//                               ),
//                               SizedBox(height: 10.h),
//                               Container(
//                                 width: 120.w,
//                                 height: 14.h,
//                                 color: Colors.grey[400],
//                               ),
//                               SizedBox(height: 10.h),
//                               Container(
//                                 width: 80.w,
//                                 height: 14.h,
//                                 color: Colors.grey[400],
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
