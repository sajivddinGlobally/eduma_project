import 'dart:developer';
import 'package:eduma_app/Screen/cart.page.dart';
import 'package:eduma_app/Screen/login.page.dart';
import 'package:eduma_app/config/core/showFlushbar.dart';
import 'package:eduma_app/config/network/api.state.dart';
import 'package:eduma_app/config/utils/pretty.dio.dart';
import 'package:eduma_app/data/Controller/productDetailsController.dart';
import 'package:eduma_app/data/Controller/relatedProductController.dart';
import 'package:eduma_app/data/Controller/variationProductController.dart';
import 'package:eduma_app/data/Model/addCartBodyModel.dart';
import 'package:eduma_app/data/Model/variationResModel.dart' hide Image;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';
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
  String selectedLang = "en";
  List<VariationResModel> variation = [];
  void initData() async {
    final service = APIStateNetwork(createWooCommerceDio());
    variation = await service.variationProduct(widget.id);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initData();
  }

  String landKaImage = "";
  void setImage() {
    for (final v in variation) {
      if (v.attributes[0].option.toLowerCase().contains(selectedLang)) {
        setState(() {
          landKaImage = v.image.src;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var box = Hive.box("userBox");
    var token = box.get("token");
    final productDetailsProvider = ref.watch(
      productDetailsController(widget.id),
    );
    final related = ref.watch(relatedProductController(widget.id));
    // final variationProductProvider = ref.watch(
    //   variationProductController(widget.id),
    // );
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
      ),
      body: productDetailsProvider.when(
        data: (data) {
          return Stack(
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
                    if (landKaImage.trim().isEmpty) ...[
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
                                                    minScale:
                                                        PhotoViewComputedScale
                                                            .contained,
                                                    maxScale:
                                                        PhotoViewComputedScale
                                                            .covered *
                                                        3,
                                                    heroAttributes:
                                                        PhotoViewHeroAttributes(
                                                          tag: data
                                                              .images[i]
                                                              .medium,
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
                                                          Navigator.pop(
                                                            context,
                                                          ),
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
                                padding: EdgeInsets.only(
                                  left: 10.w,
                                  right: 10.w,
                                ),
                                child: Stack(
                                  children: [
                                    // SizedBox(
                                    //   height: 280.h,
                                    //   child: variationProductProvider.when(
                                    //     data: (variationData) {
                                    //       final List<dynamic> imagesToShow =
                                    //           variationData.isNotEmpty
                                    //           ? variationData
                                    //           : data.images;
                                    //       return ListView.builder(
                                    //         padding: EdgeInsets.zero,
                                    //         itemCount: imagesToShow.length,
                                    //         scrollDirection: Axis.horizontal,
                                    //         itemBuilder: (context, index) {
                                    //           String imageUrl = "";
                                    //           if (variationData.isNotEmpty) {
                                    //             final variationItem =
                                    //                 variationData[index];
                                    //             imageUrl = selectedLang == "en"
                                    //                 ? (variationItem.image.src ??
                                    //                       "")
                                    //                 : (variationItem.image.src ??
                                    //                       "");
                                    //           } else {
                                    //             final productImage =
                                    //                 data.images[index];
                                    //             imageUrl = productImage.src ?? "";
                                    //           }
                                    //           return Padding(
                                    //             padding: EdgeInsets.only(
                                    //               left: 10.w,
                                    //               right: 10.w,
                                    //             ),
                                    //             child: ClipRRect(
                                    //               borderRadius:
                                    //                   BorderRadius.circular(15.r),
                                    //               child: Image.network(
                                    //                 imageUrl.isNotEmpty
                                    //                     ? imageUrl
                                    //                     : "https://via.placeholder.com/300x200.png?text=No+Image", // default placeholder अगर image empty
                                    //                 height: 260.h,
                                    //                 width: 360.w,
                                    //                 fit: BoxFit.cover,
                                    //                 errorBuilder:
                                    //                     (
                                    //                       context,
                                    //                       error,
                                    //                       stackTrace,
                                    //                     ) {
                                    //                       return Image.network(
                                    //                         "https://static.vecteezy.com/system/resources/thumbnails/048/910/778/small/default-image-missing-placeholder-free-vector.jpg",
                                    //                         width: 400.w,
                                    //                         height: 260.h,
                                    //                         fit: BoxFit.cover,
                                    //                       );
                                    //                     },
                                    //               ),
                                    //             ),
                                    //           );
                                    //         },
                                    //       );
                                    //     },
                                    //     error: (error, stackTrace) {
                                    //       // Error case: log करें और error message दिखाएँ
                                    //       log(stackTrace.toString());
                                    //       return Center(
                                    //         child: Text(
                                    //           error.toString(),
                                    //           style: TextStyle(
                                    //             color: Colors.red,
                                    //           ), // red color में error text
                                    //         ),
                                    //       );
                                    //     },
                                    //     loading: () => const Center(
                                    //       child:
                                    //           CircularProgressIndicator(), // loading spinner
                                    //     ),
                                    //   ),
                                    // ),
                                    if (landKaImage.isEmpty) ...[
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                          15.r,
                                        ),
                                        child: Image.network(
                                          data.images[index].src,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                                return Image.network(
                                                  "https://thumbs.dreamstime.com/b/no-image-vector-symbol-missing-available-icon-gallery-moment-placeholder-246411909.jpg",
                                                  width: double.infinity,
                                                  fit: BoxFit.cover,
                                                );
                                              },
                                        ),
                                      ),
                                    ] else ...[
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                          15.r,
                                        ),
                                        child: Image.network(
                                          landKaImage,
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                                return Image.network(
                                                  "https://thumbs.dreamstime.com/b/no-image-vector-symbol-missing-available-icon-gallery-moment-placeholder-246411909.jpg",
                                                  fit: BoxFit.cover,
                                                  width: double.infinity,
                                                );
                                              },
                                        ),
                                      ),
                                    ],

                                    Positioned(
                                      top: 10.h,
                                      right: 5,
                                      child: IconButton(
                                        style: IconButton.styleFrom(
                                          backgroundColor: Color(0xFF3e64de),
                                        ),
                                        onPressed: () {
                                          // Use permalink from API response
                                          final String shareUrl =
                                              data.permalink;
                                          final String shareText =
                                              '''
      📚 ${data.name}
      ${data.description}
      👉 Check out this course:
      $shareUrl
      ''';
                                          Share.share(
                                            shareText,
                                            subject: "Check out this course!",
                                          );
                                        },
                                        icon: Icon(
                                          Icons.share,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ] else ...[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15.r),
                        child: Image.network(
                          landKaImage,
                          fit: BoxFit.cover,
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
                    ],

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
                              DropdownButton<String>(
                                value: selectedLang,
                                underline: const SizedBox(),
                                padding: EdgeInsets.zero,
                                icon: const Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.black,
                                ),
                                items: const [
                                  DropdownMenuItem(
                                    value: "en",
                                    child: Text("English"),
                                  ),
                                  DropdownMenuItem(
                                    value: "hi",
                                    child: Text("Hindi"),
                                  ),
                                ],
                                onChanged: (value) {
                                  log("start=============================");
                                  setState(() {
                                    selectedLang = value!;
                                  });
                                  setImage();
                                },
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
                          Container(
                            //   color: Colors.yellow,
                            child: Html(data: data.description.toString()),
                          ),
                          SizedBox(height: 18.h),
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
                          Html(
                            data: data.wcfmProductPolicyData.shippingPolicy
                                .toString(),
                            style: {
                              "body": Style(
                                fontSize: FontSize(14.sp),
                                fontWeight: FontWeight.w400,
                                color: Colors.grey[800],
                                lineHeight: LineHeight(1.5),
                                fontFamily: GoogleFonts.roboto().fontFamily,
                              ),
                            },
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
                    related.when(
                      data: (data) {
                        return SizedBox(
                          height: 180.h,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                      builder: (context) => ProductDetailsPage(
                                        id: data[index].id.toString(),
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                    left: 20.w,
                                    bottom: 10.h,
                                  ),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(12.r),
                                        ),
                                        child: Image.network(
                                          data[index].image,
                                          height: 100.h,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) {
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: 160.w,
                                              child: Text(
                                                data[index].name,
                                                style: GoogleFonts.roboto(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            SizedBox(height: 4.h),
                                            Text(
                                              "₹ ${data[index].price.toString()}",
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
                                ),
                              );
                            },
                          ),
                        );
                      },
                      error: (error, stackTrace) {
                        log(stackTrace.toString());
                        return Center(child: Text(error.toString()));
                      },
                      loading: () => SizedBox(
                        height: 190.h,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            return Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                width: 160.w,
                                height: 160.h,
                                margin: EdgeInsets.only(bottom: 15.h),
                                padding: EdgeInsets.all(12.w),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.r),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 120.w,
                                      height: 30.h,
                                      color: Colors.grey[400],
                                    ),
                                    SizedBox(width: 12.w),
                                    Container(
                                      width: 100.w,
                                      height: 16.h,
                                      color: Colors.grey[400],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 70.h),
                    // variationProductProvider.when(
                    //   data: (data) {
                    //     if (data.isEmpty) {
                    //       return const SizedBox(child: Text("No data available"));
                    //     }
                    //     return SizedBox(
                    //       height: 280.h,
                    //       child: ListView.builder(
                    //         padding: EdgeInsets.zero,
                    //         itemCount: data.length,
                    //         scrollDirection: Axis.horizontal,
                    //         itemBuilder: (context, index) {
                    //           // final imageUrl = data[index].image?.src ?? "";
                    //           final imageUrl = selectedLang == "en"
                    //               ? (data[index].image?.src ?? "")
                    //               : (data[index].image?.src ?? "");
                    //           return Container(
                    //             margin: EdgeInsets.only(right: 20.w, left: 20.w),
                    //             child: Column(
                    //               crossAxisAlignment: CrossAxisAlignment.start,
                    //               children: [
                    //                 Image.network(
                    //                   imageUrl.isNotEmpty
                    //                       ? imageUrl
                    //                       : "https://via.placeholder.com/300x200.png?text=No+Image",
                    //                   height: 150.h,
                    //                   width: 300.w,
                    //                   fit: BoxFit.cover,
                    //                   errorBuilder: (context, error, stackTrace) {
                    //                     return Image.network(
                    //                       "https://static.vecteezy.com/system/resources/thumbnails/048/910/778/small/default-image-missing-placeholder-free-vector.jpg",
                    //                       height: 150.h,
                    //                       width: 300.w,
                    //                       fit: BoxFit.cover,
                    //                     );
                    //                   },
                    //                 ),
                    //               ],
                    //             ),
                    //           );
                    //         },
                    //       ),
                    //     );
                    //   },
                    //   error: (error, stackTrace) {
                    //     log(stackTrace.toString());
                    //     return Center(child: Text(error.toString()));
                    //   },
                    //   loading: () =>
                    //       const Center(child: CircularProgressIndicator()),
                    // ),
                  ],
                ),
              ),
            ],
          );
        },
        error: (error, stackTrace) {
          log(stackTrace.toString());
          return Center(
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
          );
        },
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
      bottomSheet: productDetailsProvider.when(
        data: (data) {
          return ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: Size(400.w, 50.h),
              backgroundColor: Color(0xFF3e64de),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            onPressed: () async {
              if (token == null) {
                Navigator.push(
                  context,
                  CupertinoPageRoute(builder: (context) => LoginPage()),
                );
                showSuccessMessage(context, "please login first");
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
                final service = APIStateNetwork(createDio());
                final response = await service.addToCart(body);

                if (response.success == true) {
                  setState(() {
                    isLoading = false;
                  });

                  await showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
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
                        actionsAlignment: MainAxisAlignment.spaceBetween,
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.redAccent,
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
                              backgroundColor: Color(0xFF3e64de),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                CupertinoPageRoute(
                                  builder: (_) => const CartPage(),
                                  settings: const RouteSettings(
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
                ? CircularProgressIndicator(color: Colors.white)
                : Text(
                    "Add to Cart",
                    style: GoogleFonts.roboto(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
          );
        },
        error: (error, stackTrace) => SizedBox.shrink(),
        loading: () => SizedBox.shrink(),
      ),
    );
  }
}
