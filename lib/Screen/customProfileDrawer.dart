import 'dart:io';

import 'package:eduma_app/Screen/cart.page.dart';
import 'package:eduma_app/Screen/course.page.dart';
import 'package:eduma_app/Screen/editProfile.page.dart';
import 'package:eduma_app/Screen/library.page.dart';
import 'package:eduma_app/Screen/onbording.page.dart';
import 'package:eduma_app/Screen/orderList.page.dart';
import 'package:eduma_app/Screen/paymentOverfiew.page.dart';
import 'package:eduma_app/Screen/wishlist.page.dart';
import 'package:eduma_app/data/Controller/profileController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';

class CustomProfileDrawer extends ConsumerStatefulWidget {
  const CustomProfileDrawer({super.key});

  @override
  ConsumerState<CustomProfileDrawer> createState() =>
      _CustomProfileDrawerState();
}

class _CustomProfileDrawerState extends ConsumerState<CustomProfileDrawer> {
  bool isCheck = false;

  @override
  Widget build(BuildContext context) {
    var box = Hive.box("userBox");
    final profileProvider = ref.watch(profileController);
    return Padding(
      padding: EdgeInsets.all(15),
      child: Container(
        width: 315.w,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          color: Colors.white,
        ),
        child: profileProvider.when(
          data: (profile) {
            return Column(
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
                              // image: DecorationImage(
                              //   image: NetworkImage(
                              //     //"assets/annu.png",
                              //     profile.avatar.toString()
                              //   ),
                              // ),
                            ),
                            child: ClipOval(
                              child:
                                  profile.avatar != null &&
                                      profile.avatar.toString().isNotEmpty
                                  ? (profile.avatar.toString().startsWith(
                                          "/data",
                                        )
                                        // Agar local path hai (device ka path)
                                        ? Image.file(
                                            File(profile.avatar.toString()),
                                            fit: BoxFit.cover,
                                          )
                                        // Agar server se relative path mila hai
                                        : Image.network(
                                            "https://yourdomain.com${profile.avatar.toString()}",
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                                  return Image.network(
                                                    "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png",
                                                    fit: BoxFit.cover,
                                                  );
                                                },
                                          ))
                                  : Image.network(
                                      "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png",
                                      fit: BoxFit.cover,
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
                              ).then((_) {
                                // ✅ Back aane ke baad refresh
                                ref.refresh(profileController);
                              });
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
                          // "Annu Agarwal",
                          // box.get("storeName").toString(),
                          profile.username.toString(),
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
                          // "AnnuAgarwal.gmail.com",
                          // box.get("userEmail").toString(),
                          profile.email.toString(),
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
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => LibraryPage(),
                            ),
                          );
                        },
                        child: tileBuild("assets/lib.png", "Library"),
                      ),
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
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => CartPage(),
                            ),
                          );
                        },
                        child: tileBuild("assets/ca.png", "Cart"),
                      ),
                      SizedBox(height: 20.h),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => WishlistPage(),
                            ),
                          );
                        },
                        child: tileBuild("assets/wishlist.png", "Wishlist"),
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
                  onTap: () {
                    box.clear();
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Logout Successfull"),
                        backgroundColor: Colors.red,
                      ),
                    );
                    Navigator.pushAndRemoveUntil(
                      context,
                      CupertinoPageRoute(builder: (context) => OnbordingPage()),
                      (route) => false,
                    );
                  },
                  child: SizedBox(
                    child: Row(
                      children: [
                        SizedBox(width: 20.w),
                        Icon(
                          Icons.logout,
                          color: Color(0xFF001E6C),
                          size: 24.sp,
                        ),
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
            );
          },
          error: (error, stackTrace) {
            return Center(child: Text(error.toString()));
          },
          loading: () => Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }

  Widget tileBuild(String image, String name) {
    return Row(
      children: [
        Image.asset(image, color: Color(0xFF001E6C)),
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
