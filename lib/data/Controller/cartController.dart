import 'package:eduma_app/config/network/api.state.dart';
import 'package:eduma_app/config/utils/pretty.dio.dart';
import 'package:eduma_app/data/Model/cartModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cartController = FutureProvider.autoDispose<CartModel>((ref) async {
  final cartService = APIStateNetwork(createDio());
  return await cartService.cartlist();
});
