import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// final updateProfileController =
//     FutureProvider.family<UpdateProfileResModel, UpdateProfileBodyModel>((
//       ref,
//       body,
//     ) async {
//       final serivce = APIStateNetwork(createDio());
//       return await serivce.updateProfile(body);
//     });

mixin UpdateProfile<T extends ConsumerStatefulWidget> on ConsumerState<T> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final bioController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final countryController = TextEditingController();
  final addressController = TextEditingController();

  Future<void> updateProfile() async {}
}
