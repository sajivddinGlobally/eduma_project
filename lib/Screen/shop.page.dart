import 'package:eduma_app/Screen/productDetails.page.dart';
import 'package:eduma_app/data/Controller/productListController.dart';
import 'package:eduma_app/data/Controller/wishlistControllerClass.dart';
import 'package:eduma_app/data/Model/productListModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

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
  @override
  Widget build(BuildContext context) {
    final productListProvider = ref.watch(productListController);
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
                productListProvider.when(
                  data: (snap) {
                    final filteredProducts = snap.where((product) {
                      final title = product.name!.toLowerCase();
                      return title.contains(searchQuery);
                    }).toList();
                    if (filteredProducts.isEmpty) {
                      return Center(
                        child: Text(
                          "No products found",
                          style: GoogleFonts.roboto(
                            fontSize: 16.sp,
                            color: Colors.grey[600],
                          ),
                        ),
                      );
                    }
                    return Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 20.w,
                          right: 20.w,
                          top: 20.h,
                        ),
                        child: GridView.builder(
                          itemCount: filteredProducts.length,
                          padding: EdgeInsets.zero,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 20.w,
                                mainAxisSpacing: 15.h,
                                childAspectRatio: 190 / 180,
                              ),
                          itemBuilder: (context, index) {
                            return ProductCard(data: filteredProducts[index]);
                          },
                        ),
                      ),
                    );
                  },
                  error: (error, stackTrace) =>
                      Center(child: Text(error.toString())),
                  loading: () => Center(child: CircularProgressIndicator()),
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
  const ProductCard({super.key, required this.data});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isWishlisted = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) =>
                        ProductDetailsPage(id: widget.data.id!.toString()),
                  ),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: Image.network(
                  // "assets/reading2.png",
                  //shopList[index]['image'].toString(),
                  widget.data.images![0].medium.toString(),
                  width: 190.w,
                  height: 125.h,
                  fit: BoxFit.cover,
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
                      color: isWishlisted ? Colors.red : Colors.white,
                      size: 25.sp,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        Text(
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          //  "Introduction learn Press - LMS Plugin",
          // shopList[index]['name'].toString(),
          widget.data.name.toString(),
          style: GoogleFonts.roboto(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: Color(0xFF000000),
            letterSpacing: -0.4,
            height: 1,
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
      ],
    );
  }
}
