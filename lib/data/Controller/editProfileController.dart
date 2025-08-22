// import 'package:dio/dio.dart';
// import 'package:eduma_app/config/network/api.state.dart';
// import 'package:eduma_app/config/utils/pretty.dio.dart';
// import 'package:eduma_app/data/Model/updateProfileBodyModel.dart';
// import 'package:eduma_app/data/Model/updateProfileResModel.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:retrofit/retrofit.dart';

// final updateProfleControllr =
//     FutureProvider.family<UpdateProfileResModel, UpdateProfileBodyModel>((
//       ref,
//       body,
//     ) async {
//       final serivce = APIStateNetwork(createDio());
//       return await serivce.updateProfile(
//         body.firstName.toString(),
//         body.lastName,
//         body.displayName,
//         body.email,
//         body.phone,
//         body.bio,
//         body.address,
//         body.city,
//         body.state,
//         body.country,
//         body.postalCode,
//         body.avatarUrl != null && body.avatarUrl.isNotEmpty
//             ? await MultipartFile.fromFile(body.avatarUrl)
//             : null,
//       );
//     });
