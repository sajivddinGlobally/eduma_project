import 'package:eduma_app/config/network/api.state.dart';
import 'package:eduma_app/config/utils/pretty.dio.dart';
import 'package:eduma_app/data/Model/orderDetailsModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final orderDetailsController = FutureProvider.family<OrderDetailsModel, String>(
  (ref, id) async {
    final orderDetaislService = APIStateNetwork(createWooCommerceDio());
    return await orderDetaislService.orderDetails(id);
  },
);
