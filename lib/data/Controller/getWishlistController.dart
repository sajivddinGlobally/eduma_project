import 'package:eduma_app/config/network/api.state.dart';
import 'package:eduma_app/config/utils/pretty.dio.dart';
import 'package:eduma_app/data/Model/getWishlistModel.dart';
import 'package:riverpod/riverpod.dart';

final getWishlistController = FutureProvider.autoDispose<GetwishlistModel>((
  ref,
) async {
  final service = APIStateNetwork(createDio());
  return await service.fetchWishlist();
});
