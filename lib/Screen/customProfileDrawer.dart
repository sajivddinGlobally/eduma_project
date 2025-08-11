import 'package:eduma_app/Screen/editProfile.page.dart';
import 'package:eduma_app/Screen/orderList.page.dart';
import 'package:eduma_app/Screen/paymentOverfiew.page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomProfileDrawer extends StatefulWidget {
  const CustomProfileDrawer({super.key});

  @override
  State<CustomProfileDrawer> createState() => _CustomProfileDrawerState();
}

class _CustomProfileDrawerState extends State<CustomProfileDrawer> {
  bool isCheck = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Container(
        width: 315.w,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              height: 230.h,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.r),
                  topRight: Radius.circular(15.r),
                ),
                color: Color(0xFF001E6C),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 40.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 12.w),
                          width: 37.w,
                          height: 37.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFF19347A),
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
                        "Profile",
                        style: GoogleFonts.poppins(
                          fontSize: 26.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 45.h),
                  Row(
                    children: [
                      SizedBox(width: 12.w),
                      Container(
                        width: 45.h,
                        height: 45.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage("assets/annu.png"),
                          ),
                        ),
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => EditProfilePage(),
                            ),
                          );
                        },
                        child: Container(
                          width: 88.w,
                          height: 34.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40.r),
                            color: Colors.white,
                          ),
                          child: Center(
                            child: Text(
                              "Edit Profile",
                              style: GoogleFonts.roboto(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF001E6C),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 19.w),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Padding(
                    padding: EdgeInsets.only(left: 12.w),
                    child: Text(
                      "Annu Agarwal",
                      style: GoogleFonts.roboto(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 12.w),
                    child: Text(
                      "AnnuAgarwal.gmail.com",
                      style: GoogleFonts.roboto(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: Color.fromARGB(127, 255, 255, 255),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Body
            Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => PaymentOverfiewPage(),
                        ),
                      );
                    },
                    child: tileBuild("assets/pay.png", "Payment Method"),
                  ),
                  SizedBox(height: 20.h),
                  tileBuild("assets/help.png", "Help Centerd"),
                  SizedBox(height: 20.h),
                  tileBuild("assets/invite.png", "Invite Friend"),
                  SizedBox(height: 20.h),
                  tileBuild("assets/lib.png", "Library"),
                  SizedBox(height: 20.h),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => OrderListPage(),
                        ),
                      );
                    },
                    child: tileBuild("assets/or.png", "Order List"),
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      Image.asset("assets/lan.png"),
                      SizedBox(width: 10.w),
                      Text(
                        "Language",
                        style: GoogleFonts.roboto(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF001E6C),
                        ),
                      ),
                      Spacer(),
                      Text(
                        "English",
                        style: GoogleFonts.roboto(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(150, 0, 30, 108),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      Icon(
                        Icons.notifications_none,
                        color: Color(0xFF001E6C),
                        size: 24.sp,
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        "Notification",
                        style: GoogleFonts.roboto(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF001E6C),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      Icon(
                        Icons.dark_mode_outlined,
                        color: Color(0xFF001E6C),
                        size: 24.sp,
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        "Dark Mode",
                        style: GoogleFonts.roboto(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF001E6C),
                        ),
                      ),
                      Spacer(),
                      SizedBox(
                        height: 28.h,
                        child: Transform.scale(
                          scale: 0.7,
                          child: Switch(
                            value: isCheck,
                            onChanged: (value) {
                              setState(() {
                                isCheck = value;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      Icon(
                        Icons.settings,
                        color: Color(0xFF001E6C),
                        size: 24.sp,
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        "Setting",
                        style: GoogleFonts.roboto(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF001E6C),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Spacer(),
            Divider(),
            InkWell(
              onTap: () {},
              child: SizedBox(
                child: Row(
                  children: [
                    SizedBox(width: 20.w),
                    Icon(Icons.logout, color: Color(0xFF001E6C), size: 24.sp),
                    SizedBox(width: 10.w),
                    Text(
                      "Logout",
                      style: GoogleFonts.roboto(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF001E6C),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Widget tileBuild(String image, String name) {
    return Row(
      children: [
        Image.asset(image),
        SizedBox(width: 10.w),
        Text(
          name,
          style: GoogleFonts.roboto(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: Color(0xFF001E6C),
          ),
        ),
        Spacer(),
        Icon(Icons.arrow_forward_ios, color: Color(0xFF001E6C), size: 24.sp),
      ],
    );
  }
}
