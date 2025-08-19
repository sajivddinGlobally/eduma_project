import 'package:eduma_app/config/network/api.state.dart';
import 'package:eduma_app/config/utils/pretty.dio.dart';
import 'package:eduma_app/data/Model/enrollCourseStudentModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final enrollCourseController = FutureProvider<EnrolleCourseStudentModel>((
  ref,
) async {
  final enrollService = APIStateNetwork(createDio());
  return await enrollService.enrolledCourse();
});
