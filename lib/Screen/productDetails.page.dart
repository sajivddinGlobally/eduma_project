// import 'dart:developer';
// import 'package:eduma_app/Screen/cart.page.dart';
// import 'package:eduma_app/config/network/api.state.dart';
// import 'package:eduma_app/config/utils/pretty.dio.dart';
// import 'package:eduma_app/data/Controller/productDetailsController.dart';
// import 'package:eduma_app/data/Model/addCartBodyModel.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';

// class ProductDetailsPage extends ConsumerStatefulWidget {
//   final String id;
//   const ProductDetailsPage({super.key, required this.id});

//   @override
//   ConsumerState<ProductDetailsPage> createState() => _ProductDetailsPageState();
// }

// class _ProductDetailsPageState extends ConsumerState<ProductDetailsPage> {
//   bool isLoading = false;
//   @override
//   Widget build(BuildContext context) {
//     final productDetaisProvider = ref.watch(
//       productDetailsController(widget.id),
//     );
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
//           productDetaisProvider.when(
//             data: (data) {
//               return Padding(
//                 padding: EdgeInsets.only(left: 20.w, right: 20.w),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(height: 33.h),
//                     Row(
//                       children: [
//                         Container(
//                           width: 37.w,
//                           height: 37.h,
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: Color.fromARGB(25, 0, 0, 0),
//                           ),
//                           child: IconButton(
//                             style: IconButton.styleFrom(
//                               minimumSize: Size(0, 0),
//                               padding: EdgeInsets.zero,
//                               tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                             ),
//                             onPressed: () {
//                               Navigator.pop(context);
//                             },
//                             icon: Icon(
//                               Icons.arrow_back,
//                               color: Color(0xFF001E6C),
//                               size: 20.sp,
//                             ),
//                           ),
//                         ),
//                         SizedBox(width: 50.w),
//                         Text(
//                           "Product Details",
//                           style: GoogleFonts.roboto(
//                             fontSize: 26.sp,
//                             fontWeight: FontWeight.w700,
//                             color: Color(0xFF1B1B1B),
//                             letterSpacing: -0.4,
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 30.h),
//                     ClipRRect(
//                       borderRadius: BorderRadius.circular(10.r),
//                       child: Image.network(
//                         data.images.isNotEmpty
//                             ? data.images[0].thumbnail.toString()
//                             : "https://via.placeholder.com/300x200.png?text=No+Image",
//                         width: MediaQuery.of(context).size.width,
//                         height: 198.h,
//                         fit: BoxFit.cover,
//                         errorBuilder: (context, error, stackTrace) {
//                           return Image.network(
//                             "https://via.placeholder.com/300x200.png?text=No+Image",
//                             width: MediaQuery.of(context).size.width,
//                             height: 198.h,
//                             fit: BoxFit.cover,
//                           );
//                         },
//                       ),
//                     ),

//                     SizedBox(height: 10.h),
//                     Row(
//                       children: [
//                         Text(
//                           //  "Create an LMS Website With LearnPress",
//                           data.name.toString(),
//                           style: GoogleFonts.roboto(
//                             fontSize: 16.sp,
//                             fontWeight: FontWeight.w500,
//                             color: Color(0xFF000000),
//                             letterSpacing: -0.4,
//                           ),
//                         ),
//                         Spacer(),
//                         Container(
//                           // padding: EdgeInsets.only(
//                           //   left: 8.w,
//                           //   right: 8.w,
//                           //   top: 6.h,
//                           //   bottom: 6.h,
//                           // ),
//                           width: 80.w,
//                           height: 36.h,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10.r),
//                             color: Color(0xFF001E6C),
//                           ),
//                           child: TextButton(
//                             style: IconButton.styleFrom(
//                               minimumSize: Size(0, 0),
//                               padding: EdgeInsets.zero,
//                               tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                             ),
//                             onPressed: () async {
//                               final body = ProductAddCartBodyModel(
//                                 productId: data.id,
//                                 quantity: 1,
//                               );

//                               setState(() {
//                                 isLoading = true;
//                               });

//                               try {
//                                 final service = APIStateNetwork(createDio());
//                                 final response = await service.addToCart(body);

//                                 if (response.success == true) {
//                                   setState(() {
//                                     isLoading = false;
//                                   });

