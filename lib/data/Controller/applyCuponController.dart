import 'dart:developer';

import 'package:eduma_app/config/core/showFlushbar.dart';
import 'package:eduma_app/config/network/api.state.dart';
import 'package:eduma_app/config/utils/pretty.dio.dart';
import 'package:eduma_app/data/Model/appluCuponBodyModel.dart';
import 'package:eduma_app/data/Model/applyCuponResModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ApplyCuponController
    extends StateNotifier<AsyncValue<ApplyCuponResModel?>> {
  ApplyCuponController() : super(AsyncValue.data(null));
  Future<void> appluCupon({
    required String cuponCode,
    required BuildContext context,
  }) async {
    try {
      state = AsyncValue.loading();
      final body = ApplyCuponBodyModel(couponCode: cuponCode);
      final service = APIStateNetwork(createDio());
      final response = await service.applyCupon(body);
      if (response.success == true) {
        showSuccessMessage(
          context,
          response.message == "20% discount applied successfully"
              ? "Already Coupon Apply"
              : "",
        );
      }
      state = AsyncValue.data(response);
    } catch (e, st) {
      log(e.toString());
      state = AsyncValue.error(e, st);
      log(st.toString());
    }
  }
}

final applyCuponProvider =
    StateNotifierProvider<
      ApplyCuponController,
      AsyncValue<ApplyCuponResModel?>
    >((ref) {
      return ApplyCuponController();
    });
