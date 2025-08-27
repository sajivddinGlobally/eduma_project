import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:eduma_app/config/core/showFlushbar.dart';
import 'package:eduma_app/config/network/api.state.dart';
import 'package:eduma_app/config/utils/pretty.dio.dart';
import 'package:eduma_app/data/Model/productWishlistBodyModel.dart';
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

// class productWishlistController {
//   static Future<bool> productWishlist({
//     required BuildContext context,
//     required int productId,
//     required bool currentStatus,
//   }) async {
//     try {
//       final body = ProductWishlistBodyModel(productId: productId);
//       final service = APIStateNetwork(createWooCommerceDio());
//       final reponse = await service.productWishlist(body);
//       if (reponse.success == true) {
//         showSuccessMessage(context, reponse.message);
//         return !currentStatus;
//       }
//     } catch (e) {
//       log(e.toString());
//     }
//     return currentStatus;
//   }
// }

class ProductWishlistController {
  static Future<bool> productWishlist({
    required BuildContext context,
    required int productId,
    required bool currentStatus,
  }) async {
    try {
      final body = ProductWishlistBodyModel(productId: productId);
      final service = APIStateNetwork(createWooCommerceDio());

      final response = await service.productWishlist(body);

      // Agar API ne success return kiya
      if (response.success == true) {
        showSuccessMessage(context, response.message);
        return !currentStatus; // state toggle karo
      }
    } on DioException catch (e) {
      if (e.response != null && e.response?.data != null) {
        final data = e.response!.data;

        // 👇 check karo error code
        if (data['code'] == "already_in_wishlist") {
          showSuccessMessage(context, data['message']);
          return true; // wishlist mein already hai
        }
      }
      log("Wishlist API Error: ${e.response?.data ?? e.message}");

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Something went wrong!")));
    } catch (e) {
      log("Wishlist Exception: $e");

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Unexpected error!")));
    }

    return currentStatus;
  }
}