//                                   await showDialog(
//                                     context: context,
//                                     builder: (context) {
//                                       return AlertDialog(
//                                         shape: RoundedRectangleBorder(
//                                           borderRadius: BorderRadius.circular(
//                                             16,
//                                           ),
//                                         ),
//                                         title: Row(
//                                           children: [
//                                             Icon(
//                                               Icons.check_circle,
//                                               color: Colors.green,
//                                               size: 28,
//                                             ),
//                                             SizedBox(width: 8),
//                                             Text(
//                                               "Success",
//                                               style: GoogleFonts.roboto(
//                                                 fontSize: 18.sp,
//                                                 fontWeight: FontWeight.w600,
//                                                 color: Colors.black87,
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                         content: Column(
//                                           mainAxisSize: MainAxisSize.min,
//                                           children: [
//                                             Text(
//                                               response.message,
//                                               textAlign: TextAlign.center,
//                                               style: GoogleFonts.roboto(
//                                                 fontSize: 14.sp,
//                                                 fontWeight: FontWeight.w400,
//                                                 color: Colors.black54,
//                                               ),
//                                             ),
//                                             SizedBox(height: 12),
//                                             Icon(
//                                               Icons.shopping_cart,
//                                               color: Color(0xFF001E6C),
//                                               size: 40,
//                                             ),
//                                           ],
//                                         ),
//                                         actionsAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         actions: [
//                                           TextButton(
//                                             onPressed: () {
//                                               Navigator.pop(context);
//                                             },
//                                             style: TextButton.styleFrom(
//                                               foregroundColor: Colors.redAccent,
//                                             ),
//                                             child: Text(
//                                               "Close",
//                                               style: GoogleFonts.roboto(
//                                                 fontWeight: FontWeight.w500,
//                                               ),
//                                             ),
//                                           ),
//                                           ElevatedButton(
//                                             style: ElevatedButton.styleFrom(
//                                               backgroundColor: Color(
//                                                 0xFF001E6C,
//                                               ),
//                                               shape: RoundedRectangleBorder(
//                                                 borderRadius:
//                                                     BorderRadius.circular(8),
//                                               ),
//                                             ),
//                                             onPressed: () {
//                                               Navigator.pushAndRemoveUntil(
//                                                 context,
//                                                 CupertinoPageRoute(
//                                                   builder: (_) =>
//                                                       const CartPage(),
//                                                   settings: const RouteSettings(
//                                                     name: "CartPage",
//                                                   ),
//                                                 ),
//                                                 (route) => route.isFirst,
//                                               );
//                                             },
//                                             child: Text(
//                                               "Go to Cart",
//                                               style: GoogleFonts.roboto(
//                                                 fontWeight: FontWeight.w500,
//                                                 color: Colors.white,
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       );
//                                     },
//                                   );
//                                 } else {
//                                   setState(() {
//                                     isLoading = false;
//                                   });
//                                 }
//                               } catch (e) {
//                                 setState(() {
//                                   isLoading = false;
//                                 });
//                                 log(e.toString());
//                               }
//                             },
//                             child: isLoading
//                                 ? SizedBox(
//                                     width: 20.w,
//                                     height: 20.h,
//                                     child: Center(
//                                       child: CircularProgressIndicator(
//                                         color: Colors.white,
//                                       ),
//                                     ),
//                                   )
//                                 : Text(
//                                     "Add to Cart",
//                                     style: GoogleFonts.roboto(
//                                       fontSize: 12.sp,
//                                       fontWeight: FontWeight.w500,
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 10.h),
//                     Text(
//                       "Product description",
//                       style: GoogleFonts.roboto(
//                         fontSize: 18.sp,
//                         fontWeight: FontWeight.w600,
//                         color: Color(0xFF000000),
//                       ),
//                     ),
//                     SizedBox(height: 10.h),
//                     Text(
//                       // "The 25th Workshop based on Treasure of Treatise -18 is a deep dive into the ancient scriptures and texts, uncovering hidden gems of knowledge and wisdom. Participants will explore the rich heritage of ancient treatises and unlock valuable insights for personal growth and development.",
//                       data.description.toString(),
//                       style: GoogleFonts.roboto(
//                         fontSize: 14.sp,
//                         fontWeight: FontWeight.w400,
//                         color: Color(0xFF000000),
//                         letterSpacing: -1,
//                       ),
//                     ),
//                     SizedBox(height: 10.h),
//                     Row(
//                       children: [
//                         Text(
//                           "₹ 45k",

