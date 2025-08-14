import 'dart:developer';

import 'package:eduma_app/config/core/showFlushbar.dart';
import 'package:eduma_app/config/network/api.state.dart';
import 'package:eduma_app/config/utils/pretty.dio.dart';
import 'package:eduma_app/data/Model/wishlistBodyModel.dart';
import 'package:flutter/material.dart';

class WishlistControllerClass {
  static Future<bool> toggle({
    required BuildContext context,
    required int courseId,
    required int userId,
    required bool currentStatus,
  }) async {
    try {
      final service = APIStateNetwork(createDio());
      final response = await service.wishlist(
        WishlistBodyModel(courseId: courseId, userId: userId),
      );

      if (response != null) {
        showSuccessMessage(context, response.message);
        return !currentStatus;
      }
    } catch (e) {
      log(e.toString());
    }
    return currentStatus;
  }
}
