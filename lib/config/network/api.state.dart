import 'package:dio/dio.dart';
import 'package:eduma_app/data/Model/loginBodyModel.dart';
import 'package:eduma_app/data/Model/loginResModel.dart';
import 'package:eduma_app/data/Model/registerBodyCustomeModel.dart';
import 'package:eduma_app/data/Model/registerResCustomeModel.dart';
import 'package:eduma_app/data/Model/resetPassBodyModel.dart';
import 'package:eduma_app/data/Model/resetPassResModel.dart';
import 'package:eduma_app/data/Model/sendOTPBodyModel.dart';
import 'package:eduma_app/data/Model/sendOTPResModel.dart';
import 'package:eduma_app/data/Model/verifyOTPBodyModel.dart';
import 'package:eduma_app/data/Model/verifyOTPResModel.dart';
import 'package:retrofit/retrofit.dart';

part 'api.state.g.dart';

@RestApi(baseUrl: "https://atatcsurat.com/wp-json")
abstract class APIStateNetwork {
  factory APIStateNetwork(Dio dio, {String baseUrl}) = _APIStateNetwork;

  @POST("/jwt-auth/v1/token")
  Future<LoginResModel> login(@Body() LoginBodyModel body);

  @POST("/custom/v1/register")
  Future<RegisterResCustomeModel> customeRegister(
    @Body() RegisterBodyCustomeModel body,
  );

  @POST("/custom/v1/send-otp")
  Future<SendOtpResModel> sendOTP(@Body() SendOtpBodyModel body);

  @POST("/custom/v1/verify-otp")
  Future<VerifyOtpResModel> verifyOTP(@Body() VerifyOtpBodyModel body);

  @POST("/custom/v1/reset-password")
  Future<ResetPassResModel> resetPassword(@Body() ResetPassBodyModel body);
}
