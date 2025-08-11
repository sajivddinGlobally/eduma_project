import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final nameController = TextEditingController();
  final expController = TextEditingController();
  final fieldController = TextEditingController();
  final skillController = TextEditingController();
  final languageController = TextEditingController();
  final linkedinController = TextEditingController();
  final descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF001E6C),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 31.h),
            Row(
              children: [
                SizedBox(width: 20.w),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 37.w,
                    height: 37.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromARGB(255, 23, 47, 111),
                    ),
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 20.sp,
                    ),
                  ),
                ),
                SizedBox(width: 50.w),
                Text(
                  "Complete your Profile",
                  style: GoogleFonts.roboto(
                    fontSize: 26.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    letterSpacing: -1,
                  ),
                ),
              ],
            ),
            SizedBox(height: 30.h),
            Container(
              height: MediaQuery.of(context).size.height * 2 / 1.7,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.r),
                  topRight: Radius.circular(40.r),
                ),
                color: Colors.white,
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 30.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProfileBody(name: "You are a", controller: nameController),
                    SizedBox(height: 20.h),
                    Text(
                      "Upload Profile",
                      style: GoogleFonts.roboto(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF4D4D4D),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 60.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40.r),
                        border: Border.all(color: Color.fromARGB(25, 0, 0, 0)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 16.w),
                            width: 91.w,
                            height: 35.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.r),
                              color: Color(0xFF001E6C),
                            ),
                            child: Center(
                              child: Text(
                                "Choose File",
                                style: GoogleFonts.roboto(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 16.w),
                            width: 91.w,
                            height: 35.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.r),
                              // color: Color(0xFF001E6C),
                            ),
                            child: Center(
                              child: Text(
                                "Choose File",
                                style: GoogleFonts.roboto(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF37474F),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
                    ProfileBody(
                      name: "Total Experience",
                      controller: expController,
                    ),
                    SizedBox(height: 20.h),
                    ProfileBody(
                      name: "Your Field",
                      controller: fieldController,
                    ),
                    SizedBox(height: 20.h),
                    ProfileBody(name: "Skills", controller: skillController),
                    SizedBox(height: 20.h),
                    ProfileBody(
                      name: "Languages known",
                      controller: languageController,
                    ),
                    SizedBox(height: 20.h),
                    ProfileBody(
                      name: "LinkedIn URL",
                      controller: linkedinController,
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      "About ",
                      style: GoogleFonts.roboto(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF4D4D4D),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    TextFormField(
                      controller: descController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(
                          left: 20.w,
                          right: 10.w,
                          top: 15.h,
                          bottom: 15.h,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40.r),
                          borderSide: BorderSide(
                            color: Color.fromARGB(25, 0, 0, 0),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40.r),
                          borderSide: BorderSide(
                            color: Color.fromARGB(25, 0, 0, 0),
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40.r),
                          borderSide: BorderSide(
                            color: Color.fromARGB(25, 0, 0, 0),
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40.r),
                          borderSide: BorderSide(
                            color: Color.fromARGB(25, 0, 0, 0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30.h),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(400.w, 52.h),
                        backgroundColor: Color(0xFF001E6C),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.r),
                          side: BorderSide.none,
                        ),
                      ),
                      onPressed: () {},
                      child: Text(
                        "Save Profile",
                        style: GoogleFonts.roboto(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileBody extends StatelessWidget {
  final String name;
  final TextEditingController controller;
  const ProfileBody({super.key, required this.name, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: GoogleFonts.roboto(
            fontSize: 13.sp,
            fontWeight: FontWeight.w400,
            color: Color(0xFF4D4D4D),
          ),
        ),
        SizedBox(height: 10.h),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(
              left: 20.w,
              right: 10.w,
              top: 15.h,
              bottom: 15.h,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40.r),
              borderSide: BorderSide(color: Color.fromARGB(25, 0, 0, 0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40.r),
              borderSide: BorderSide(color: Color.fromARGB(25, 0, 0, 0)),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40.r),
              borderSide: BorderSide(color: Color.fromARGB(25, 0, 0, 0)),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40.r),
              borderSide: BorderSide(color: Color.fromARGB(25, 0, 0, 0)),
            ),
          ),
        ),
      ],
    );
  }
}
