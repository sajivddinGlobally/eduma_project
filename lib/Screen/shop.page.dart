import 'dart:developer';
import 'package:eduma_app/Screen/cart.page.dart';
import 'package:eduma_app/Screen/login.page.dart';
import 'package:eduma_app/Screen/productDetails.page.dart';
import 'package:eduma_app/config/core/showFlushbar.dart';
import 'package:eduma_app/config/network/api.state.dart';
import 'package:eduma_app/config/utils/pretty.dio.dart';
import 'package:eduma_app/data/Controller/productListController.dart';
import 'package:eduma_app/data/Controller/wishlistControllerClass.dart';
import 'package:eduma_app/data/Model/addCartBodyModel.dart';
import 'package:eduma_app/data/Model/productBooksModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shimmer/shimmer.dart';

class ShopPage extends ConsumerStatefulWidget {
  const ShopPage({super.key});

  @override
  ConsumerState<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends ConsumerState<ShopPage> {
  final TextEditingController _searchController = TextEditingController();
  String searchQuery = '';
  int tab = 0;

  @override
  Widget build(BuildContext context) {
    final productListBooksProvider = ref.watch(productListBooksController);
    final productListInstrumentsProvider = ref.watch(
      productListInstrumentController,
    );

    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Image.asset("assets/shopimage.png"),
          ),
          Positioned(
            top: 45.h,
            child: Row(
              children: [
                SizedBox(width: 20.w),
                Padding(
                  padding: EdgeInsets.only(left: 0.w),
                  child: Image.asset(
                    "assets/logo.png",
                    width: 45.w,
                    height: 45.h,
                  ),
                ),
                SizedBox(width: 10.w),
                Text(
                  "Shop",
                  style: GoogleFonts.inter(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF001E6C),
                    letterSpacing: -1,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 85.h,
            left: 0,
            right: 0,
            bottom: 0,
            child: Column(
              children: [
                // Text(
                //   "Shop",
                //   style: GoogleFonts.inter(
                //     fontSize: 26.sp,
                //     fontWeight: FontWeight.w600,
                //     color: Color(0xFF001E6C),
                //     letterSpacing: -1,
                //   ),
                // ),
                Padding(
                  padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
                  child: Column(
                    children: [
                      SizedBox(height: 16.h),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(double.infinity, 45.h),
                                //backgroundColor: Color(0xFF001E6C),
                                backgroundColor: tab == 0
                                    ? Color(0xFF3e64de)
                                    : Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                  side: BorderSide.none,
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  tab = 0;
                                });
                              },
                              child: Text(
                                "Book",
                                style: GoogleFonts.roboto(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                  color: tab == 0 ? Colors.white : Colors.black,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(double.infinity, 45.h),
                                //backgroundColor: Color(0xFF001E6C),
                                backgroundColor: tab == 1
                                    ? Color(0xFF3e64de)
                                    : Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                  side: BorderSide.none,
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  tab = 1;
                                });
                              },
                              child: Text(
                                "Instruments",
                                style: GoogleFonts.roboto(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                  color: tab == 1 ? Colors.white : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: "Search products...",
                          hintStyle: GoogleFonts.roboto(
                            fontSize: 14.sp,
                            color: Colors.grey[500],
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.grey[500],
                          ),
                          filled: true,
                          fillColor: Colors.grey[100],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                        ),
                        onChanged: (value) {
                          setState(() => searchQuery = value.toLowerCase());
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),
                tab == 0
                    ? productListBooksProvider.when(
                        data: (books) {
                          final filteredBooks = books
                              .where(
                                (book) => book.name.toLowerCase().contains(
                                  searchQuery,
                                ),
                              )
                              .toList();

                          return Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: 20.w,
                                right: 20.w,
                                top: 20.h,
                              ),
                              child: filteredBooks.isEmpty
                                  ? Text(
                                      "No Product available",
                                      style: GoogleFonts.inter(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey[600],
                                      ),
                                    )
                                  : MasonryGridView.count(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 20.w,
                                      mainAxisSpacing: 15.h,
                                      itemCount: filteredBooks.length,
                                      itemBuilder: (context, index) {
                                        if (index < filteredBooks.length) {
                                          final product = filteredBooks[index];
                                          final boxHeight = index.isEven
                                              ? 250.0
                                              : 150.0;
                                          return ProductCard(
                                            data: product,
                                            boxHeight: boxHeight,
                                          );
                                        }
                                        return SizedBox.shrink();
                                      },
                                    ),
                            ),
                          );
                        },
                        error: (error, stackTrace) =>
                            Center(child: Text(error.toString())),
                        loading: () => _buildShimmerGrid(),
                      )
                    : productListInstrumentsProvider.when(
                        data: (instruments) {
                          final filteredInstruments = instruments
                              .where(
                                (instrument) => instrument.name
                                    .toLowerCase()
                                    .contains(searchQuery),
                              )
                              .toList();
                          return Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: 20.w,
                                right: 20.w,
                                top: 20.h,
                              ),
                              child: filteredInstruments.isEmpty
                                  ? Text(
                                      "No Product available",
                                      style: GoogleFonts.inter(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey[600],
                                      ),
                                    )
                                  : MasonryGridView.count(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 20.w,
                                      mainAxisSpacing: 15.h,
                                      itemCount: filteredInstruments.length,
                                      itemBuilder: (context, index) {
                                        if (index <
                                            filteredInstruments.length) {
                                          final product =
                                              filteredInstruments[index];
                                          final boxHeight = index.isEven
                                              ? 250.0
                                              : 150.0;
                                          return ProductBoth(
                                            data: product,
                                            boxHeight: boxHeight,
                                          );
                                        }
                                        return SizedBox.shrink();
                                      },
                                    ),
                            ),
                          );
                        },
                        error: (error, stackTrace) =>
                            Center(child: Text(error.toString())),
                        loading: () => _buildShimmerGrid(),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerGrid() {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(left: 20.w, right: 20.w),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 20.w,
            mainAxisSpacing: 15.h,
            childAspectRatio: 175 / 200,
          ),
          itemCount: 6,
          itemBuilder: (context, index) {
            return Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 250.w,
                    height: 150.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10.h),
                    width: 200.w,
                    height: 14.h,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 14.h),
                    width: 200.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class ProductCard extends StatefulWidget {
  final ProductBookModel data;
  final double boxHeight;
  const ProductCard({super.key, required this.data, required this.boxHeight});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isWishlisted = false;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    var box = Hive.box("userBox");
    var token = box.get("token");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Stack(
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) =>
                        ProductDetailsPage(id: widget.data.id.toString()),
                  ),
                );
              },
              child: Container(
                width: 190.w,
                height: widget.boxHeight,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: Image.network(
                    widget.data.image,
                    fit: BoxFit.fill,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.network(
                        "https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png",
                        width: 190.w,
                        height: widget.boxHeight,
                        fit: BoxFit.fill,
                      );
                    },
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                margin: EdgeInsets.only(top: 8.h, right: 13.w),
                child: IconButton(
                  style: IconButton.styleFrom(
                    minimumSize: Size(0, 0),
                    padding: EdgeInsets.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
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
                    // 👇 API call se direct result lo
                    final result =
                        await ProductWishlistController.productWishlist(
                          context: context,
                          productId: widget.data.id!,
                          currentStatus: isWishlisted,
                        );
                    // 👇 bas yehi update karna hai
                    setState(() {
                      isWishlisted = result;
                    });
                  },
                  icon: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    transitionBuilder: (child, animation) {
                      return ScaleTransition(
                        scale: CurvedAnimation(
                          parent: animation,
                          curve: Curves.easeInOutBack,
                        ),
                        child: child,
                      );
                    },
                    child: Icon(
                      isWishlisted ? Icons.favorite : Icons.favorite_border,
                      key: ValueKey<bool>(isWishlisted),
                      color: isWishlisted ? Colors.red : Colors.black,
                      size: 25.sp,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 13.h),
        Text(
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          //  "Introduction learn Press - LMS Plugin",
          // shopList[index]['name'].toString(),
          widget.data.name.toString(),
          style: GoogleFonts.roboto(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: Color(0xFF000000),
            height: 1.3,
          ),
        ),
        SizedBox(height: 6.h),
        Text(
          //"₹ 45.00",
          //shopList[index]['paid'].toString(),
          "₹${widget.data.price.toString()}",
          style: GoogleFonts.roboto(
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
            color: Color(0xFF001E6C),
          ),
        ),
        SizedBox(height: 10.h),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: Size(double.infinity, 45.h),
            //backgroundColor: Color(0xFF001E6C),
            backgroundColor: Color(0xFF3e64de),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
              side: BorderSide.none,
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
              productId: widget.data.id!,
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
                                settings: const RouteSettings(name: "CartPage"),
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
                  width: 30.w,
                  height: 30.h,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 1.5,
                  ),
                )
              : Text(
                  "Add To Cart",
                  style: GoogleFonts.roboto(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
        ),
      ],
    );
  }
}

