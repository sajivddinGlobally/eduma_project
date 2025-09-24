import 'package:eduma_app/config/network/api.state.dart';
import 'package:eduma_app/config/utils/pretty.dio.dart';
import 'package:eduma_app/data/Model/orderListModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final orderListController = FutureProvider.family<List<OrderListModel>,String>((ref, id) async {
  final orderService = APIStateNetwork(createWooCommerceDio());
  return  await orderService.order(id);
});
