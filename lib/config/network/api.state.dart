import 'dart:io';
import 'package:dio/dio.dart';
import 'package:eduma_app/data/Model/addCartBodyModel.dart';
import 'package:eduma_app/data/Model/addCartResModel.dart';
import 'package:eduma_app/data/Model/allCategoryModel.dart';
import 'package:eduma_app/data/Model/allCoursesModel.dart';
import 'package:eduma_app/data/Model/avtarResModel.dart';
import 'package:eduma_app/data/Model/cartModel.dart';
import 'package:eduma_app/data/Model/cartRemoveBodyModel.dart';
import 'package:eduma_app/data/Model/categoryByCourseIdModel.dart';
import 'package:eduma_app/data/Model/clearAllResModel.dart';
import 'package:eduma_app/data/Model/createBodyModel.dart';
import 'package:eduma_app/data/Model/createOrderBodyModel.dart';
import 'package:eduma_app/data/Model/createOrderCourseModel.dart';
import 'package:eduma_app/data/Model/createResModel.dart';
import 'package:eduma_app/data/Model/deleteWishlistResModel.dart';
import 'package:eduma_app/data/Model/enrollBodyModel.dart';
import 'package:eduma_app/data/Model/enrollCourseStudentModel.dart';
import 'package:eduma_app/data/Model/enrollResModel.dart';
import 'package:eduma_app/data/Model/getWishlistModel.dart';
import 'package:eduma_app/data/Model/latestCourseModel.dart';
import 'package:eduma_app/data/Model/loginBodyModel.dart';
import 'package:eduma_app/data/Model/loginResModel.dart';
import 'package:eduma_app/data/Model/notificationModel.dart';
import 'package:eduma_app/data/Model/orderCreateModel.dart';
import 'package:eduma_app/data/Model/orderDetailsModel.dart';
import 'package:eduma_app/data/Model/orderListModel.dart';
import 'package:eduma_app/data/Model/popularCourseDetailsModel.dart';
import 'package:eduma_app/data/Model/popularCourseModel.dart';
import 'package:eduma_app/data/Model/productBooksModel.dart';
import 'package:eduma_app/data/Model/productDeleteBodyModel.dart';
import 'package:eduma_app/data/Model/productDeleteResModel.dart';
import 'package:eduma_app/data/Model/productDetailsModel.dart';
import 'package:eduma_app/data/Model/productInstrumentModel.dart';
import 'package:eduma_app/data/Model/productWishlistBodyModel.dart';
import 'package:eduma_app/data/Model/productWishlistModel.dart';
import 'package:eduma_app/data/Model/productWishlistReModel.dart';
import 'package:eduma_app/data/Model/profileModel.dart';
import 'package:eduma_app/data/Model/registerBodyCustomeModel.dart';
import 'package:eduma_app/data/Model/registerResCustomeModel.dart';
import 'package:eduma_app/data/Model/relatedProductModel.dart';
import 'package:eduma_app/data/Model/removeCartQuantityResModel.dart';
import 'package:eduma_app/data/Model/removerCartQuanityrBodModel.dart';
import 'package:eduma_app/data/Model/resetPassBodyModel.dart';
import 'package:eduma_app/data/Model/resetPassResModel.dart';
import 'package:eduma_app/data/Model/sendOTPBodyModel.dart';
import 'package:eduma_app/data/Model/sendOTPResModel.dart';
import 'package:eduma_app/data/Model/updateProfileResModel.dart';
import 'package:eduma_app/data/Model/verifyOTPBodyModel.dart';
import 'package:eduma_app/data/Model/verifyOTPResModel.dart';
import 'package:eduma_app/data/Model/wishlistBodyModel.dart';
import 'package:eduma_app/data/Model/wishlistResModel.dart';
import 'package:retrofit/retrofit.dart';

part 'api.state.g.dart';

@RestApi(baseUrl: "https://atatcsurat.com/wp-json")
abstract class APIStateNetwork {
  factory APIStateNetwork(Dio dio, {String baseUrl}) = _APIStateNetwork;

  @POST("/jwt-auth/v1/token")
  Future<LoginResModel> login(@Body() LoginBodyModel body);

  @POST("/custom/v1/register")
  Future<RegisterResModel> customeRegister(@Body() RegisterBodyModel body);

  @POST("/custom/v1/send-otp")
  Future<SendOtpResModel> sendOTP(@Body() SendOtpBodyModel body);

  @POST("/custom/v1/verify-otp")
  Future<VerifyOtpResModel> verifyOTP(@Body() VerifyOtpBodyModel body);

  @POST("/custom/v1/reset-password")
  Future<ResetPassResModel> resetPassword(@Body() ResetPassBodyModel body);

