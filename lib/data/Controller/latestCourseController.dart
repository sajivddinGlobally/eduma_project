import 'package:eduma_app/config/network/api.state.dart';
import 'package:eduma_app/config/utils/pretty.dio.dart';
import 'package:eduma_app/data/Model/latestCourseModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final latestCourseController = FutureProvider<LatestCourseModel>((ref) async {
  final lateserCourseService = APIStateNetwork(createDio());
  return await lateserCourseService.latestCourse();
});
