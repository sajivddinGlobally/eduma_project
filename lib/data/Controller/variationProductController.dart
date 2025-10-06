import 'package:eduma_app/config/network/api.state.dart';
import 'package:eduma_app/config/utils/pretty.dio.dart';
import 'package:eduma_app/data/Model/variationResModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final variationProductController =
    FutureProvider.family<List<VariationResModel>, String>((ref, id) async {
      final service = APIStateNetwork(createWooCommerceDio());
      return await service.variationProduct(id);
    });
