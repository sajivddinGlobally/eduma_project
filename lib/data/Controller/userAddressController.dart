import 'package:eduma_app/config/network/api.state.dart';
import 'package:eduma_app/config/utils/pretty.dio.dart';
import 'package:eduma_app/data/Model/userAddressResModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userAddressController = FutureProvider<UserAddressResModel>((ref) async {
  final service = APIStateNetwork(createDio());
  return await service.fetchAddress();
});
