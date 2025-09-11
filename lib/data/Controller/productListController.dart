import 'dart:developer';
import 'package:eduma_app/config/network/api.state.dart';
import 'package:eduma_app/config/utils/pretty.dio.dart';
import 'package:eduma_app/data/Model/productListModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productListProvider = FutureProvider<List<ProductListModel>>((ref) async {
  final service = APIStateNetwork(createWooCommerceDio());
  return await service.productList(page: 1,perPage: 10);
});

// class ProductListState {
//   final List<ProductListModel> products;
//   final bool isLoading;
//   final bool hasMore;

//   ProductListState({
//     required this.products,
//     required this.isLoading,
//     required this.hasMore,
//   });

//   ProductListState copyWith({
//     List<ProductListModel>? products,
//     bool? isLoading,
//     bool? hasMore,
//   }) {
//     return ProductListState(
//       products: products ?? this.products,
//       isLoading: isLoading ?? this.isLoading,
//       hasMore: hasMore ?? this.hasMore,
//     );
//   }
// }

// final productListController =
//     StateNotifierProvider<ProductListNotifier, ProductListState>((ref) {
//       return ProductListNotifier();
//     });

// class ProductListNotifier extends StateNotifier<ProductListState> {
//   ProductListNotifier()
//     : super(ProductListState(products: [], isLoading: false, hasMore: true));

//   int page = 1;
//   final int limit = 10;

//   Future<void> loadMore() async {
//     if (state.isLoading || !state.hasMore) return;

//     state = state.copyWith(isLoading: true);

//     log("API call start: page=$page, limit=$limit");

//     try {
//       final service = APIStateNetwork(createWooCommerceDio());
//       final response = await service.productList(page: page, perPage: limit);

//       log("API response: ${response.length} products");

//       state = state.copyWith(
//         products: [...state.products, ...response],
//         isLoading: false,
//         hasMore: response.length == limit,
//       );

//       page++;
//     } catch (e) {
//       state = state.copyWith(isLoading: false);
//       log(e.toString());
//     }
//   }
// }

final productListController =
    StateNotifierProvider<
      ProductListNotifier,
      AsyncValue<List<ProductListModel>>
    >((ref) {
      return ProductListNotifier(ref);
    });

class ProductListNotifier
    extends StateNotifier<AsyncValue<List<ProductListModel>>> {
  ProductListNotifier(this.ref) : super(const AsyncValue.loading());

  final Ref ref;

  int page = 1;
  final int limit = 10;
  bool hasMore = true;
  bool isLoading = false;

  Future<void> loadMore({bool refresh = false}) async {
    if (isLoading || !hasMore && !refresh) return;

    if (refresh) {
      page = 1;
      hasMore = true;
      state = const AsyncValue.loading();
    }

    isLoading = true;
    log("API call start: page=$page, limit=$limit");

    try {
      final service = APIStateNetwork(createWooCommerceDio());
      final response = await service.productList(page: page, perPage: limit);

      log("API response: ${response.length} products");

      final current = refresh ? <ProductListModel>[] : (state.value ?? []);

      final updated = [...current, ...response];

      state = AsyncValue.data(updated);

      hasMore = response.length == limit;
      page++;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    } finally {
      isLoading = false;
    }
  }
}
