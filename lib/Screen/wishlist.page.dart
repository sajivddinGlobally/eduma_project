// import 'dart:developer';
// import 'package:eduma_app/config/core/showFlushbar.dart';
// import 'package:eduma_app/config/network/api.state.dart';
// import 'package:eduma_app/config/utils/pretty.dio.dart';
// import 'package:eduma_app/data/Controller/getWishlistController.dart';
// import 'package:eduma_app/data/Model/wishlistBodyModel.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:hive/hive.dart';

// class WishlistPage extends ConsumerStatefulWidget {
//   const WishlistPage({super.key});

//   @override
//   ConsumerState<WishlistPage> createState() => _WishlistPageState();
// }

// class _WishlistPageState extends ConsumerState<WishlistPage> {
//   List<Map<String, dynamic>> courseList = [
//     {
//       "image": "assets/reading.png",
//       "paid": "Free",
//       "course": "Angular",
//       "courseName": "Angular Course",
//       "time": "10 week",
//     },
//     {
//       "image": "assets/reading2.png",
//       "paid": "₹ 45k",
//       "course": "Css, Teaching Online",
//       "courseName": "introduction learn Press - Lms Plugin",
//       "time": "10 Minutes",
//     },
//   ];
//   @override
//   Widget build(BuildContext context) {
//     var box = Hive.box("userBox");
//     final fetchWishlistProvider = ref.watch(getWishlistController);
//     return Scaffold(
//       backgroundColor: Color(0xFFFFFFFF),
//       body: Stack(
//         children: [
//           Positioned(
//             left: -120,
//             top: -100.h,
//             child: Image.asset(
//               "assets/vect.png",
//               width: 363.w,
//               height: 270.h,
//               fit: BoxFit.fitHeight,
//             ),
//           ),
//           Positioned(
//             bottom: -40.h,
//             left: 0,
//             right: 0,
//             child: Image.asset(
//               "assets/vec.png",
//               width: 470.w,
//               height: 450.h,
//               fit: BoxFit.fill,
//             ),
//           ),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(height: 33.h),
//               Row(
//                 children: [
//                   SizedBox(width: 20.w),
//                   Container(
//                     width: 37.w,
//                     height: 37.h,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: Color.fromARGB(25, 0, 0, 0),
//                     ),
//                     child: IconButton(
//                       style: IconButton.styleFrom(
//                         minimumSize: Size(0, 0),
//                         padding: EdgeInsets.zero,
//                         tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                       ),
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                       icon: Icon(
//                         Icons.arrow_back,
//                         color: Color(0xFF001E6C),
//                         size: 20.sp,
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: 50.w),
//                   Text(
//                     "Wishlist",
//                     style: GoogleFonts.roboto(
//                       fontSize: 26.sp,
//                       fontWeight: FontWeight.w700,
//                       color: Color(0xFF1B1B1B),
//                       letterSpacing: -0.4,
//                     ),
//                   ),
//                 ],
//               ),
//               fetchWishlistProvider.when(
//                 data: (wishlist) {
//                   if (wishlist.items.isEmpty) {
//                     return Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         SizedBox(height: 80.h),
//                         Center(
//                           child: Text(
//                             "No Popular Course Wishlist is Empty",
//                             style: GoogleFonts.roboto(
//                               fontSize: 18.sp,
//                               fontWeight: FontWeight.w400,
//                               color: Colors.grey,
//                             ),
//                           ),
//                         ),
//                       ],
//                     );
//                   }
//                   return Expanded(
//                     child: ListView.builder(
//                       padding: EdgeInsets.zero,
//                       itemCount: wishlist.items.length,
//                       itemBuilder: (context, index) {
//                         return Container(
//                           margin: EdgeInsets.only(
//                             left: 20.w,
//                             right: 20.w,
//                             top: 20.h,
//                           ),
//                           width: 400.w,
//                           //  height: 361.h,
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Stack(
//                                 children: [
//                                   InkWell(
//                                     onTap: () {},
//                                     child: ClipRRect(
//                                       borderRadius: BorderRadius.circular(20.r),
//                                       child: Image.network(
//                                         // courseList[index]['image'].toString(),
//                                         wishlist.items[index].thumbnail,
//                                         width: 400.w,
//                                         height: 200.h,
//                                         fit: BoxFit.cover,
//                                       ),
//                                     ),
//                                   ),
//                                   Align(
//                                     alignment: Alignment.topRight,
//                                     child: IconButton(
//                                       onPressed: () async {
//                                         final body = WishlistBodyModel(
//                                           courseId: wishlist.items[index].id,
//                                           userId: box.get("storeId"),
//                                         );
//                                         try {
//                                           final service = APIStateNetwork(
//                                             createDio(),
//                                           );
//                                           final response = await service
//                                               .deleteWishlist(body);
//                                           if (response != null) {
//                                             showSuccessMessage(
//                                               context,
//                                               response.message,
//                                             );
//                                           }
//                                           // ✅ Pura wishlist provider refresh
//                                           ref.invalidate(getWishlistController);
//                                         } catch (e) {
//                                           log(e.toString());
//                                         }
//                                       },
//                                       icon: Icon(
//                                         Icons.delete,
//                                         color: Colors.red,
//                                         size: 25.sp,
//                                       ),
//                                     ),
//                                   ),
//                                   Positioned(
//                                     left: 25.w,
//                                     bottom: 25.h,
//                                     child: Container(
//                                       padding: EdgeInsets.only(
//                                         left: 16.w,
//                                         right: 16.w,
//                                         top: 6.h,
//                                         bottom: 6.h,
//                                       ),
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(
//                                           7.r,
//                                         ),
//                                         color: Color(0xFF001E6C),
//                                       ),
//                                       child: Text(
//                                         //courseList[index]['paid'].toString(),
//                                         wishlist.items[index].price.toString(),
//                                         style: GoogleFonts.roboto(
//                                           fontSize: 18.sp,
//                                           fontWeight: FontWeight.w500,
//                                           color: Colors.white,
//                                           letterSpacing: -0.4,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               SizedBox(height: 15.h),
//                               Text(
//                                 // courseList[index]['course'].toString(),
//                                 wishlist.items[index].type,
//                                 style: GoogleFonts.roboto(
//                                   fontSize: 18.sp,
//                                   fontWeight: FontWeight.w500,
//                                   color: Color.fromARGB(140, 0, 0, 0),
//                                   letterSpacing: -0.4,
//                                 ),
//                               ),
//                               SizedBox(height: 8.h),
//                               Text(
//                                 //courseList[index]['courseName'].toString(),
//                                 wishlist.items[index].name,
//                                 style: GoogleFonts.roboto(
//                                   fontSize: 24.sp,
//                                   fontWeight: FontWeight.w500,
//                                   color: Color(0xFF001E6C),
//                                   letterSpacing: -0.4,
//                                   height: 1,
//                                 ),
//                               ),
//                               SizedBox(height: 8.h),
//                               // Row(
//                               //   children: [
//                               //     Icon(
//                               //       Icons.access_time,
//                               //       color: Color(0xFFFE4A55),
//                               //     ),
//                               //     SizedBox(width: 8.w),
//                               //     Text(
//                               //       "Durations : ",
//                               //       style: GoogleFonts.roboto(
//                               //         fontSize: 18.sp,
//                               //         fontWeight: FontWeight.w500,
//                               //         color: Color(0xFF000000),
//                               //         letterSpacing: -0.4,
//                               //       ),
//                               //     ),
//                               //     Text(
//                               //       courseList[index]['time'].toString(),
//                               //       style: GoogleFonts.roboto(
//                               //         fontSize: 16.sp,
//                               //         fontWeight: FontWeight.w500,
//                               //         color: Color(0xFF747272),
//                               //         letterSpacing: -0.4,
//                               //       ),
//                               //     ),
//                               //   ],
//                               // ),
//                             ],
//                           ),
//                         );
//                       },
//                     ),
//                   );
//                 },
//                 error: (error, stackTrace) =>
//                     Center(child: Text(error.toString())),
//                 loading: () => SizedBox(
//                   width: MediaQuery.of(context).size.width,
//                   height: MediaQuery.of(context).size.height / 2,
//                   child: Center(child: CircularProgressIndicator()),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'dart:developer';
import 'package:eduma_app/config/core/showFlushbar.dart';
import 'package:eduma_app/config/network/api.state.dart';
import 'package:eduma_app/config/utils/pretty.dio.dart';
import 'package:eduma_app/data/Controller/getWishlistController.dart';
import 'package:eduma_app/data/Controller/productWishlistController.dart';
import 'package:eduma_app/data/Model/productDeleteBodyModel.dart';
import 'package:eduma_app/data/Model/wishlistBodyModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

class WishlistPage extends ConsumerStatefulWidget {
  const WishlistPage({super.key});

  @override
  ConsumerState<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends ConsumerState<WishlistPage> {
  int tab = 0;
  @override
  Widget build(BuildContext context) {
    var box = Hive.box("userBox");
    final fetchWishlistProvider = ref.watch(getWishlistController);
    final productWishlistProvider = ref.watch(productWishlistController);
    return Scaffold(
      backgroundColor: Color(0xFFF5F7FA),
      body: Stack(
        children: [
          Positioned(
            left: -150.w,
            top: -120.h,
            child: Opacity(
              opacity: 0.1,
              child: Image.asset(
                "assets/vect.png",
                width: 400.w,
                height: 300.h,
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          Positioned(
            bottom: -60.h,
            right: -50.w,
            child: Opacity(
              opacity: 0.1,
              child: Image.asset(
                "assets/vec.png",
                width: 500.w,
                height: 480.h,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                child: Row(
                  children: [
                    Container(
                      width: 40.w,
                      height: 40.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8.r,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: IconButton(
                        style: IconButton.styleFrom(
                          minimumSize: Size.zero,
                          padding: EdgeInsets.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(
                          Icons.arrow_back,
                          color: Color(0xFF001E6C),
                          size: 22.sp,
                        ),
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Text(
                      "My Wishlist",
                      style: GoogleFonts.roboto(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF001E6C),
                        letterSpacing: -0.3,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(190.w, 40.h),
                      backgroundColor: tab == 0
                          ? Color(0xFF001E6C)
                          : Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.r),
                          bottomLeft: Radius.circular(10.r),
                        ),
                        side: BorderSide(color: Colors.black),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        tab = 0;
                      });
                    },
                    child: Text(
                      "Course",
                      style: GoogleFonts.roboto(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                        color: tab == 0 ? Colors.white : Color(0xFF001E6C),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(190.w, 40.h),
                      backgroundColor: tab == 1
                          ? Color(0xFF001E6C)
                          : Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10.r),
                          bottomRight: Radius.circular(10.r),
                        ),
                        side: BorderSide(color: Colors.black),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        tab = 1;
                      });
                    },
                    child: Text(
                      "Product",
                      style: GoogleFonts.roboto(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                        color: tab == 1 ? Colors.white : Color(0xFF001E6C),
                      ),
                    ),
                  ),
                ],
              ),
              if (tab == 0)
                Expanded(
                  child: fetchWishlistProvider.when(
                    data: (wishlist) {
                      if (wishlist.items.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.favorite_border,
                                size: 60.sp,
                                color: Colors.grey[400],
                              ),
                              SizedBox(height: 16.h),
                              Text(
                                "Your Wishlist is Empty",
                                style: GoogleFonts.roboto(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey[600],
                                ),
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                "Add courses you love to see them here!",
                                style: GoogleFonts.roboto(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey[500],
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      return ListView.builder(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        itemCount: wishlist.items.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20.w,
                              vertical: 8.h,
                            ),
                            child: Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.r),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                    children: [
                                      InkWell(
                                        onTap: () {},
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(16.r),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(16.r),
                                          ),
                                          child: Image.network(
                                            wishlist.items[index].thumbnail,
                                            width: double.infinity,
                                            height: 180.h,
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (
                                                  context,
                                                  error,
                                                  stackTrace,
                                                ) => Container(
                                                  height: 180.h,
                                                  color: Colors.grey[200],
                                                  child: Icon(
                                                    Icons.image_not_supported,
                                                    size: 50.sp,
                                                  ),
                                                ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        right: 8.w,
                                        top: 8.h,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black12,
                                                blurRadius: 6.r,
                                                offset: Offset(0, 2),
                                              ),
                                            ],
                                          ),
                                          child: IconButton(
                                            onPressed: () async {
                                              final body = WishlistBodyModel(
                                                courseId:
                                                    wishlist.items[index].id,
                                                userId: box.get("storeId"),
                                              );
                                              try {
                                                final service = APIStateNetwork(
                                                  createDio(),
                                                );
                                                final response = await service
                                                    .deleteWishlist(body);
                                                if (response != null) {
                                                  showSuccessMessage(
                                                    context,
                                                    response.message,
                                                  );
                                                }
                                                ref.invalidate(
                                                  getWishlistController,
                                                );
                                              } catch (e) {
                                                log(e.toString());
                                              }
                                            },
                                            icon: Icon(
                                              Icons.delete_outline,
                                              color: Colors.redAccent,
                                              size: 24.sp,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 16.w,
                                        bottom: 16.h,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 12.w,
                                            vertical: 6.h,
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              8.r,
                                            ),
                                            color: Color(0xFF001E6C),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black26,
                                                blurRadius: 4.r,
                                                offset: Offset(0, 2),
                                              ),
                                            ],
                                          ),
                                          child: Text(
                                            wishlist.items[index].price
                                                .toString(),
                                            style: GoogleFonts.roboto(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(16.w),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          wishlist.items[index].type,
                                          style: GoogleFonts.roboto(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                        SizedBox(height: 6.h),
                                        Text(
                                          wishlist.items[index].name,
                                          style: GoogleFonts.roboto(
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFF001E6C),
                                          ),
                                        ),
                                        SizedBox(height: 12.h),
                                        // Row(
                                        //   children: [
                                        //     Icon(
                                        //       Icons.access_time,
                                        //       color: Color(0xFFFE4A55),
                                        //       size: 20.sp,
                                        //     ),
                                        //     SizedBox(width: 8.w),
                                        //     Text(
                                        //       "Duration: ",
                                        //       style: GoogleFonts.roboto(
                                        //         fontSize: 16.sp,
                                        //         fontWeight: FontWeight.w500,
                                        //         color: Colors.black87,
                                        //       ),
                                        //     ),
                                        //     Text(
                                        //       wishlist.items[index]. ?? "N/A",
                                        //       style: GoogleFonts.roboto(
                                        //         fontSize: 16.sp,
                                        //         fontWeight: FontWeight.w400,
                                        //         color: Colors.grey[600],
                                        //       ),
                                        //     ),
                                        //   ],
                                        // ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    error: (error, stackTrace) => Center(
                      child: Text(
                        "Error loading wishlist",
                        style: GoogleFonts.roboto(
                          fontSize: 18.sp,
                          color: Colors.redAccent,
                        ),
                      ),
                    ),
                    loading: () => Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF001E6C),
                      ),
                    ),
                  ),
                ),

              if (tab == 1)
                Expanded(
                  child: productWishlistProvider.when(
                    data: (productwishlist) {
                      if (productwishlist.data.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.favorite_border,
                                size: 60.sp,
                                color: Colors.grey[400],
                              ),
                              SizedBox(height: 16.h),
                              Text(
                                "Your Product Wishlist is Empty",
                                style: GoogleFonts.roboto(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey[600],
                                ),
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                "Add Product you love to see them here!",
                                style: GoogleFonts.roboto(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey[500],
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      return ListView.builder(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        itemCount: productwishlist.data.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20.w,
                              vertical: 8.h,
                            ),
                            child: Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.r),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                    children: [
                                      InkWell(
                                        onTap: () {},
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(16.r),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(16.r),
                                          ),
                                          child: Image.network(
                                            productwishlist.data[index].image,
                                            width: double.infinity,
                                            height: 180.h,
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (
                                                  context,
                                                  error,
                                                  stackTrace,
                                                ) => Container(
                                                  height: 180.h,
                                                  color: Colors.grey[200],
                                                  child: Icon(
                                                    Icons.image_not_supported,
                                                    size: 50.sp,
                                                  ),
                                                ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        right: 8.w,
                                        top: 8.h,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black12,
                                                blurRadius: 6.r,
                                                offset: Offset(0, 2),
                                              ),
                                            ],
                                          ),
                                          child: IconButton(
                                            onPressed: () async {
                                              log(
                                                "Deleting product: ${productwishlist.data[index].id}",
                                              );
                                              try {
                                                final body =
                                                    ProductDeleteBodyModel(
                                                      productId: productwishlist
                                                          .data[index]
                                                          .id,
                                                    );
                                                final service = APIStateNetwork(
                                                  createDio(),
                                                );
                                                final response = await service
                                                    .productDelete(body);
                                                if (response.success == true) {
                                                  showSuccessMessage(
                                                    context,
                                                    response.message,
                                                  );
                                                }
                                                ref.invalidate(
                                                  productWishlistController,
                                                );
                                              } catch (e) {
                                                log(e.toString());
                                              }
                                            },
                                            icon: Icon(
                                              Icons.delete_outline,
                                              color: Colors.redAccent,
                                              size: 24.sp,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 16.w,
                                        bottom: 16.h,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 12.w,
                                            vertical: 6.h,
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              8.r,
                                            ),
                                            color: Color(0xFF001E6C),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black26,
                                                blurRadius: 4.r,
                                                offset: Offset(0, 2),
                                              ),
                                            ],
                                          ),
                                          child: Text(
                                            productwishlist.data[index].price
                                                .toString(),
                                            style: GoogleFonts.roboto(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(16.w),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          productwishlist.data[index].inStock
                                              .toString(),
                                          style: GoogleFonts.roboto(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                        SizedBox(height: 6.h),
                                        Text(
                                          productwishlist.data[index].name,
                                          style: GoogleFonts.roboto(
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFF001E6C),
                                          ),
                                        ),
                                        SizedBox(height: 12.h),
                                        // Row(
                                        //   children: [
                                        //     Icon(
                                        //       Icons.access_time,
                                        //       color: Color(0xFFFE4A55),
                                        //       size: 20.sp,
                                        //     ),
                                        //     SizedBox(width: 8.w),
                                        //     Text(
                                        //       "Duration: ",
                                        //       style: GoogleFonts.roboto(
                                        //         fontSize: 16.sp,
                                        //         fontWeight: FontWeight.w500,
                                        //         color: Colors.black87,
                                        //       ),
                                        //     ),
                                        //     Text(
                                        //       wishlist.items[index]. ?? "N/A",
                                        //       style: GoogleFonts.roboto(
                                        //         fontSize: 16.sp,
                                        //         fontWeight: FontWeight.w400,
                                        //         color: Colors.grey[600],
                                        //       ),
                                        //     ),
                                        //   ],
                                        // ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    error: (error, stackTrace) => Center(
                      child: Text(
                        "Error loading wishlist",
                        style: GoogleFonts.roboto(
                          fontSize: 18.sp,
                          color: Colors.redAccent,
                        ),
                      ),
                    ),
                    loading: () => Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF001E6C),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
