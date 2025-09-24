import 'package:eduma_app/config/network/api.state.dart';
import 'package:eduma_app/config/utils/pretty.dio.dart';
import 'package:eduma_app/data/Model/relatedProductModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final relatedProductController =
    FutureProvider.family<List<RelatedProductModel>, String>((ref, id) async {
      final service = APIStateNetwork(createDio());
      return await service.relatedProdut(id);
    });
