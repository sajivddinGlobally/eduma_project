import 'package:eduma_app/config/network/api.state.dart';
import 'package:eduma_app/config/utils/pretty.dio.dart';
import 'package:eduma_app/data/Model/profileModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final profileController = FutureProvider<ProfileModel>((ref) async {
  final profileService = APIStateNetwork(createDio());
  return await profileService.profile();
});
