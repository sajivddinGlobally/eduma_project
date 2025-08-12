import 'package:eduma_app/Screen/login.page.dart';
import 'package:eduma_app/config/utils/navigatorKey.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isShow = true;
  bool isObsecure = true;
  bool isCheck = false;

  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPassController = TextEditingController();

  void toggleCheckbox() {
    setState(() {
      isCheck = !isCheck;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: navigatorKey,
      child: Scaffold(
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
                SizedBox(height: 20.h),
                Divider(color: Colors.black12, thickness: 1),
                SizedBox(height: 15.h),
                Center(
                  child: Text(
                    "Create an account",
                    style: GoogleFonts.roboto(
                      fontSize: 26.sp,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1B1B1B),
                      letterSpacing: -0.4,
                    ),
                  ),
                ),
                SizedBox(height: 25.h),
                Text(
                  "User Name",
                  style: GoogleFonts.roboto(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff4D4D4D),
                  ),
                ),
                SizedBox(height: 12.h),
                TextFormField(
                  controller: userNameController,
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "User Name is required";
                    }
                    if (!RegExp(r'^[a-zA-Z0-9_ ]+$').hasMatch(value)) {
                      return "Only letters, numbers, and spaces allowed";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.h),
                Text(
                  "Email",
                  style: GoogleFonts.roboto(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff4D4D4D),
                  ),
                ),
                SizedBox(height: 12.h),
                TextFormField(
                  controller: emailController,
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Email is required";
                    }

                    String pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
                    RegExp regex = RegExp(pattern);
                    if (!regex.hasMatch(value.trim())) {
                      return "Enter a valid email";
                    }
                    return null;
                  },
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
                TextFormField(
                  controller: passwordController,
                  obscureText: isObsecure ? true : false,
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
                          isObsecure = !isObsecure;
                        });
                      },
                      icon: Icon(
                        isObsecure
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: Color(0xFF8D8383),
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password is required";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.h),
                Text(
                  "Confirm Password",
                  style: GoogleFonts.roboto(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff4D4D4D),
                  ),
                ),
                SizedBox(height: 12.h),
                TextFormField(
                  controller: confirmPassController,
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Confirmed Password is required";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15.h),
                InkWell(
                  onTap: toggleCheckbox,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 30.w,
                        height: 25.h,
                        child: Transform.scale(
                          scale: 0.8,
                          child: Checkbox(
                            value: isCheck,
                            onChanged: (value) {
                              toggleCheckbox();
                            },
                          ),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        "i agree to the terms and conditions Agreement",
                        style: GoogleFonts.roboto(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF7F7F7F),
                          letterSpacing: -0.4,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 25.h),
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
                    "Sign Up",
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
      ),
    );
  }
}
