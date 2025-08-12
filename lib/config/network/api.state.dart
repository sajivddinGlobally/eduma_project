import 'package:dio/dio.dart';
import 'package:eduma_app/data/Model/loginBodyModel.dart';
import 'package:eduma_app/data/Model/loginResModel.dart';
import 'package:retrofit/retrofit.dart';

part 'api.state.g.dart';

@RestApi(baseUrl: "https://atatcsurat.com/wp-json")
abstract class APIStateNetwork {
  factory APIStateNetwork(Dio dio, {String baseUrl}) = _APIStateNetwork;

  @POST("/jwt-auth/v1/token")
  Future<LoginResModel> login(@Body() LoginBodyModel body);
}
