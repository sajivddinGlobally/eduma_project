import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:otp_pin_field/otp_pin_field.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 100.h),
              Center(
                child: Image.asset(
                  "assets/logo.png",
                  width: 284.w,
                  height: 284.h,
                ),
              ),
              SizedBox(height: 45.h),
              Divider(color: Colors.black12, thickness: 1),
              SizedBox(height: 10.h),
              Center(
                child: Text(
                  "OTP Verification",
                  style: GoogleFonts.roboto(
                    fontSize: 26.sp,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1B1B1B),
                    letterSpacing: -0.4,
                  ),
                ),
              ),
              // SizedBox(height: 15.h),
              // Text(
              //   "Enter the verification code we just sent on\nyour email address.",
              //   style: GoogleFonts.roboto(
              //     fontSize: 13.sp,
              //     fontWeight: FontWeight.w400,
              //     color: Color(0xff4D4D4D),
              //   ),
              // ),
              SizedBox(height: 15.h),
              OtpPinField(
                maxLength: 6,
                keyboardType: TextInputType.number,
                otpPinFieldDecoration:
                    OtpPinFieldDecoration.roundedPinBoxDecoration,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                onSubmit: (text) {},
                onChange: (text) {},
              ),
              SizedBox(height: 20.h),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF001E6C),
                  minimumSize: Size(400.w, 52.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.r),
                  ),
                ),
                child: Text(
                  "Verify",
                  style: GoogleFonts.roboto(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    letterSpacing: -1,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
