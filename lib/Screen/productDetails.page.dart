import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({super.key});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Stack(
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
          Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 33.h),
                Row(
                  children: [
                    Container(
                      width: 37.w,
                      height: 37.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(25, 0, 0, 0),
                      ),
                      child: IconButton(
                        style: IconButton.styleFrom(
                          minimumSize: Size(0, 0),
                          padding: EdgeInsets.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: Color(0xFF001E6C),
                          size: 20.sp,
                        ),
                      ),
                    ),
                    SizedBox(width: 50.w),
                    Text(
                      "Product Details",
                      style: GoogleFonts.roboto(
                        fontSize: 26.sp,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1B1B1B),
                        letterSpacing: -0.4,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30.h),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: Image.asset(
                    //orderDetaisl.lineItems[0].image.src.toString(),
                    "assets/shop1.png",
                    width: MediaQuery.of(context).size.width,
                    height: 198.h,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.network(
                        "https://upload.wikimedia.org/wikipedia/commons/6/65/No-Image-Placeholder.svg",
                        width: MediaQuery.of(context).size.width,
                        height: 69.h,
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    Text(
                      "Create an LMS Website With LearnPress",
                      style: GoogleFonts.roboto(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF000000),
                        letterSpacing: -0.4,
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.only(
                        left: 8.w,
                        right: 8.w,
                        top: 6.h,
                        bottom: 6.h,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: Color(0xFF001E6C),
                      ),
                      child: TextButton(
                        style: IconButton.styleFrom(
                          minimumSize: Size(0, 0),
                          padding: EdgeInsets.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: () {},
                        child: Text(
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
                SizedBox(height: 10.h),
                Text(
                  "Product description",
                  style: GoogleFonts.roboto(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF000000),
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  "The 25th Workshop based on Treasure of Treatise -18 is a deep dive into the ancient scriptures and texts, uncovering hidden gems of knowledge and wisdom. Participants will explore the rich heritage of ancient treatises and unlock valuable insights for personal growth and development.",
                  style: GoogleFonts.roboto(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF000000),
                    letterSpacing: -1,
                  ),
                ),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    Text(
                      "₹ 45k",

                      style: GoogleFonts.roboto(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF001E6C),
                      ),
                    ),
                    SizedBox(width: 10.h),
                    Text(
                      "24% off",
                      style: GoogleFonts.roboto(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF1BB93D),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 13.h),
                Row(
                  children: [
                    Text(
                      "₹ 50k",
                      style: GoogleFonts.roboto(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF001E6C),
                        decoration: TextDecoration.lineThrough,
                        decorationThickness: 2,
                      ),
                    ),
                    SizedBox(width: 10.h),
                    Text(
                      "MRP",
                      style: GoogleFonts.roboto(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF000000),
                      ),
                    ),
                    SizedBox(width: 10.h),
                    Text(
                      "(incl. off all texes)",
                      style: GoogleFonts.roboto(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFFA49F9F),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30.h),
                SizedBox(height: 10.h),
                Text(
                  "shipping_policy_heading",
                  style: GoogleFonts.roboto(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF000000),
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  "shipping_policy",
                  style: GoogleFonts.roboto(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF000000),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