// Update ProductCard to handle both types
class ProductBoth extends StatefulWidget {
  final dynamic
  data; // Use dynamic to accept both ProductBookModel and ProductInstrumentModel
  final double boxHeight;

  const ProductBoth({super.key, required this.data, required this.boxHeight});

  @override
  State<ProductBoth> createState() => _ProductBothState();
}

class _ProductBothState extends State<ProductBoth> {
  bool isWishlisted = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    var box = Hive.box("userBox");
    var token = box.get("token");

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Stack(
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) =>
                        ProductDetailsPage(id: widget.data.id.toString()),
                  ),
                );
              },
              child: Container(
                width: 190.w,
                height: widget.boxHeight,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: Image.network(
                    widget.data.image,
                    fit: BoxFit.fill,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.network(
                        "https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png",
                        width: 190.w,
                        height: widget.boxHeight,
                        fit: BoxFit.fill,
                      );
                    },
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                margin: EdgeInsets.only(top: 8.h, right: 13.w),
                child: IconButton(
                  style: IconButton.styleFrom(
                    minimumSize: Size(0, 0),
                    padding: EdgeInsets.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
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
                    final result =
                        await ProductWishlistController.productWishlist(
                          context: context,
                          productId: widget.data.id!,
                          currentStatus: isWishlisted,
                        );
                    setState(() {
                      isWishlisted = result;
                    });
                  },
                  icon: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    transitionBuilder: (child, animation) {
                      return ScaleTransition(
                        scale: CurvedAnimation(
                          parent: animation,
                          curve: Curves.easeInOutBack,
                        ),
                        child: child,
                      );
                    },
                    child: Icon(
                      isWishlisted ? Icons.favorite : Icons.favorite_border,
                      key: ValueKey<bool>(isWishlisted),
                      color: isWishlisted ? Colors.red : Colors.black,
                      size: 25.sp,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 13.h),
        Text(
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          widget.data.name.toString(),
          style: GoogleFonts.roboto(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: Color(0xFF000000),
            height: 1.3,
          ),
        ),
        SizedBox(height: 6.h),
        Text(
          "₹${widget.data.price.toString()}",
          style: GoogleFonts.roboto(
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
            color: Color(0xFF001E6C),
          ),
        ),
        SizedBox(height: 10.h),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: Size(double.infinity, 45.h),
            backgroundColor: Color(0xFF3e64de),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
              side: BorderSide.none,
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
              productId: widget.data.id!,
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
                                settings: const RouteSettings(name: "CartPage"),
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
                  width: 30.w,
                  height: 30.h,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 1.5,
                  ),
                )
              : Text(
                  "Add To Cart",
                  style: GoogleFonts.roboto(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
        ),
      ],
    );
  }
}
