import 'package:eduma_app/Screen/paymentOverfiew.page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentSuccessPage extends StatefulWidget {
  const PaymentSuccessPage({super.key});

  @override
  State<PaymentSuccessPage> createState() => _PaymentSuccessPageState();
}

class _PaymentSuccessPageState extends State<PaymentSuccessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Stack(
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
              SizedBox(height: 50.h),
              Center(
                child: Container(
                  width: 50.w,
                  height: 51.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF001E6C),
                  ),
                  child: Center(
                    child: Icon(Icons.done_all, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 40.h),
              Center(child: Image.asset("assets/succ.png")),
              SizedBox(height: 30.h),
              Center(
                child: Text(
                  "Congratulations!",
                  style: GoogleFonts.roboto(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF00434C),
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Center(
                child: Text(
                  "Start Your Learning Today!",
                  style: GoogleFonts.roboto(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF00434C),
                    letterSpacing: -0.4,
                  ),
                ),
              ),
              SizedBox(height: 30.h),
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
            ],
          ),
        ],
      ),
    );
  }
}
