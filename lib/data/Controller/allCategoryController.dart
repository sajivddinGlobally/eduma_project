import 'package:eduma_app/config/network/api.state.dart';
import 'package:eduma_app/config/utils/pretty.dio.dart';
import 'package:eduma_app/data/Model/allCategoryModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final allCategoryController = FutureProvider<AllCategoryModel>((ref) async {
  final allCategoryService = APIStateNetwork(createDio());
  return await allCategoryService.allCategory();
});
