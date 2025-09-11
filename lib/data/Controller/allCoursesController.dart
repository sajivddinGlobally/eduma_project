import 'dart:developer';

import 'package:eduma_app/config/network/api.state.dart';
import 'package:eduma_app/config/utils/pretty.dio.dart';
import 'package:eduma_app/data/Model/allCoursesModel.dart';
import 'package:riverpod/riverpod.dart';

final allCoursesController = FutureProvider<AllCoursesModel>((ref) async {
  final allCourseService = APIStateNetwork(createDio());
  return await allCourseService.allCourses();
});

class PopularCouserNotifier extends StateNotifier<AsyncValue<AllCoursesModel>> {
  PopularCouserNotifier() : super(AsyncValue.loading());

  int page = 1;
  final int limit = 10;
  bool hasMore = true;
  bool isLoading = false;

  Future<void> loadMoreCourse({bool refresh = false}) async {
    if (refresh) {
      page = 1;
      hasMore = true;
      state = AsyncValue.loading();
    }
    isLoading = true;
    log("API call start : page = $page, limit= $limit");
  }
}
