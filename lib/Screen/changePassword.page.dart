import 'package:eduma_app/Screen/login.page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Padding(
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
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(builder: (context) => LoginPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF001E6C),
                minimumSize: Size(400.w, 52.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40.r),
                ),
              ),
              child: Text(
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
    );
  }
}
