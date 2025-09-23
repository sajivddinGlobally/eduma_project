import 'dart:developer';
import 'package:eduma_app/Screen/editProfile.page.dart';
import 'package:eduma_app/Screen/home.page.dart';
import 'package:eduma_app/Screen/productDetails.page.dart';
import 'package:eduma_app/config/core/showFlushbar.dart'
    hide showSuccessMessage;
import 'package:eduma_app/config/network/api.state.dart';
import 'package:eduma_app/config/utils/pretty.dio.dart';
import 'package:eduma_app/data/Controller/cartController.dart';
import 'package:eduma_app/data/Controller/orderCreateController.dart';
import 'package:eduma_app/data/Model/addCartBodyModel.dart';
import 'package:eduma_app/data/Model/cartModel.dart';
import 'package:eduma_app/data/Model/cartRemoveBodyModel.dart';
import 'package:eduma_app/data/Model/removerCartQuanityrBodModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shimmer/shimmer.dart';

class CartPage extends ConsumerStatefulWidget {
  const CartPage({super.key});

  @override
  ConsumerState<CartPage> createState() => _CartPageState();
}

class _CartPageState extends ConsumerState<CartPage> {
  bool isUpdating = false;
  bool isLoading = false;
  bool isCheck = false;
  Future<void> updateCartQuantity(
    int productId,
    int quantity,
    int newquantity,
  ) async {
    if (newquantity < 1) return;
    log("Updating quantity for product $productId to $quantity");
    setState(() => isUpdating = true);
    try {
      final body = ProductAddCartBodyModel(
        productId: productId,
        quantity: newquantity,
      );
      final service = APIStateNetwork(createDio());
      final response = await service.addToCart(body);
      if (response.success == true) {
        ref.invalidate(cartController); // Refresh cart data
        showSuccessMessage(context, "Quantity updated successfully");
        setState(() => isUpdating = false);
      } else {
        showSuccessMessage(
          context,
          "Failed to update quantity: ${response.message}",
        );
      }
    } catch (e) {
      log("Error updating quantity: $e");
      showSuccessMessage(context, "Error updating quantity");
    } finally {
      setState(() => isUpdating = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = ref.watch(cartController);

    return Scaffold(
      backgroundColor: Color(0xFFF5F7FA),
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
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFE8F0FE), Color(0xFFF5F7FA)],
              ),
            ),
          ),
          cartProvider.when(
            data: (data) {
              double totalPrice = data.items.fold(
                0,
                (sum, item) => sum + (item.price * item.quantity),
              );
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      top: 30.h,
                      left: 20.w,
                      right: 20.w,
                    ),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            padding: EdgeInsets.all(8.w),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 8,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.arrow_back,
                              color: Color(0xFF001E6C),
                              size: 24.sp,
                            ),
                          ),
                        ),
                        SizedBox(width: 20.w),
                        Text(
                          "Your Cart",
                          style: GoogleFonts.poppins(
                            fontSize: 28.sp,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF001E6C),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Row(
                      children: [
                        Text(
                          "Review Your Order",
                          style: GoogleFonts.poppins(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF001E6C).withOpacity(0.8),
                          ),
                        ),
                        Spacer(),
                        TextButton(
                          onPressed: () async {
                            setState(() {
                              isLoading = true;
                            });
                            final service = APIStateNetwork(createDio());
                            final response = await service.clearAll();

                            if (response != null) {
                              setState(() {
                                isLoading = false;
                              });
                              showSuccessMessage(context, response.message);
                              ref.refresh(cartController);
                            } else {
                              setState(() {
                                isLoading = false;
                              });
                            }
                          },
                          child: isLoading
                              ? SizedBox(
                                  width: 20.w,
                                  height: 20.h,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      strokeWidth: 1.5,
                                    ),
                                  ),
                                )
                              : Text(
                                  "Clear All",
                                  style: GoogleFonts.poppins(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF001E6C),
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Expanded(
                    child: data.items.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.shopping_cart_outlined,
                                  size: 80.sp,
                                  color: Color(0xFF747474),
                                ),
                                SizedBox(height: 10.h),
                                Text(
                                  "Your cart is empty",
                                  style: GoogleFonts.poppins(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF747474),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : ListView.builder(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            itemCount: data.items.length,
                            itemBuilder: (context, index) {
                              final item = data.items[index];
                              return CartBody(data: data.items[index]);
                            },
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
                                style: GoogleFonts.poppins(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF001E6C),
                                ),
                              ),
                              Text(
                                "₹${data.subtotal.toStringAsFixed(2)}",
                                // "₹${data.subtotal.toString()}",
                                style: GoogleFonts.poppins(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF001E6C),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15.h),
                          // SizedBox(
                          //   width: double.infinity,
                          //   height: 50.h,
                          //   child: ElevatedButton(
                          //     style: ElevatedButton.styleFrom(
                          //       backgroundColor: const Color(0xFF001E6C),
                          //       shape: RoundedRectangleBorder(
                          //         borderRadius: BorderRadius.circular(12.r),
                          //       ),
                          //       elevation: 2,
                          //     ),
                          //     onPressed: () async {
                          //       // final data =  ref
                          //       //     .watch(orderCreateController)
                          //       //     .value;

                          //       final data = await ref.refresh(
                          //         orderCreateController.future,
                          //       );

                          //       if (data == null) {
                          //         showErrorMessage(
                          //           "Order create failed, please try again",
                          //         );
                          //         return;
                          //       }

                          //       final razorpay = Razorpay();

                          //       final options = {
                          //         "order_id": data!.orderId,
                          //         "amount": data.amount * 100,
                          //         "currency": "INR",
                          //         "receipt": data.receipt,
                          //         "key": "rzp_test_RIeIwZBZ2NZi6w",
                          //         "wc_order_id": data.wcOrderId,
                          //         "prefill": {
                          //           "name": data.user.name,
                          //           "email": data.user.email,
                          //           "contact": data.user.contact,
                          //         },
                          //       };
                          //       razorpay.open(options);
                          //       razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, (
                          //         PaymentSuccessResponse response,
                          //       ) {
                          //         log(
                          //           "Payment Success : ${response.paymentId}",
                          //         );
                          //         showSuccessMessage(
                          //           context,
                          //           "Payment Successful",
                          //         );
                          //         Navigator.pushAndRemoveUntil(
                          //           context,
                          //           CupertinoPageRoute(
                          //             builder: (context) => HomePage(),
                          //           ),
                          //           (route) => false,
                          //         );
                          //       });
                          //       razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, (
                          //         PaymentFailureResponse response,
                          //       ) {
                          //         log("Payment Failed : ${response.message}");
                          //         showErrorMessage(
                          //           "Payment Failed : ${response.message}",
                          //         );
                          //       });
                          //       razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, (
                          //         ExternalWalletResponse response,
                          //       ) {
                          //         log(
                          //           "External Wallet : ${response.walletName}",
                          //         );
                          //       });
                          //     },
                          //     child: Text(
                          //       "Proceed to Checkout",
                          //       style: GoogleFonts.poppins(
                          //         fontSize: 16.sp,
                          //         fontWeight: FontWeight.w600,
                          //         color: Colors.white,
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          SizedBox(
                            width: double.infinity,
                            height: 50.h,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF001E6C),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                elevation: 2,
                              ),
                              onPressed: isLoading
                                  ? null
                                  : () async {
                                      setState(() => isCheck = true);

                                      try {
                                        final data = await ref.refresh(
                                          orderCreateController.future,
                                        );

                                        if (data == null) {
                                          showErrorMessage(
                                            "Order create failed, please try again",
                                          );
                                          setState(() => isCheck = false);
                                          return;
                                        }

                                        final razorpay = Razorpay();
                                        final options = {
                                          "order_id": data.orderId,
                                          "amount": data.amount * 100,
                                          "currency": "INR",
                                          "receipt": data.receipt,
                                          "key": "rzp_test_RIeIwZBZ2NZi6w",
                                          "wc_order_id": data.wcOrderId,
                                          "prefill": {
                                            "name": data.user.name,
                                            "email": data.user.email,
                                            "contact": data.user.contact,
                                          },
                                        };

                                        razorpay.open(options);

                                        razorpay.on(
                                          Razorpay.EVENT_PAYMENT_SUCCESS,
                                          (PaymentSuccessResponse response) {
                                            log(
                                              "Payment Success : ${response.paymentId}",
                                            );
                                            showSuccessMessage(
                                              context,
                                              "Payment Successful",
                                            );
                                            Navigator.pushAndRemoveUntil(
                                              context,
                                              CupertinoPageRoute(
                                                builder: (context) =>
                                                    HomePage(),
                                              ),
                                              (route) => false,
                                            );
                                          },
                                        );

                                        razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, (
                                          PaymentFailureResponse response,
                                        ) {
                                          log(
                                            "Payment Failed : ${response.message}",
                                          );
                                          // showErrorMessage(
                                          //   "Payment Failed : ${response.message}",
                                          // );
                                        });

                                        razorpay.on(
                                          Razorpay.EVENT_EXTERNAL_WALLET,
                                          (ExternalWalletResponse response) {
                                            log(
                                              "External Wallet : ${response.walletName}",
                                            );
                                          },
                                        );
                                      } catch (e, st) {
                                        showErrorMessage(
                                          "Something went wrong: $e",
                                        );
                                        log("Error: $e");
                                        log("StackTrace: $st");
                                        log(e.toString());
                                      } finally {
                                        setState(() => isCheck = false);
                                      }
                                    },
                              child: isCheck
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : Text(
                                      "Proceed to Checkout",
                                      style: GoogleFonts.poppins(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
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
                style: GoogleFonts.poppins(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.red,
                ),
              ),
            ),
            loading: () => Padding(
              padding: EdgeInsets.all(20.w),
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      margin: EdgeInsets.only(bottom: 15.h),
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 90.w,
                            height: 90.h,
                            color: Colors.grey[400],
                          ),
                          SizedBox(width: 12.w),
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

