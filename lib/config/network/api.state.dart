import 'package:dio/dio.dart';
import 'package:eduma_app/data/Model/addCartBodyModel.dart';
import 'package:eduma_app/data/Model/addCartResModel.dart';
import 'package:eduma_app/data/Model/allCategoryModel.dart';
import 'package:eduma_app/data/Model/allCoursesModel.dart';
import 'package:eduma_app/data/Model/categoryByCourseIdModel.dart';
import 'package:eduma_app/data/Model/deleteWishlistResModel.dart';
import 'package:eduma_app/data/Model/enrollBodyModel.dart';
import 'package:eduma_app/data/Model/enrollCourseStudentModel.dart';
import 'package:eduma_app/data/Model/enrollResModel.dart';
import 'package:eduma_app/data/Model/getWishlistModel.dart';
import 'package:eduma_app/data/Model/instructorModel.dart';
import 'package:eduma_app/data/Model/loginBodyModel.dart';
import 'package:eduma_app/data/Model/loginResModel.dart';
import 'package:eduma_app/data/Model/orderDetailsModel.dart';
import 'package:eduma_app/data/Model/orderListModel.dart';
import 'package:eduma_app/data/Model/popularCourseDetailsModel.dart';
import 'package:eduma_app/data/Model/popularCourseModel.dart';
import 'package:eduma_app/data/Model/productDetailsModel.dart';
import 'package:eduma_app/data/Model/productListModel.dart';
import 'package:eduma_app/data/Model/profileModel.dart';
import 'package:eduma_app/data/Model/registerBodyCustomeModel.dart';
import 'package:eduma_app/data/Model/registerResCustomeModel.dart';
import 'package:eduma_app/data/Model/resetPassBodyModel.dart';
import 'package:eduma_app/data/Model/resetPassResModel.dart';
import 'package:eduma_app/data/Model/sendOTPBodyModel.dart';
import 'package:eduma_app/data/Model/sendOTPResModel.dart';
import 'package:eduma_app/data/Model/updateProfileBodyModel.dart';
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
  // courses
  @GET("/custom/v1/courses")
  Future<AllCoursesModel> allCourses();

  @POST("/custom/v1/wishlist")
  Future<WishlistResModel> wishlist(@Body() WishlistBodyModel body);

  @GET("/custom/v1/wishlist")
  Future<GetwishlistModel> fetchWishlist();

  @DELETE("/custom/v1/wishlist")
  Future<DeletewishlistResModel> deleteWishlist(@Body() WishlistBodyModel body);

  @GET("/custom/v1/instructors")
  Future<List<InstructorModel>> instructor();

  @GET("/custom/v1/categories")
  Future<AllCategoryModel> allCategory();

  @GET("/custom/v1/courses-category?category=160")
  Future<CorurseByCategoryIdModel> categoryByCourseId(@Path() String id);

  @GET("/wp-json/custom/v1/profile")
  Future<ProfileModel> profile();

  @POST("/custom/v1/update-profile")
  Future<UpdateProfileResModel> updateProfile(
    @Body() UpdateProfileBodyModel body,
  );

  @POST("/custom/v1/enroll-free-course")
  Future<EnrollResModel> enroll(@Body() EnrollBodyModel body);

  /// student course purchese vo data show
  @GET("/custom/v1/enrolled-courses")
  Future<EnrolleCourseStudentModel> enrolledCourse();

  @GET("/wc/v3/products")
  Future<List<ProductListModel>> productList();

  @GET("/wc/v3/products/{id}")
  Future<ProductDetailsModel> productDetails(@Path() String id);

  @POST("/custom/v1/cart/add")
  Future<ProductAddCartResModel> addToCart(@Body() ProductAddCartBodyModel body);

  @GET("/wc/v3/orders")
  Future<List<OrderListModel>> order();

  @GET("/wc/v3/orders/{id}")
  Future<OrderDetailsModel> orderDetails(@Path() String id);
}
