import 'package:eduma_app/config/network/api.state.dart';
import 'package:eduma_app/config/utils/pretty.dio.dart';
import 'package:eduma_app/data/Model/allCoursesModel.dart';
import 'package:riverpod/riverpod.dart';

final allCoursesController = FutureProvider<AllCoursesModel>((ref) async {
  final allCourseService = APIStateNetwork(createDio());
  return await allCourseService.allCourses(page: 1, perPage: 10);
});

/////////////////////////////
class AllCoursesNotifier extends StateNotifier<AsyncValue<AllCoursesModel>> {
  final APIStateNetwork service;
  int page = 1;
  bool hasMore = true;

  AllCoursesNotifier(this.service) : super(const AsyncValue.loading()) {
    fetchCourses(); // initial load
  }

  Future<void> fetchCourses({bool loadMore = false}) async {
    if (loadMore && !hasMore) return;

    try {
      if (!loadMore) {
        page = 1;
        hasMore = true;
        state = const AsyncValue.loading(); // initial load
      } else {
        page++;
      }

      final response = await service.allCourses(page: page, perPage: 10);

      // ✅ purana data preserve karte hue merge karo
      final oldData = state.value?.data ?? [];
      final newData = response.data;
      final mergedData = loadMore ? [...oldData, ...newData] : newData;

      state = AsyncValue.data(
        AllCoursesModel(
          data: mergedData,
          pagination: response.pagination,
          filters: response.filters,
          summary: response.summary,
          success: response.success,
        ),
      );

      // agar response me list empty aayi to hasMore = false
      if (response.data.isEmpty) {
        hasMore = false;
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final allCoursesProvider =
    StateNotifierProvider<AllCoursesNotifier, AsyncValue<AllCoursesModel>>((
      ref,
    ) {
      final service = APIStateNetwork(createDio());
      return AllCoursesNotifier(service);
    });