//                           style: GoogleFonts.roboto(
//                             fontSize: 15.sp,
//                             fontWeight: FontWeight.w400,
//                             color: Color(0xFF001E6C),
//                           ),
//                         ),
//                         SizedBox(width: 10.h),
//                         Text(
//                           "24% off",
//                           style: GoogleFonts.roboto(
//                             fontSize: 15.sp,
//                             fontWeight: FontWeight.w400,
//                             color: Color(0xFF1BB93D),
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 13.h),
//                     Row(
//                       children: [
//                         Text(
//                           "₹ 50k",
//                           style: GoogleFonts.roboto(
//                             fontSize: 15.sp,
//                             fontWeight: FontWeight.w400,
//                             color: Color(0xFF001E6C),
//                             decoration: TextDecoration.lineThrough,
//                             decorationThickness: 2,
//                           ),
//                         ),
//                         SizedBox(width: 10.h),
//                         Text(
//                           "MRP",
//                           style: GoogleFonts.roboto(
//                             fontSize: 15.sp,
//                             fontWeight: FontWeight.w400,
//                             color: Color(0xFF000000),
//                           ),
//                         ),
//                         SizedBox(width: 10.h),
//                         Text(
//                           "(incl. off all texes)",
//                           style: GoogleFonts.roboto(
//                             fontSize: 15.sp,
//                             fontWeight: FontWeight.w400,
//                             color: Color(0xFFA49F9F),
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 30.h),
//                     SizedBox(height: 10.h),
//                     Text(
//                       "shipping policy",
//                       style: GoogleFonts.roboto(
//                         fontSize: 18.sp,
//                         fontWeight: FontWeight.w600,
//                         color: Color(0xFF000000),
//                       ),
//                     ),
//                     SizedBox(height: 10.h),
//                     Text(
//                       // "shipping_policy",
//                       data.wcfmProductPolicyData.shippingPolicy.toString(),
//                       style: GoogleFonts.roboto(
//                         fontSize: 14.sp,
//                         fontWeight: FontWeight.w400,
//                         color: Color(0xFF000000),
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             },
//             error: (error, stackTrace) => Center(child: Text(error.toString())),
//             loading: () => Center(child: CircularProgressIndicator()),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'dart:developer';
import 'package:eduma_app/Screen/cart.page.dart';
import 'package:eduma_app/Screen/login.page.dart';
import 'package:eduma_app/config/core/showFlushbar.dart';
import 'package:eduma_app/config/network/api.state.dart';
import 'package:eduma_app/config/utils/pretty.dio.dart';
import 'package:eduma_app/data/Controller/productDetailsController.dart';
import 'package:eduma_app/data/Model/addCartBodyModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductDetailsPage extends ConsumerStatefulWidget {
  final String id;
  const ProductDetailsPage({super.key, required this.id});

  @override
  ConsumerState<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends ConsumerState<ProductDetailsPage> {
  final PageController _pageController = PageController();
  bool isLoading = false;
  int quantity = 1;

  int currentIndex = 0;
  PageController _controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    var box = Hive.box("userBox");
    var token = box.get("token");
    final productDetailsProvider = ref.watch(
      productDetailsController(widget.id),
    );
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF001E6C)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Product Details",
          style: GoogleFonts.roboto(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1B1B1B),
          ),
        ),
        actions: [
          // IconButton(
          //   icon: Icon(Icons.share, color: Color(0xFF001E6C)),
          //   onPressed: () {},
          // ),
        ],
      ),
      body: productDetailsProvider.when(
        data: (data) => Stack(
          children: [
            Positioned(
              left: -120,
              top: -100.h,
              child: Image.asset(
                "assets/vect.png",
                width: 363.w,
                height: 270.h,
                fit: BoxFit.fitHeight,
              ),
            ),
            Positioned(
              bottom: -40.h,
              left: 0,
              right: 0,
              child: Image.asset(
                "assets/vec.png",
                width: 470.w,
                height: 450.h,
                fit: BoxFit.fill,
              ),
            ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 280.h,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: data.images.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  insetPadding: EdgeInsets.zero,
                                  child: StatefulBuilder(
                                    builder: (context, setState) {
                                      return Stack(
                                        children: [
                                          PhotoViewGallery.builder(
                                            itemCount: data.images.length,
                                            pageController: _controller,
                                            backgroundDecoration:
                                                const BoxDecoration(
                                                  color: Colors.black,
                                                ),
                                            builder: (context, i) {
                                              return PhotoViewGalleryPageOptions(
                                                imageProvider: NetworkImage(
                                                  data.images[i].src,
                                                ),
                                                minScale: PhotoViewComputedScale
                                                    .contained,
                                                maxScale:
                                                    PhotoViewComputedScale
                                                        .covered *
                                                    3,
                                                heroAttributes:
                                                    PhotoViewHeroAttributes(
                                                      tag:
                                                          data.images[i].medium,
                                                    ),
                                              );
                                            },
                                            onPageChanged: (i) {
                                              setState(() {
                                                currentIndex = i;
                                              });
                                            },
                                          ),
                                          Positioned(
                                            top: 20,
                                            left: 10,
                                            right: 10,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                IconButton(
                                                  icon: const Icon(
                                                    Icons.close,
                                                    color: Colors.white,
                                                    size: 28,
                                                  ),
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                ),
                                                Text(
                                                  "${currentIndex + 1} / ${data.images.length}", // 1-based index
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                                SizedBox(width: 48.w),
                                              ],
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                );
                              },
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.only(left: 10.w, right: 10.w),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15.r),
                              child: Image.network(
                                data.images[index].src ??
                                    data.images[index].the2048X2048,
                                fit: BoxFit.fill,
                                width: double.infinity,
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.network(
                                    "https://thumbs.dreamstime.com/b/no-image-vector-symbol-missing-available-icon-gallery-moment-placeholder-246411909.jpg",
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  );
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Center(
                    child: SmoothPageIndicator(
                      controller: _pageController,
                      count: data.images.length,
                      effect: ExpandingDotsEffect(
                        dotHeight: 10.h,
                        dotWidth: 10.w,
                        activeDotColor: Color(0xFF3e64de),
                        dotColor: Colors.grey.shade300,
                        spacing: 6.w,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Padding(
                    padding: EdgeInsets.only(left: 20.w, right: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                //  "Create an LMS Website With LearnPress",
                                data.name.toString(),
                                style: GoogleFonts.roboto(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF000000),
                                  letterSpacing: -0.4,
                                ),
                              ),
                            ),
                            Spacer(),
                            Container(
                              width: 80.w,
                              height: 36.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                color: Color(0xFF3e64de),
                              ),
                              child: TextButton(
                                style: IconButton.styleFrom(
                                  minimumSize: Size(0, 0),
                                  padding: EdgeInsets.zero,
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                onPressed: () async {
                                  if (token == null) {
                                    Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                        builder: (context) => LoginPage(),
                                      ),
                                    );
                                    showSuccessMessage(
                                      context,
                                      "please login first",
                                    );
                                    return;
                                  }
                                  final body = ProductAddCartBodyModel(
                                    productId: data.id,
                                    quantity: 1,
                                  );

                                  setState(() {
                                    isLoading = true;
                                  });

                                  try {
                                    final service = APIStateNetwork(
                                      createDio(),
                                    );
                                    final response = await service.addToCart(
                                      body,
                                    );

                                    if (response.success == true) {
                                      setState(() {
                                        isLoading = false;
                                      });

                                      await showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                            title: Row(
                                              children: [
                                                Icon(
                                                  Icons.check_circle,
                                                  color: Colors.green,
                                                  size: 28,
                                                ),
                                                SizedBox(width: 8),
                                                Text(
                                                  "Success",
                                                  style: GoogleFonts.roboto(
                                                    fontSize: 18.sp,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black87,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  response.message,
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.roboto(
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.black54,
                                                  ),
                                                ),
                                                SizedBox(height: 12),
                                                Icon(
                                                  Icons.shopping_cart,
                                                  color: Color(0xFF001E6C),
                                                  size: 40,
                                                ),
                                              ],
                                            ),
                                            actionsAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                style: TextButton.styleFrom(
                                                  foregroundColor:
                                                      Colors.redAccent,
                                                ),
                                                child: Text(
                                                  "Close",
                                                  style: GoogleFonts.roboto(
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Color(
                                                    0xFF3e64de,
                                                  ),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          8,
                                                        ),
                                                  ),
                                                ),
                                                onPressed: () {
                                                  Navigator.pushAndRemoveUntil(
                                                    context,
                                                    CupertinoPageRoute(
                                                      builder: (_) =>
                                                          const CartPage(),
                                                      settings:
                                                          const RouteSettings(
                                                            name: "CartPage",
                                                          ),
                                                    ),
                                                    (route) => route.isFirst,
                                                  );
                                                },
                                                child: Text(
                                                  "Go to Cart",
                                                  style: GoogleFonts.roboto(
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    } else {
                                      setState(() {
                                        isLoading = false;
                                      });
                                    }
                                  } catch (e) {
                                    setState(() {
                                      isLoading = false;
                                    });
                                    log(e.toString());
                                  }
                                },
                                child: isLoading
                                    ? SizedBox(
                                        width: 20.w,
                                        height: 20.h,
                                        child: Center(
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                    : Text(
                                        "Add to Cart",
                                        style: GoogleFonts.roboto(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                        ),
                                      ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.h),
                        Row(
                          children: [
                            Text(
                              "${data.salePrice ?? '45k'}",
                              style: GoogleFonts.roboto(
                                fontSize: 22.sp,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF001E6C),
                              ),
                            ),
                            // if (data.regularPrice != null)
                            Text(
                              "₹ ${data.price}",
                              style: GoogleFonts.roboto(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF001E6C),
                                //decoration: TextDecoration.lineThrough,
                              ),
                            ),
                            SizedBox(width: 12.w),
                            // if (data.backorders != null)
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.w,
                                vertical: 4.h,
                              ),
                              decoration: BoxDecoration(
                                color: Color(0xFF1BB93D).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(6.r),
                              ),
                              child: Text(
                                "${data.amsPriceToDisplay} % off",
                                style: GoogleFonts.roboto(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF1BB93D),
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 24.h),
                        Text(
                          "Description",
                          style: GoogleFonts.roboto(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1B1B1B),
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          data.description.toString(),
                          style: GoogleFonts.roboto(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey[800],
                            height: 1.5,
                          ),
                        ),

                        SizedBox(height: 20.h),
                        Text(
                          "Category",
                          style: GoogleFonts.roboto(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1B1B1B),
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          data.categories[0].name ?? 'Uncategorized',
                          style: GoogleFonts.roboto(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey[800],
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Text(
                          "Shipping Policy",
                          style: GoogleFonts.roboto(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1B1B1B),
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          data.wcfmProductPolicyData.shippingPolicy.toString(),
                          style: GoogleFonts.roboto(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey[800],
                            height: 1.5,
                          ),
                        ),
                        SizedBox(height: 24.h),
                        Text(
                          "Related Products",
                          style: GoogleFonts.roboto(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1B1B1B),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  SizedBox(
                    height: 180.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: data.images.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(left: 20.w, bottom: 10.h),
                          width: 160.w,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(12.r),
                                ),
                                child: Image.network(
                                  data.images[index].src,
                                  height: 100.h,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.network(
                                      "https://thumbs.dreamstime.com/b/no-image-vector-symbol-missing-available-icon-gallery-moment-placeholder-246411909.jpg",
                                      height: 100.h,
                                      width: double.infinity,
                                      fit: BoxFit.fill,
                                    );
                                  },
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Related Product ${index + 1}",
                                      style: GoogleFonts.roboto(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: 4.h),
                                    Text(
                                      "₹ ${data.price.toString()}",
                                      style: GoogleFonts.roboto(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF001E6C),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 60.h),
                ],
              ),
            ),
          ],
        ),
        error: (error, stackTrace) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, color: Colors.red, size: 48.sp),
              SizedBox(height: 16.h),
              Text(
                "Failed to load product details",
                style: GoogleFonts.roboto(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                error.toString(),
                style: GoogleFonts.roboto(
                  fontSize: 14.sp,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 16.h),
              ElevatedButton(
                onPressed: () =>
                    ref.refresh(productDetailsController(widget.id)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF001E6C),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                child: Text(
                  "Retry",
                  style: GoogleFonts.roboto(
                    fontSize: 14.sp,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        loading: () => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: Color(0xFF001E6C)),
              SizedBox(height: 16.h),
              Text(
                "Loading product details...",
                style: GoogleFonts.roboto(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF3e64de),
          minimumSize: Size(400.w, 55.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        onPressed: () {},
        child: Text(
          "Buy Now",
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
