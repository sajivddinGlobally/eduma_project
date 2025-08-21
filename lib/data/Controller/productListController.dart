import 'package:eduma_app/config/network/api.state.dart';
import 'package:eduma_app/config/utils/pretty.dio.dart';
import 'package:eduma_app/data/Model/productListModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productListController = FutureProvider<List<ProductListModel>>((
  ref,
) async {
  final productService = APIStateNetwork(createWooCommerceDio());
  return await productService.productList();
});

// final productListController = FutureProvider<List<ProductListModel>>((
//   ref,
// ) async {
//   final serivce = WooCommerceService();
//   return (await serivce.fetchProducts()).cast<ProductListModel>();
// });
