import 'dart:developer';

import 'package:eduma_app/Screen/forgorPassword.page.dart';
import 'package:eduma_app/Screen/home.page.dart';
import 'package:eduma_app/Screen/register.page.dart';
import 'package:eduma_app/config/core/showFlushbar.dart';
import 'package:eduma_app/config/network/api.state.dart';
import 'package:eduma_app/config/utils/pretty.dio.dart';
import 'package:eduma_app/data/Controller/loadingController.dart';
import 'package:eduma_app/data/Model/loginBodyModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  bool isShow = true;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(loadingController);
    final loadingProvider = ref.read(loadingController.notifier);
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
                  "Create Your Login Account",
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
                "User Name",
                style: GoogleFonts.roboto(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff4D4D4D),
                ),
              ),
              SizedBox(height: 12.h),
              TextField(
                controller: emailController,
                obscureText: isShow ? true : false,
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
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isShow = !isShow;
                      });
                    },
                    icon: Icon(
                      isShow
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: Color(0xFF8D8383),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                "Password",
                style: GoogleFonts.roboto(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff4D4D4D),
                ),
              ),
              SizedBox(height: 12.h),
              TextField(
                controller: passwordController,
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
              SizedBox(height: 6.h),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size(0, 0),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => ForgorPasswordPage(),
                      ),
                    );
                  },
                  child: Text(
                    "Forget Your Password",
                    style: GoogleFonts.roboto(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF7F7F7F),
                      letterSpacing: -0.4,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              ElevatedButton(
                onPressed: () async {
                  loadingProvider.state = true;
                  final body = LoginBodyModel(
                    username: emailController.text,
                    password: passwordController.text,
                  );
                  try {
                    final service = APIStateNetwork(createDio());
                    final response = await service.login(body);
                    if (response != null) {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(builder: (context) => HomePage()),
                      );
                      showSuccessMessage(context, "Login SuccessFull");
                      loadingProvider.state = false;
                    } else {
                      showErrorMessage(context, "Invalid credentials");
                      log("Login failed");
                    }
                  } catch (e) {
                    loadingProvider.state = false;
                    showErrorMessage(context, e.toString());
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
                        "Login",
                        style: GoogleFonts.roboto(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          letterSpacing: -1,
                        ),
                      ),
              ),
              SizedBox(height: 6.h),
              Center(
                child: TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero, // Removes default padding
                    minimumSize: Size(0, 0), // Removes default min size
                    tapTargetSize:
                        MaterialTapTargetSize.shrinkWrap, // Shrinks tap area
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(builder: (context) => RegisterPage()),
                    );
                  },
                  child: Text(
                    "Don’t Have account? Sign up",
                    style: GoogleFonts.roboto(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF7F7F7F),
                      letterSpacing: -0.4,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.h),
            ],
          ),
        ),
      ),
    );
  }
}
