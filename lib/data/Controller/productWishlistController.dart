import 'package:eduma_app/config/network/api.state.dart';
import 'package:eduma_app/config/utils/pretty.dio.dart';
import 'package:eduma_app/data/Model/productWishlistModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productWishlistController =
    FutureProvider.autoDispose<ProductWishlistgetModel>((ref) async {
      final service = APIStateNetwork(createWooCommerceDio());
      return await service.fetchProductWishlist();
    });