  @GET("/custom/v1/popular-courses")
  Future<List<PopularCourseModel>> popularCourse();

  @GET("/custom/v1/popular-courses/{id}")
  Future<PopularCourseDetailsModel> popularCourseDetails(@Path() String id);
  //courses
  @GET("/custom/v1/courses")
  Future<AllCoursesModel> allCourses({
    @Query("page") int page = 1,
    @Query("per_page") int perPage = 10,
  });

  @POST("/custom/v1/wishlist")
  Future<WishlistResModel> wishlist(@Body() WishlistBodyModel body);

  @GET("/custom/v1/wishlist")
  Future<GetwishlistModel> fetchWishlist();

  @DELETE("/custom/v1/wishlist")
  Future<DeletewishlistResModel> deleteWishlist(@Body() WishlistBodyModel body);

  // @GET("/custom/v1/instructors")
  // Future<List<InstructorModel>> instructor();

  @GET("/custom/v1/categories")
  Future<AllCategoryModel> allCategory();

  // @GET("/custom/v1/courses-category?category={id}")
  // Future<CorurseByCategoryIdModel> categoryByCourseId(@Path() String id);

  @GET("/custom/v1/courses-category")
  Future<CorurseByCategoryIdModel> categoryByCourseId(
    @Query("category") String id,
    @Query("per_page") int perPage, // optional
    @Query("page") int page, // optional
  );

  @GET("/custom/v1/profile")
  Future<ProfileModel> profile();

  @POST("/custom/v1/updateprofile")
  @MultiPart()
  Future<UpdateProfileResModel> updateProfileFormData(
    @Body() FormData formData,
  );

  @POST("/custom/v1/upload-avatar")
  @MultiPart()
  Future<AvatarResModel> updateAvater(@Part(name: "avatar") File imageFile);

  @POST("/custom/v1/enroll-free-course")
  Future<EnrollResModel> enroll(@Body() EnrollBodyModel body);

  /// student course purchese vo data show
  @GET("/custom/v1/enrolled-courses")
  Future<EnrolleCourseStudentModel> enrolledCourse();

  @GET("/wc/v3/products/{id}")
  Future<ProductDetailsModel> productDetails(@Path() String id);

  @GET("/custom-api/v1/aspeus-books")
  Future<List<ProductBookModel>> fetchProductBooks();

  @GET("/custom-api/v1/instruments")
  Future<List<ProductInstrumentModel>> fetchProductInstrument();

  @POST("/wc/v3/wishlist")
  Future<ProductWishlistReModel> productWishlist(
    @Body() ProductWishlistBodyModel body,
  );

  @GET("/wc/v3/wishlist")
  Future<ProductWishlistgetModel> fetchProductWishlist();

  @DELETE("/wc/v3/wishlist/remove")
  Future<ProductDeleteResModel> productDelete(
    @Body() ProductDeleteBodyModel body,
  );

  @POST("/custom/v1/cart/add")
  Future<ProductAddCartResModel> addToCart(
    @Body() ProductAddCartBodyModel body,
  );

  @GET("/custom/v1/cart")
  Future<CartModel> cartlist();

  @POST("/custom/v1/cart/remove")
  Future<ProductAddCartResModel> removeCart(@Body() CarRemoveBodyModel body);

  @POST("/custom/v1/cart/remove-quantity")
  Future<RemoveCartQuantityResModel> removerQuantiry(
    @Body() RemoveCartQuantityBodyModel body,
  );

  @POST("/custom/v1/cart/clear")
  Future<ClearAllResModel> clearAll();

  // @GET("/wc/v3/orders")
  @GET("/wc/v3/orders?customer={id}")
  Future<List<OrderListModel>> order(@Path("id") String id);

  @GET("/wc/v3/orders/{id}")
  Future<OrderDetailsModel> orderDetails(@Path() String id);

  @GET("/custom/v1/latest-courses")
  Future<LatestCourseModel> latestCourse();

  @GET("/custom/v1/notifications/{id}")
  Future<List<NotificationModel>> notification(@Path("id") String id);

  // @POST("/cwcc/v1/create-order")
  // Future<OrderCreateModel> createOrder(@Body() Map<String, dynamic> body);

  @POST("/custom/v1/create-order-course")
  Future<CreateOrderCourseResModel> courseCreateOrder(
    @Body() CreateOrderCourseBodyModel body,
  );

  @POST("/custom/v1/google-login")
  Future<LoginResModel> googleLoing(@Body() Map<String, dynamic> body);

  @GET("/custom/v1/related-products/{id}")
  Future<List<RelatedProductModel>> relatedProdut(@Path("id") String id);

  @POST("/cwcc/v1/create-order")
  Future<CreateResModel> create(@Body() CreateBodyModel body);
}