// class CartBody extends ConsumerStatefulWidget {
//   final Item data;
//   const CartBody({super.key, required this.data});

//   @override
//   ConsumerState<CartBody> createState() => _CartBodyState();
// }

// class _CartBodyState extends ConsumerState<CartBody> {
//   bool isUpdating = false;

//   Future<void> updateCartQuantity(int productId, int newQuantity) async {
//     if (isUpdating) return;
//     setState(() => isUpdating = true);

//     try {
//       final body = ProductAddCartBodyModel(
//         productId: productId,
//         quantity: newQuantity, // ✅ Pure new quantity bhejo
//       );

//       final service = APIStateNetwork(createDio());
//       final response = await service.addToCart(body);

//       if (response.success == true) {
//         ref.invalidate(cartController); // ✅ Refresh cart after update
//       } else {
//         showSuccessMessage(
//           context,
//           "Failed to update quantity: ${response.message}",
//         );
//       }
//     } catch (e) {
//       showSuccessMessage(context, "Error updating quantity: $e");
//     } finally {
//       setState(() => isUpdating = false);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Container(
//           margin: EdgeInsets.only(top: 15.h),
//           padding: EdgeInsets.all(12.w),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(16.r),
//             color: Colors.white,
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black12,
//                 blurRadius: 6,
//                 offset: Offset(0, 2),
//               ),
//             ],
//           ),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(12.r),
//                 child: Image.network(
//                   widget.data.thumbnail,
//                   width: 90.w,
//                   height: 90.h,
//                   fit: BoxFit.cover,
//                   errorBuilder: (context, error, stackTrace) {
//                     return Container(
//                       width: 90.w,
//                       height: 90.h,
//                       color: Colors.grey[200],
//                       child: Icon(
//                         Icons.image_not_supported,
//                         color: Colors.grey[600],
//                         size: 40.sp,
//                       ),
//                     );
//                   },
//                 ),
//               ),

