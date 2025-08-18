import 'package:eduma_app/config/network/api.state.dart';
import 'package:eduma_app/config/utils/pretty.dio.dart';
import 'package:eduma_app/data/Model/orderListModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final orderListController = FutureProvider<List<OrderListModel>>((ref) async {
  final orderService = APIStateNetwork(createWooCommerceDio());
  return  await orderService.order();
});
