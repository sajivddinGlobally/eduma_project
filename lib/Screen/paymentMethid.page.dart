import 'package:eduma_app/Screen/paymentOverfiew.page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentMethidPage extends StatefulWidget {
  const PaymentMethidPage({super.key});

  @override
  State<PaymentMethidPage> createState() => _PaymentMethidPageState();
}

class _PaymentMethidPageState extends State<PaymentMethidPage> {
  int selectIndex = 0;

  final List<String> paymentMethods = [
    "Credit / Debit Card",
    "JazzCash / EasyPaisa",
  ];
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
                    buildStepCircle(number: 2, isActive: true),
                    buildLine(),
                    buildStepCircle(number: 3, isActive: false),
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
                        color: Color(0xFF001E6C),
                      ),
                    ),
                    Text(
                      "Completed",
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30.h),
              Center(
                child: Text(
                  "Select  Payment Method",
                  style: GoogleFonts.inter(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF001E6C),
                    letterSpacing: -0.4,
                  ),
                ),
              ),
              SizedBox(height: 40.h),
              Padding(
                padding: EdgeInsets.only(left: 15.w, right: 25.w, bottom: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(paymentMethods.length, (index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Radio<int>(
                              value: index,
                              groupValue: selectIndex,
                              onChanged: (value) {
                                setState(() {
                                  selectIndex = value!;
                                });
                              },
                            ),
                            Text(
                              paymentMethods[index],
                              style: GoogleFonts.roboto(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF6C6C6C),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        if (index == 0) ...[
                          Row(
                            children: [
                              SizedBox(height: 10.h),
                              _buildPaymentIcon("assets/visa-logo.png"),
                              SizedBox(height: 10.h),
                              _buildPaymentIcon("assets/Mastercard.png"),
                              SizedBox(height: 10.h),
                              _buildPaymentIcon("assets/PayPal.png"),
                              SizedBox(height: 10.h),
                              _buildPaymentIcon("assets/Maestro.png"),
                            ],
                          ),
                          SizedBox(height: 10.h),
                        ],
                      ],
                    );
                  }),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentIcon(String imagePath) {
    return Container(
      margin: EdgeInsets.only(left: 20.w),
      width: 40.w,
      height: 27.h,
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(4.r),
        border: Border.all(color: Color(0xFFD9D9D9), width: 0.95.w),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 0),
            blurRadius: 4.34,
            spreadRadius: 0,
            color: Color.fromARGB(17, 0, 0, 0),
          ),
        ],
      ),
      child: Image.asset(imagePath),
    );
  }
}
