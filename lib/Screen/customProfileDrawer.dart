import 'dart:developer';
import 'package:eduma_app/Screen/cart.page.dart';
import 'package:eduma_app/Screen/editProfile.page.dart';
import 'package:eduma_app/Screen/login.page.dart';
import 'package:eduma_app/Screen/orderList.page.dart';
import 'package:eduma_app/Screen/wishlist.page.dart';
import 'package:eduma_app/config/auth/firebaseAuth.auth.dart';
import 'package:eduma_app/data/Controller/allCategoryController.dart';
import 'package:eduma_app/data/Controller/enrolleCourseController.dart';
import 'package:eduma_app/data/Controller/latestCourseController.dart';
import 'package:eduma_app/data/Controller/popularCourseController.dart';
import 'package:eduma_app/data/Controller/productListController.dart';
import 'package:eduma_app/data/Controller/profileController.dart';
import 'package:eduma_app/data/Controller/themeModeController.dart';
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
  bool isLogoutLoading = false;

  @override
  Widget build(BuildContext context) {
    var box = Hive.box("userBox");
    final profileProvider = ref.watch(profileController);
    final themeMode = ref.watch(themeNotifierProvider);
    // final authService = AuthService();
    return Padding(
      padding: EdgeInsets.all(15),
      child: Container(
        width: 315.w,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          //color: Colors.white,
          color: Theme.of(context).scaffoldBackgroundColor,
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
                    //color:Theme.of(context).primaryColor
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
                                //color: colors.secondary,
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
                              //color: colors.onPrimary,
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
                            decoration: BoxDecoration(shape: BoxShape.circle),
                            child: ClipOval(
                              child: Image.network(
                                profile.avatarUrl!,
                                fit: BoxFit.cover,
                              ),
                            ),

                            // child: ClipOval(
                            //   child:
                            //       (profile.avatar != null &&
                            //           profile.avatar is String &&
                            //           profile.avatar.toString().isNotEmpty &&
                            //           profile.avatar.toString() != "false")
                            //       ? (profile.avatar.toString().startsWith(
                            //               "/data",
                            //             )
                            //             // Local path (device ke andar)
                            //             ? Image.file(
                            //                 File(profile.avatar.toString()),
                            //                 fit: BoxFit.cover,
                            //               )
                            //             // Server path
                            //             : Image.network(
                            //                 "https://yourdomain.com/${profile.avatar.toString()}",
                            //                 fit: BoxFit.cover,
                            //                 errorBuilder:
                            //                     (context, error, stackTrace) {
                            //                       return Image.network(
                            //                         "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png",
                            //                         fit: BoxFit.cover,
                            //                       );
                            //                     },
                            //               ))
                            //       : Image.network(
                            //           "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png",
                            //           fit: BoxFit.cover,
                            //         ),
                            // ),
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
                          profile.displayName,
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
                      // InkWell(
                      //   onTap: () {
                      //     Navigator.push(
                      //       context,
                      //       CupertinoPageRoute(
                      //         builder: (context) => PaymentOverfiewPage(),
                      //       ),
                      //     );
                      //   },
                      //   child: tileBuild("assets/pay.png", "Payment Method"),
                      // ),
                      // SizedBox(height: 20.h),
                      // tileBuild("assets/help.png", "Help Centerd"),
                      // SizedBox(height: 20.h),
                      // tileBuild("assets/invite.png", "Invite Friend"),
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
                      SizedBox(height: 30.h),
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
                      SizedBox(height: 30.h),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => OrderListPage(),
                            ),
                          );
                        },
                        child: tileBuild("assets/or.png", "My Orders"),
                      ),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
                Spacer(),
                Divider(),
                InkWell(
                  onTap: () async {
                    showDialog(
                      context: context,
                      builder: (context) {
                        bool isLoading = false;

                        return StatefulBuilder(
                          builder: (context, setStateDialog) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              title: const Text("Logout"),
                              content: isLoading
                                  ? SizedBox(
                                      height: 60,
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    )
                                  : const Text(
                                      "Are you sure you want to logout?",
                                    ),
                              actions: isLoading
                                  ? []
                                  : [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text("Cancel"),
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          foregroundColor: Colors.white,
                                          backgroundColor: Colors.red,
                                        ),
                                        onPressed: () async {
                                          setStateDialog(() {
                                            isLoading = true;
                                          });

                                          var box = Hive.box("userBox");

                                          await AuthRepository().signOut();
                                          await box.clear();

                                          final container =
                                              ProviderScope.containerOf(
                                                context,
                                                listen: false,
                                              );

                                          container.invalidate(
                                            popularCourseController,
                                          );
                                          container.invalidate(
                                            allCategoryController,
                                          );
                                          container.invalidate(
                                            latestCourseController,
                                          );
                                          container.invalidate(
                                            productListBooksController,
                                          );
                                          container.invalidate(
                                            enrollCourseController,
                                          );

                                          Navigator.pop(context);

                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                "Logout Successful",
                                              ),
                                              margin: EdgeInsets.all(20),
                                              behavior:
                                                  SnackBarBehavior.floating,
                                              backgroundColor: Colors.red,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20.r),
                                              ),
                                            ),
                                          );

                                          Navigator.pushAndRemoveUntil(
                                            context,
                                            CupertinoPageRoute(
                                              builder: (context) => LoginPage(),
                                            ),
                                            (route) => false,
                                          );
                                          setStateDialog(() {
                                            isLoading = false;
                                          });
                                        },
                                        child: const Text("Logout"),
                                      ),
                                    ],
                            );
                          },
                        );
                      },
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
            log(stackTrace.toString());
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
