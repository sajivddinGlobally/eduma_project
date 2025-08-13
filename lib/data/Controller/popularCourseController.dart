import 'package:eduma_app/config/network/api.state.dart';
import 'package:eduma_app/config/utils/pretty.dio.dart';
import 'package:eduma_app/data/Model/popularCourseDetailsModel.dart';
import 'package:eduma_app/data/Model/popularCourseModel.dart';
import 'package:riverpod/riverpod.dart';

final popularCourseController = FutureProvider<List<PopularCourseModel>>((
  ref,
) async {
  final courseSevice = APIStateNetwork(createDio());
  return await courseSevice.popularCourse();
});

final popularCourseDetailsController =
    FutureProvider.family<List<PopularCourseDetailsModel>, String>((
      ref,
      id,
    ) async {
      final courseDetailService = APIStateNetwork(createDio());
      return await courseDetailService.popularCourseDetails(id);
    });
