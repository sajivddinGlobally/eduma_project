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
                    child: Text(
                      "Review Your Order",
                      style: GoogleFonts.poppins(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF001E6C).withOpacity(0.8),
                      ),
                    ),
                  ),
                  SizedBox(height: 15.h),
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
                              return Dismissible(
                                key: Key(item.productId.toString()),
                                direction: DismissDirection.endToStart,
                                background: Container(
                                  margin: EdgeInsets.only(top: 15.h),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16.r),
                                    color: Color(0xFFEF5350),
                                  ),
                                  alignment: Alignment.centerRight,
                                  padding: EdgeInsets.only(right: 20.w),
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.yellow,
                                    size: 24.sp,
                                  ),
                                ),
                                onDismissed: (direction) async {
                                  final body = CarRemoveBodyModel(
                                    productId: item.productId,
                                  );
                                  try {
                                    final service = APIStateNetwork(
                                      createDio(),
                                    );
                                    final response = await service.removeCart(
                                      body,
                                    );
                                    if (response.success == true) {
                                      showSuccessMessage(
                                        context,
                                        response.message,
                                      );
                                    }
                                    ref.invalidate(cartController);
                                  } catch (e) {
                                    log(e.toString());
                                    showSuccessMessage(context, e.toString());
                                  }
                                },
                                child: Container(
                                  margin: EdgeInsets.only(top: 15.h),
                                  padding: EdgeInsets.all(12.w),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16.r),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 6,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                          12.r,
                                        ),
                                        child: Image.network(
                                          item.thumbnail,
                                          width: 90.w,
                                          height: 90.h,
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) {
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
                                      SizedBox(width: 12.w),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              item.name,
                                              style: GoogleFonts.poppins(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xFF001E6C),
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            SizedBox(height: 8.h),
                                            Text(
                                              "\$${item.price.toStringAsFixed(2)}",
                                              style: GoogleFonts.poppins(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xFF001E6C),
                                              ),
                                            ),
                                            SizedBox(height: 8.h),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Qty: ${item.quantity}",
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0xFF747474),
                                                  ),
                                                ),
                                                Container(
                                                  width: 120.w,
                                                  height: 36.h,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          10.r,
                                                        ),
                                                    color: Color(0xFFF5F7FA),
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                      left: 10.w,
                                                      right: 10.w,
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        IconButton(
                                                          style: IconButton.styleFrom(
                                                            minimumSize:
                                                                Size.zero,
                                                            padding:
                                                                EdgeInsets.zero,
                                                            tapTargetSize:
                                                                MaterialTapTargetSize
                                                                    .shrinkWrap,
                                                          ),
                                                          icon: Icon(
                                                            Icons.remove,
                                                            size: 20.sp,
                                                            color: Color(
                                                              0xFF001E6C,
                                                            ),
                                                          ),
                                                          onPressed: () {
                                                            if (item.quantity >
                                                                1) {
                                                              setState(() {
                                                                item.quantity--;
                                                              });
                                                            }
                                                          },
                                                        ),
                                                        Text(
                                                          "${item.quantity}",
                                                          style:
                                                              GoogleFonts.poppins(
                                                                fontSize: 16.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Color(
                                                                  0xFF001E6C,
                                                                ),
                                                              ),
                                                        ),
                                                        IconButton(
                                                          style: IconButton.styleFrom(
                                                            minimumSize:
                                                                Size.zero,
                                                            padding:
                                                                EdgeInsets.zero,
                                                            tapTargetSize:
                                                                MaterialTapTargetSize
                                                                    .shrinkWrap,
                                                          ),
                                                          icon: Icon(
                                                            Icons.add,
                                                            size: 20.sp,
                                                            color: Color(
                                                              0xFF001E6C,
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
                                "\$${totalPrice.toStringAsFixed(2)}",
                                style: GoogleFonts.poppins(
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
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                elevation: 2,
                              ),
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "Proceeding to checkout",
                                      style: GoogleFonts.poppins(),
                                    ),
                                    duration: Duration(seconds: 2),
                                    backgroundColor: Color(0xFF001E6C),
                                  ),
                                );
                              },
                              child: Text(
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
