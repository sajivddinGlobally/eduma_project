import 'dart:developer';

import 'package:eduma_app/config/network/api.state.dart';
import 'package:eduma_app/config/utils/pretty.dio.dart';
import 'package:eduma_app/data/Model/productListModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// final productListController = FutureProvider<List<ProductListModel>>((
//   ref,
// ) async {
//   final productService = APIStateNetwork(createWooCommerceDio());
//   return await productService.productList();
// });


class ProductListState {
  final List<ProductListModel> products;
  final bool isLoading;
  final bool hasMore;

  ProductListState({
    required this.products,
    required this.isLoading,
    required this.hasMore,
  });

  ProductListState copyWith({
    List<ProductListModel>? products,
    bool? isLoading,
    bool? hasMore,
  }) {
    return ProductListState(
      products: products ?? this.products,
      isLoading: isLoading ?? this.isLoading,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}


final productListController =
    StateNotifierProvider<ProductListNotifier, ProductListState>((ref) {
  return ProductListNotifier();
});

class ProductListNotifier extends StateNotifier<ProductListState> {
  ProductListNotifier()
      : super(ProductListState(products: [], isLoading: false, hasMore: true));

  int page = 1;
  final int limit = 10;

  Future<void> loadMore() async {
    if (state.isLoading || !state.hasMore) return;

    state = state.copyWith(isLoading: true);

    try {
      final service = APIStateNetwork(createWooCommerceDio());
      final response = await service.productList(page: page, perPage: limit);

      state = state.copyWith(
        products: [...state.products, ...response],
        isLoading: false,
        hasMore: response.length == limit,
      );

      page++;
    } catch (e) {
      state = state.copyWith(isLoading: false);
      log(e.toString());
    }
  }
}
