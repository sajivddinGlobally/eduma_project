import 'package:eduma_app/Screen/payment.success.page.dart';
import 'package:eduma_app/Screen/paymentOverfiew.page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentDetailsPage extends StatefulWidget {
  const PaymentDetailsPage({super.key});

  @override
  State<PaymentDetailsPage> createState() => _PaymentDetailsPageState();
}

class _PaymentDetailsPageState extends State<PaymentDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: SingleChildScrollView(
        child: Stack(
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 33.h),
                Row(
                  children: [
                    SizedBox(width: 20.w),
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
                  ],
                ),
                SizedBox(height: 20.h),
                // Progress stepper
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.w),
                  child: Row(
                    children: [
                      buildStepCircle(number: 1, isActive: false),
                      buildLine(),
                      buildStepCircle(number: 2, isActive: false),
                      buildLine(),
                      buildStepCircle(number: 3, isActive: true),
                    ],
                  ),
                ),
                SizedBox(height: 8.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 28.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Overview",
                        style: GoogleFonts.roboto(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "Payment Method",
                        style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "Completed",
                        style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF001E6C),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.h),
                Center(
                  child: Text(
                    "Add Card Details",
                    style: GoogleFonts.inter(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF001E6C),
                      letterSpacing: -0.4,
                    ),
                  ),
                ),
                SizedBox(height: 30.h),
                Padding(
                  padding: EdgeInsets.only(left: 20.w, right: 20.w),
                  child: Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          hint: Text(
                            "Card Number",
                            style: GoogleFonts.roboto(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF6C6C6C),
                            ),
                          ),
                          contentPadding: EdgeInsets.only(
                            bottom: 15.w,
                            left: 20.w,
                            top: 15.h,
                            right: 20.w,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.r),
                            borderSide: BorderSide(
                              color: Color(0xFF001E6C),
                              width: 1.w,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.r),
                            borderSide: BorderSide(
                              color: Color(0xFF001E6C),
                              width: 1.w,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hint: Text(
                                  "CVV Number",
                                  style: GoogleFonts.roboto(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF6C6C6C),
                                  ),
                                ),
                                contentPadding: EdgeInsets.only(
                                  bottom: 15.w,
                                  left: 20.w,
                                  top: 15.h,
                                  right: 20.w,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.r),
                                  borderSide: BorderSide(
                                    color: Color(0xFF001E6C),
                                    width: 1.w,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.r),
                                  borderSide: BorderSide(
                                    color: Color(0xFF001E6C),
                                    width: 1.w,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 20.w),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hint: Text(
                                  "Expiry Date",
                                  style: GoogleFonts.roboto(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF6C6C6C),
                                  ),
                                ),
                                contentPadding: EdgeInsets.only(
                                  bottom: 15.w,
                                  left: 20.w,
                                  top: 15.h,
                                  right: 20.w,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.r),
                                  borderSide: BorderSide(
                                    color: Color(0xFF001E6C),
                                    width: 1.w,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.r),
                                  borderSide: BorderSide(
                                    color: Color(0xFF001E6C),
                                    width: 1.w,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      TextField(
                        decoration: InputDecoration(
                          hint: Text(
                            "Name on Card",
                            style: GoogleFonts.roboto(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF6C6C6C),
                            ),
                          ),
                          contentPadding: EdgeInsets.only(
                            bottom: 15.w,
                            left: 20.w,
                            top: 15.h,
                            right: 20.w,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.r),
                            borderSide: BorderSide(
                              color: Color(0xFF001E6C),
                              width: 1.w,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.r),
                            borderSide: BorderSide(
                              color: Color(0xFF001E6C),
                              width: 1.w,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        "We will store and use your card details for smooth and secure future purchases.",
                        style: GoogleFonts.roboto(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF6C6C6C),
                          letterSpacing: -0.5,
                        ),
                      ),
                      SizedBox(height: 30.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 18.r,
                                backgroundColor: Color(0xFF001E6C),
                                child: Icon(
                                  Icons.attach_money,
                                  color: Colors.white,
                                  size: 20.sp,
                                ),
                              ),
                              SizedBox(width: 6.w),
                              Text(
                                "Total Price",
                                style: GoogleFonts.inter(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF001E6C),
                                  letterSpacing: -0.4,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "35\$",
                            style: GoogleFonts.inter(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF001E6C),
                              letterSpacing: -0.4,
                            ),
                          ),
                        ],
                      ),
                      Divider(),
                      SizedBox(height: 20.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF001E6C),
                            minimumSize: Size(double.infinity, 50.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => PaymentSuccessPage(),
                              ),
                            );
                          },
                          child: Text(
                            "Continue",
                            style: GoogleFonts.inter(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 30.h),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
