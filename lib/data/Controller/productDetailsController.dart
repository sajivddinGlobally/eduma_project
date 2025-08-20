import 'package:eduma_app/config/network/api.state.dart';
import 'package:eduma_app/config/utils/pretty.dio.dart';
import 'package:eduma_app/data/Model/productDetailsModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productDetailsController =
    FutureProvider.family<ProductDetailsModel, String>((ref, id) async {
      final service = APIStateNetwork(createWooCommerceDio());
      return await service.productDetails(id);
    });
