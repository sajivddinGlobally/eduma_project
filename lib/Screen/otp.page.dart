import 'dart:developer';

import 'package:eduma_app/Screen/changePassword.page.dart';
import 'package:eduma_app/Screen/login.page.dart';
import 'package:eduma_app/config/core/showFlushbar.dart';
import 'package:eduma_app/config/network/api.state.dart';
import 'package:eduma_app/config/utils/pretty.dio.dart';
import 'package:eduma_app/data/Controller/loadingController.dart';
import 'package:eduma_app/data/Model/verifyOTPBodyModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:otp_pin_field/otp_pin_field.dart';

class OtpPage extends ConsumerStatefulWidget {
  const OtpPage({super.key});

  @override
  ConsumerState<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends ConsumerState<OtpPage> {
  String otpValue = "";
  @override
  Widget build(BuildContext context) {
    final loadingProvider = ref.watch(loadingController);
    final isLoading = ref.read(loadingController.notifier);
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
                  "Enter OTP Code",
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
                fieldHeight: 55.h,
                fieldWidth: 55.w,
                keyboardType: TextInputType.number,
                otpPinFieldDecoration: OtpPinFieldDecoration.custom,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                onSubmit: (text) {
                  otpValue = text;
                },
                onChange: (text) {},
              ),
              SizedBox(height: 20.h),
              ElevatedButton(
                onPressed: () async {
                  isLoading.update((state) => true);
                  final body = VerifyOtpBodyModel(otp: otpValue);
                  try {
                    final serivce = APIStateNetwork(createDio());
                    final response = await serivce.verifyOTP(body);
                    if (response.success == true) {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => ChangePasswordPage(
                            resetToken: response.resetToken,
                          ),
                        ),
                      );
                      showSuccessMessage(context, response.message);
                    }
                    isLoading.update((state) => false);
                  } catch (e) {
                    isLoading.update((state) => false);
                    log(e.toString());
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF001E6C),
                  minimumSize: Size(400.w, 52.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.r),
                  ),
                ),
                child: loadingProvider
                    ? Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      )
                    : Text(
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
