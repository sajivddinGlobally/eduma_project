import 'package:eduma_app/Screen/home.page.dart';
import 'package:eduma_app/Screen/login.page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';


class OnbordingPage extends StatefulWidget {
  const OnbordingPage({super.key});

  @override
  State<OnbordingPage> createState() => _OnbordingPageState();
}

class _OnbordingPageState extends State<OnbordingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: Padding(
        padding: EdgeInsets.only(left: 33.w, right: 33.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Center(
              child: Image.asset(
                "assets/logo.png",
                width: 284.w,
                height: 284.h,
              ),
            ),
            SizedBox(height: 100.h),
            Text.rich(
              TextSpan(
                style: GoogleFonts.roboto(
                  fontSize: 40.sp,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff001E6C),
                  letterSpacing: -1,
                  height: 1,
                ),
                children: const [
                  TextSpan(
                    text: "Your Journey to ",
                    style: TextStyle(color: Color(0xFF001E6C)),
                  ),
                  TextSpan(
                    text: "Success ",
                    style: TextStyle(color: Color(0xFFFE4A55)),
                  ),
                  TextSpan(
                    text: "Starts Here",
                    style: TextStyle(color: Color(0xFF001E6C)),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.h),
            SizedBox(
              width: 350.w,
              child: Text(
                textAlign: TextAlign.center,
                "Mentorship, skill development, and career guidance —all in one app.",
                style: GoogleFonts.roboto(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff7F7F7F),
                  letterSpacing: -0.4,
                  height: 1.1,
                ),
              ),
            ),
            SizedBox(height: 86.h),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(builder: (context) => HomePage()),
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
                "Get Started",
                style: GoogleFonts.roboto(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  letterSpacing: -1,
                ),
              ),
            ),
            SizedBox(height: 8.h),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(builder: (context) => LoginPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFE4A55),
                minimumSize: Size(400.w, 52.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40.r),
                ),
              ),
              child: Text(
                "Login to your account",
                style: GoogleFonts.roboto(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  letterSpacing: -1,
                ),
              ),
            ),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }
}
