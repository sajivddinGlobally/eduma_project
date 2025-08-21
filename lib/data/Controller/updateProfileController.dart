import 'package:eduma_app/config/network/api.state.dart';
import 'package:eduma_app/config/utils/pretty.dio.dart';
import 'package:eduma_app/data/Model/updateProfileBodyModel.dart';
import 'package:eduma_app/data/Model/updateProfileResModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final updateProfileController =
    FutureProvider.family<UpdateProfileResModel, UpdateProfileBodyModel>((
      ref,
      body,
    ) async {
      final serivce = APIStateNetwork(createDio());
      return await serivce.updateProfile(body);
    });

mixin UpdateProfile<T extends ConsumerStatefulWidget> on ConsumerState<T> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final bioController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final addressController = TextEditingController();
  

  Future<void> updateProfile() async {}
}
