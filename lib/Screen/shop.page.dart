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
import 'package:eduma_app/data/Model/productListModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';

class ShopPage extends ConsumerStatefulWidget {
  const ShopPage({super.key});

  @override
  ConsumerState<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends ConsumerState<ShopPage> {
  final TextEditingController _searchController = TextEditingController();
  String searchQuery = '';
  List<Map<String, dynamic>> shopList = [
    {
      "image": "assets/reading2.png",
      "paid": "₹ 45.00",
      "name": "Introduction learn Press - LMS Plugin",
    },
    {
      "image": "assets/shop1.png",
      "paid": "Free",
      "name": "Create an LMS Website With LearnPress",
    },
    {
      "image": "assets/reading2.png",
      "paid": "₹ 45.00",
      "name": "Introduction learn Press - LMS Plugin",
    },
    {
      "image": "assets/shop1.png",
      "paid": "Free",
      "name": "Create an LMS Website With LearnPress",
    },
    {
      "image": "assets/reading2.png",
      "paid": "₹ 45.00",
      "name": "Introduction learn Press - LMS Plugin",
    },
    {
      "image": "assets/shop1.png",
      "paid": "Free",
      "name": "Create an LMS Website With LearnPress",
    },
    {
      "image": "assets/reading2.png",
      "paid": "₹ 45.00",
      "name": "Introduction learn Press - LMS Plugin",
    },
    {
      "image": "assets/shop1.png",
      "paid": "Free",
      "name": "Create an LMS Website With LearnPress",
    },
  ];
  bool isWishlisted = false;

  List<ProductListModel> products = [];
  int page = 0;
  int limit = 10;
  bool isloading = false;
  bool allowed = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // initially load first page
      ref.read(productListController.notifier).loadMore();
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent &&
          !ref.read(productListController).isLoading &&
          ref.read(productListController).hasMore) {
        ref.read(productListController.notifier).loadMore();
      }
    });
  }

  Future<void> _loadMoreProducts() async {
    setState(() {
      isloading = true;
    });

    try {
      final service = APIStateNetwork(createWooCommerceDio());
      final response = await service.productList();

      if (response.isNotEmpty) {
        setState(() {
          page++;
          products.addAll(response);
          if (response.length < limit) allowed = true;
        });
      } else {
        setState(() {
          isloading = false;
        });
      }
    } catch (e) {
      setState(() {
        isloading = false;
      });
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    //final productListProvider = ref.watch(productListController);
    final productState = ref.watch(productListController);
    final productNotifier = ref.read(productListController.notifier);

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
                Image.asset("assets/eduimage.png"),
                SizedBox(width: 10.w),
                Text(
                  "EDUCATION",
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
            right: 20.w,
            top: 64.h,
            child: Icon(
              Icons.notifications_none_outlined,
              color: Color(0xFF000000),
              size: 30.sp,
            ),
          ),
          Positioned(
            top: 85.h,
            left: 0,
            right: 0,
            bottom: 0,
            child: Column(
              children: [
                Text(
                  "Shop",
                  style: GoogleFonts.inter(
                    fontSize: 26.sp,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF001E6C),
                    letterSpacing: -1,
                  ),
                ),
                SizedBox(height: 16.h),
                Padding(
                  padding: EdgeInsets.only(left: 20.w, right: 20.w),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: "Search products...",
                      hintStyle: GoogleFonts.roboto(
                        fontSize: 14.sp,
                        color: Colors.grey[500],
                      ),
                      prefixIcon: Icon(Icons.search, color: Colors.grey[500]),
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
                ),
                SizedBox(height: 16.h),

                // productListProvider.when(
                //   data: (snap) {
                //     final filteredProducts = snap.where((product) {
                //       final title = product.name!.toLowerCase();
                //       return title.contains(searchQuery);
                //     }).toList();
                //     if (filteredProducts.isEmpty) {
                //       return Center(
                //         child: Text(
                //           "No products found",
                //           style: GoogleFonts.roboto(
                //             fontSize: 16.sp,
                //             color: Colors.grey[600],
                //           ),
                //         ),
                //       );
                //     }
                //     return Expanded(
                //       child: Padding(
                //         padding: EdgeInsets.only(
                //           left: 20.w,
                //           right: 20.w,
                //           top: 20.h,
                //         ),
                //         child: MasonryGridView.count(
                //           controller: _scrollController,
                //           crossAxisCount: 2,
                //           crossAxisSpacing: 20.w,
                //           mainAxisSpacing: 15.h,
                //           //itemCount: filteredProducts.length,
                //           itemCount: products.length + (allowed ? 0 : 1),
                //           itemBuilder: (context, index) {
                //             if (index < products.length) {
                //               final product = products[index];
                //               final boxHeight = index.isEven ? 250.0 : 150.0;
                //               return ProductCard(
                //                 data: product,
                //                 boxHeight: boxHeight,
                //               );
                //             } else {
                //               return const Center(
                //                 child: Padding(
                //                   padding: EdgeInsets.all(8.0),
                //                   child: CircularProgressIndicator(),
                //                 ),
                //               );
                //             }
                //           },
                //         ),
                //       ),
                //     );
                //   },
                //   error: (error, stackTrace) =>
                //       Center(child: Text(error.toString())),
                //   loading: () => Center(
                //     child: Column(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         CircularProgressIndicator(color: Color(0xFF001E6C)),
                //         SizedBox(height: 16.h),
                //         Text(
                //           "Loading products...",
                //           style: GoogleFonts.roboto(
                //             fontSize: 16.sp,
                //             fontWeight: FontWeight.w500,
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 20.w,
                      right: 20.w,
                      top: 20.h,
                    ),
                    child: MasonryGridView.count(
                      controller: _scrollController,
                      crossAxisCount: 2,
                      crossAxisSpacing: 20.w,
                      mainAxisSpacing: 15.h,
                      itemCount:
                          productState.products.length +
                          (productState.hasMore ? 1 : 0), // +1 for loader
                      itemBuilder: (context, index) {
                        if (index < productState.products.length) {
                          final product = productState.products[index];
                          final boxHeight = index.isEven ? 250.0 : 150.0;
                          return ProductCard(
                            data: product,
                            boxHeight: boxHeight,
                          );
                        } else {
                          return Center(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                      },
                    ),
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

class ProductCard extends StatefulWidget {
  final ProductListModel data;
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
                    widget.data.images![0].medium.toString(),
                    fit: BoxFit.fill,
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
            backgroundColor: Color(0xFF001E6C),
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
                            backgroundColor: Color(0xFF001E6C),
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
