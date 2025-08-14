import 'package:eduma_app/config/network/api.state.dart';
import 'package:eduma_app/config/utils/pretty.dio.dart';
import 'package:eduma_app/data/Model/instructorModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final instructorController = FutureProvider<List<InstructorModel>>((ref) async {
  final service = APIStateNetwork(createDio());
  return await service.instructor();
});
