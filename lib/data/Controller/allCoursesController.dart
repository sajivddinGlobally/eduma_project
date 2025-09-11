import 'package:eduma_app/config/network/api.state.dart';
import 'package:eduma_app/config/utils/pretty.dio.dart';
import 'package:eduma_app/data/Model/allCoursesModel.dart';
import 'package:riverpod/riverpod.dart';

final allCoursesController = FutureProvider<AllCoursesModel>((ref) async {
  final allCourseService = APIStateNetwork(createDio());
  return await allCourseService.allCourses();
});





class PopularCouserNotifier extends StateNotifier<AsyncValue<AllCoursesModel>> {
  