//               SizedBox(width: 12.w),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       widget.data.name,
//                       style: GoogleFonts.poppins(
//                         fontSize: 16.sp,
//                         fontWeight: FontWeight.w600,
//                         color: Color(0xFF001E6C),
//                       ),
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                     SizedBox(height: 8.h),
//                     Text(
//                       "₹${widget.data.price}",
//                       style: GoogleFonts.poppins(
//                         fontSize: 14.sp,
//                         fontWeight: FontWeight.w500,
//                         color: Color(0xFF001E6C),
//                       ),
//                     ),
//                     SizedBox(height: 8.h),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           "Qty: ${widget.data.quantity}",
//                           style: GoogleFonts.poppins(
//                             fontSize: 14.sp,
//                             fontWeight: FontWeight.w500,
//                             color: Color(0xFF747474),
//                           ),
//                         ),
//                         Container(
//                           width: 120.w,
//                           height: 36.h,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10.r),
//                             color: Color(0xFFF5F7FA),
//                           ),
//                           child: Padding(
//                             padding: EdgeInsets.only(left: 10.w, right: 10.w),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 IconButton(
//                                   style: IconButton.styleFrom(
//                                     minimumSize: Size.zero,
//                                     padding: EdgeInsets.zero,
//                                     tapTargetSize:
//                                         MaterialTapTargetSize.shrinkWrap,
//                                   ),
//                                   icon: Icon(
//                                     Icons.remove,
//                                     size: 20.sp,
//                                     color: Color(0xFF001E6C),
//                                   ),

