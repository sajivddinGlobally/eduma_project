import 'package:eduma_app/config/network/api.state.dart';
import 'package:eduma_app/config/utils/pretty.dio.dart';
import 'package:eduma_app/data/Model/createOrderBodyModel.dart';
import 'package:eduma_app/data/Model/createOrderCourseModel.dart';
import 'package:eduma_app/data/Model/orderCreateModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final orderCreateController = FutureProvider.autoDispose<OrderCreateModel>((
  ref,
) async {
  final service = APIStateNetwork(createDio());
  return await service.createOrder({
    "order_id": "order_RJ1cNlhMtLdDRL",
    "amount": 400,
    "currency": "INR",
    "receipt": "rcpt_68cbd94bc43b9",
    "key": "rzp_test_RIeIwZBZ2NZi6w",
    "wc_order_id": 7121,
    "user": {
      "name": "testo6",
      "email": "test05@gmail.com",
      "contact": "768786786786",
    },
  });
});

final courseCreateOrderController =
    FutureProvider.family<
      CreateOrderCourseResModel,
      CreateOrderCourseBodyModel
    >((ref, body) async {
      final service = APIStateNetwork(createDio());
      return await service.courseCreateOrder(body);
    });
