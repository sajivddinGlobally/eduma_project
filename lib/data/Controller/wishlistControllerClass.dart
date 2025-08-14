import 'dart:developer';

import 'package:eduma_app/config/core/showFlushbar.dart';
import 'package:eduma_app/config/network/api.state.dart';
import 'package:eduma_app/config/utils/pretty.dio.dart';
import 'package:eduma_app/data/Model/wishlistBodyModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

class WishlistState {
  final bool isLoading;
  final String? successMessage;
  final String? errorMessage;

  const WishlistState({
    this.isLoading = false,
    this.successMessage,
    this.errorMessage,
  });

  WishlistState copyWith({
    bool? isLoading,
    String? successMessage,
    String? errorMessage,
  }) {
    return WishlistState(
      isLoading: isLoading ?? this.isLoading,
      successMessage: successMessage,
      errorMessage: errorMessage,
    );
  }

  // @override
  // List<Object?> get props => [isLoading, successMessage, errorMessage];
}

class WishlistNotifier extends StateNotifier<WishlistState> {
  WishlistNotifier() : super(const WishlistState());

  Future addToWishlist(WishlistBodyModel body) async {
    state = state.copyWith(
      isLoading: true,
      errorMessage: null,
      successMessage: null,
    );

    try {
      final service = APIStateNetwork(createDio());
      final response = await service.wishlist(body);

      if (response != null) {
        state = state.copyWith(
          isLoading: false,
          successMessage: response.message,
        );
        return response;
      } else {
        state = state.copyWith(
          isLoading: false,
          errorMessage: "Something went wrong",
        );
        return null;
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
      return null;
    }
  }
}

final wishlistNotifierProvider =
    StateNotifierProvider<WishlistNotifier, WishlistState>(
      (ref) => WishlistNotifier(),
    );
