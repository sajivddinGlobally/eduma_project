import 'dart:developer';

import 'package:eduma_app/config/network/api.state.dart';
import 'package:eduma_app/config/utils/pretty.dio.dart';
import 'package:eduma_app/data/Model/calculateDynamicBodyModel.dart';
import 'package:eduma_app/data/Model/calculateDynamicResModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CalculateDynamicController
    extends StateNotifier<AsyncValue<CalculateDynamicResModel?>> {
  CalculateDynamicController() : super(AsyncValue.data(null));

  Future<void> calculateDyanmicAmmount({required String stateName}) async {
    try {
      state = AsyncValue.loading();
      final body = CalculateDynamicBodyModel(state: stateName);
      final service = APIStateNetwork(createDio());
      final response = await service.calculateDynamicAmount(body);
      if (response != null) {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     content: Text("C"),
        //     backgroundColor: Colors.red,
        //     duration: const Duration(seconds: 3),
        //   ),
        // );
      }
      state = AsyncValue.data(response);
    } catch (e, st) {
      log(e.toString());
      state = AsyncValue.error(e, st);
    }
  }
}

final calculateDynamicProvider =
    StateNotifierProvider<
      CalculateDynamicController,
      AsyncValue<CalculateDynamicResModel?>
    >((ref) {
      return CalculateDynamicController();
    });