//                                   onPressed: () async {
//                                     final body = RemoveCartQuantityBodyModel(
//                                       productId: widget.data.productId,
//                                     );
//                                     try {
//                                       final serivice = APIStateNetwork(
//                                         createDio(),
//                                       );
//                                       final response = await serivice
//                                           .removerQuantiry(body);
//                                       if (response.success == true) {
//                                         showSuccessMessage(
//                                           context,
//                                           response.message,
//                                         );
//                                       } else {
//                                         log("Sorry");
//                                       }
//                                     } catch (e) {
//                                       log(e.toString());
//                                     }
//                                   },
//                                 ),
//                                 Text(
//                                   "${widget.data.quantity}",
//                                   style: GoogleFonts.poppins(
//                                     fontSize: 16.sp,
//                                     fontWeight: FontWeight.w600,
//                                     color: Color(0xFF001E6C),
//                                   ),
//                                 ),
//                                 IconButton(
//                                   style: IconButton.styleFrom(
//                                     minimumSize: Size.zero,
//                                     padding: EdgeInsets.zero,
//                                     tapTargetSize:
//                                         MaterialTapTargetSize.shrinkWrap,
//                                   ),
//                                   icon: Icon(
//                                     Icons.add,
//                                     size: 20.sp,
//                                     color: Color(0xFF001E6C),
//                                   ),

