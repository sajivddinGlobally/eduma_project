import 'package:eduma_app/Screen/paymentMethid.page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentOverfiewPage extends StatefulWidget {
  const PaymentOverfiewPage({super.key});

  @override
  State<PaymentOverfiewPage> createState() => _PaymentOverfiewPageState();
}

class _PaymentOverfiewPageState extends State<PaymentOverfiewPage> {
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
                    buildStepCircle(number: 1, isActive: true),
                    buildLine(),
                    buildStepCircle(number: 2, isActive: false),
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
                        color: Color(0xFF001E6C),
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
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30.h),
              Center(
                child: Text(
                  "Overview",
                  style: GoogleFonts.inter(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF001E6C),
                  ),
                ),
              ),
              SizedBox(height: 30.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Course Name: Angular Course",
                      style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF001E6C),
                      ),
                    ),
                    SizedBox(height: 14.h),
                    Row(
                      children: [
                        Icon(Icons.ondemand_video, size: 22.sp),
                        SizedBox(width: 10.w),
                        Text(
                          "50+ Lectures",
                          style: GoogleFonts.roboto(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF6C6C6C),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      children: [
                        Icon(Icons.access_time_filled, size: 22.sp),
                        SizedBox(width: 10.w),
                        Text(
                          "4 Weeks",
                          style: GoogleFonts.roboto(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF6C6C6C),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      children: [
                        Icon(Icons.workspace_premium_rounded, size: 22.sp),
                        SizedBox(width: 10.w),
                        Text(
                          "Online Certificate",
                          style: GoogleFonts.roboto(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF6C6C6C),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 25.h),
                    Text(
                      "Skills",
                      style: GoogleFonts.roboto(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF00434C),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Wrap(
                      spacing: 8.w,
                      runSpacing: 8.h,
                      children: [
                        _skillChip("Typography"),
                        _skillChip("Layout composition"),
                        _skillChip("Branding"),
                        _skillChip("Visual communication"),
                        _skillChip("Editorial design"),
                      ],
                    ),
                    SizedBox(height: 30.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 18.r,
                              backgroundColor: Color(0xFF3e64de),
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
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF3e64de),
                    minimumSize: Size(double.infinity, 50.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => PaymentMethidPage(),
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
        ],
      ),
    );
  }

  Widget _skillChip(String label) {
    return Chip(
      label: Text(
        label,
        style: GoogleFonts.roboto(
          fontSize: 14.sp,
          color: Color(0xFF00434C),
          fontWeight: FontWeight.w500,
          letterSpacing: -0.4,
        ),
      ),
      backgroundColor: Colors.grey[100],
      shape: StadiumBorder(
        side: BorderSide(color: Color(0xFFDEDEDE), width: 1),
      ),
    );
  }
}

class buildStepCircle extends StatelessWidget {
  final int number;
  final bool isActive;
  const buildStepCircle({
    super.key,
    required this.number,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 49.w,
      height: 49.h,
      decoration: BoxDecoration(
        color: isActive ? Color(0xFF3e64de) : Color.fromARGB(51, 0, 3, 108),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          "$number",
          style: GoogleFonts.roboto(
            color: isActive ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class buildLine extends StatelessWidget {
  const buildLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(height: 1.2.h, color: Color(0xFF001E6C)),
    );
  }
}
