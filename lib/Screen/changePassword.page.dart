import 'dart:developer';

import 'package:eduma_app/Screen/login.page.dart';
import 'package:eduma_app/config/core/showFlushbar.dart';
import 'package:eduma_app/config/network/api.state.dart';
import 'package:eduma_app/config/utils/pretty.dio.dart';
import 'package:eduma_app/data/Model/resetPassBodyModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ChangePasswordPage extends ConsumerStatefulWidget {
  final String resetToken;
  const ChangePasswordPage({super.key, required this.resetToken});

  @override
  ConsumerState<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends ConsumerState<ChangePasswordPage> {
  final newpasswordController = TextEditingController();
  final confirmedPassController = TextEditingController();
  bool isLoading = false;
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
                  "Confirm Password",
                  style: GoogleFonts.roboto(
                    fontSize: 26.sp,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1B1B1B),
                    letterSpacing: -0.4,
                  ),
                ),
              ),
              SizedBox(height: 15.h),
              Text(
                "New Password",
                style: GoogleFonts.roboto(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff4D4D4D),
                ),
              ),
              SizedBox(height: 12.h),
              TextField(
                controller: newpasswordController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(
                    left: 19.w,
                    right: 10.w,
                    top: 15.h,
                    bottom: 15.h,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40.r),
                    borderSide: BorderSide(
                      color: Color.fromARGB(25, 0, 0, 0),
                      width: 1.w,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40.r),
                    borderSide: BorderSide(
                      color: Color.fromARGB(25, 0, 0, 0),
                      width: 1.w,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15.h),
              Text(
                "Confirmed Password",
                style: GoogleFonts.roboto(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff4D4D4D),
                ),
              ),
              SizedBox(height: 12.h),
              TextField(
                controller: confirmedPassController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(
                    left: 19.w,
                    right: 10.w,
                    top: 15.h,
                    bottom: 15.h,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40.r),
                    borderSide: BorderSide(
                      color: Color.fromARGB(25, 0, 0, 0),
                      width: 1.w,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40.r),
                    borderSide: BorderSide(
                      color: Color.fromARGB(25, 0, 0, 0),
                      width: 1.w,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              ElevatedButton(
                onPressed: () async {
                  if (newpasswordController.text.trim().isEmpty ||
                      confirmedPassController.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Please fill in all fields."),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }
                  if (newpasswordController.text.trim() !=
                      confirmedPassController.text.trim()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Password do not match"),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }
                  setState(() {
                    isLoading = true;
                  });

                  final body = ResetPassBodyModel(
                    resetToken: widget.resetToken,
                    newPassword: newpasswordController.text,
                    confirmPassword: confirmedPassController.text,
                  );
                  try {
                    final service = APIStateNetwork(createDio());
                    final response = await service.resetPassword(body);
                    if (response != null) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        CupertinoPageRoute(builder: (context) => LoginPage()),
                        (route) => false,
                      );
                    }
                    showSuccessMessage(context, response.message);
                    setState(() {
                      isLoading = false;
                    });
                  } catch (e) {
                    setState(() {
                      isLoading = false;
                    });
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
                child: isLoading
                    ? Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      )
                    : Text(
                        "Change Password",
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