//                                   onPressed: isUpdating
//                                       ? null
//                                       : () async {
//                                           await updateCartQuantity(
//                                             widget.data.productId,
//                                             1,
//                                           );
//                                         },
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               InkWell(
//                 onTap: () async {
//                   final body = CarRemoveBodyModel(
//                     productId: widget.data.productId,
//                   );
//                   try {
//                     final service = APIStateNetwork(createDio());
//                     final response = await service.removeCart(body);
//                     if (response.success == true) {
//                       showSuccessMessage(context, response.message);
//                     }
//                     ref.invalidate(cartController);
//                   } catch (e) {
//                     log(e.toString());
//                     showSuccessMessage(context, e.toString());
//                   }
//                 },
//                 child: Container(
//                   width: 40.w,
//                   height: 40.h,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: Colors.white,
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black12,
//                         blurRadius: 6.r,
//                         offset: Offset(0, 2),
//                       ),
//                     ],
//                   ),
//                   child: Icon(
//                     Icons.delete_outline,
//                     color: Colors.redAccent,
//                     size: 24.sp,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

class CartBody extends ConsumerStatefulWidget {
  final Item data;
  const CartBody({super.key, required this.data});

  @override
  ConsumerState<CartBody> createState() => _CartBodyState();
}

class _CartBodyState extends ConsumerState<CartBody> {
  bool isUpdating = false;

  Future<void> updateCartQuantity(int productId, int newQuantity) async {
    if (isUpdating) return;
    setState(() => isUpdating = true);

    try {
      final body = ProductAddCartBodyModel(
        productId: productId,
        quantity: newQuantity,
      );

      final service = APIStateNetwork(createDio());
      final response = await service.addToCart(body);

      if (response.success == true) {
        ref.invalidate(cartController);
      } else {
        showSuccessMessage(
          context,
          "Failed to update quantity: ${response.message}",
        );
      }
    } catch (e) {
      showSuccessMessage(context, "Error updating quantity: $e");
    } finally {
      setState(() => isUpdating = false);
    }
  }

  Future<void> removeCartQuantity(int productId) async {
    if (isUpdating) return;
    setState(() => isUpdating = true);

    try {
      final body = RemoveCartQuantityBodyModel(productId: productId);
      final service = APIStateNetwork(createDio());
      final response = await service.removerQuantiry(body);

      if (response.success == true) {
        //showSuccessMessage(context, response.message);
        ref.invalidate(cartController);
      } else {
        showSuccessMessage(
          context,
          "Failed to remove quantity: ${response.message}",
        );
      }
    } catch (e) {
      log(e.toString());
      showSuccessMessage(context, "Error removing quantity: $e");
    } finally {
      setState(() => isUpdating = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final totalPrice = widget.data.price * widget.data.quantity;

    return Container(
      margin: EdgeInsets.only(top: 15.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) =>
                      ProductDetailsPage(id: widget.data.productId.toString()),
                ),
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.network(
                widget.data.thumbnail,
                width: 90.w,
                height: 90.h,
                fit: BoxFit.fill,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 90.w,
                    height: 90.h,
                    color: Colors.grey[200],
                    child: Icon(
                      Icons.image_not_supported,
                      color: Colors.grey[600],
                      size: 40.sp,
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        widget.data.name,
                        style: GoogleFonts.poppins(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF001E6C),
                          height: 1.2,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        final body = CarRemoveBodyModel(
                          productId: widget.data.productId,
                        );
                        try {
                          final service = APIStateNetwork(createDio());
                          final response = await service.removeCart(body);
                          if (response.success == true) {
                            showSuccessMessage(context, response.message);
                            ref.invalidate(cartController);
                          } else {
                            showSuccessMessage(
                              context,
                              "Failed to remove item: ${response.message}",
                            );
                          }
                        } catch (e) {
                          log(e.toString());
                          showSuccessMessage(
                            context,
                            "Error removing item: $e",
                          );
                        }
                      },
                      child: Container(
                        width: 40.w,
                        height: 40.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 6.r,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.delete_outline,
                          color: Colors.redAccent,
                          size: 24.sp,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Text(
                  "₹${widget.data.price}",
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF001E6C),
                  ),
                ),
                SizedBox(height: 8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Qty: ${widget.data.quantity}",
                      style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF747474),
                      ),
                    ),
                    Spacer(),
                    Container(
                      // width: 120.w,
                      height: 36.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: Color(0xFFF5F7FA),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            style: IconButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: Size.square(25),
                            ),
                            icon: Icon(
                              Icons.remove,
                              size: 20.sp,
                              color: Color(0xFF001E6C),
                            ),
                            onPressed: isUpdating
                                ? null
                                : () async {
                                    await removeCartQuantity(
                                      widget.data.productId,
                                    );
                                  },
                          ),
                          Text(
                            "${widget.data.quantity}",
                            style: GoogleFonts.poppins(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF001E6C),
                            ),
                          ),
                          IconButton(
                            style: IconButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: Size.square(25),
                            ),
                            icon: Icon(
                              Icons.add,
                              size: 20.sp,
                              color: Color(0xFF001E6C),
                            ),
                            onPressed: isUpdating
                                ? null
                                : () async {
                                    await updateCartQuantity(
                                      widget.data.productId,
                                      1,
                                    );
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
    );
  }
}
