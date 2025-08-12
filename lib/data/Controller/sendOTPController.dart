// import 'dart:developer';
// import 'package:eduma_app/config/network/api.state.dart';
// import 'package:eduma_app/config/utils/pretty.dio.dart';
// import 'package:eduma_app/data/Model/sendOTPBodyModel.dart';
// import 'package:eduma_app/data/Model/sendOTPResModel.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class SendOTPController extends StateNotifier<AsyncValue<SendOtpResModel>> {
//   SendOTPController()
//     : super(AsyncValue.data(SendOtpResModel(success: false, message: '')));

//   Future<void> sendOTP(SendOtpBodyModel body) async {
//     state = const AsyncValue.loading();
//     final serivce = APIStateNetwork(createDio());
//     try {
//       final response = await serivce.sendOTP(body);
//       state = AsyncValue.data(response);
//     } catch (e, st) {
//       state = AsyncValue.error(e, st);
//       log(e.toString());
//     }
//   }
// }

// final sendOtpProvider =
//     StateNotifierProvider<SendOTPController, AsyncValue<SendOtpResModel>>(
//       (ref) => SendOTPController(),
//     );
