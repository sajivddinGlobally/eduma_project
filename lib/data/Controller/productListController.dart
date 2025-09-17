import 'package:eduma_app/config/network/api.state.dart';
import 'package:eduma_app/config/utils/pretty.dio.dart';
import 'package:eduma_app/data/Model/productBooksModel.dart';
import 'package:eduma_app/data/Model/productInstrumentModel.dart';
import 'package:riverpod/riverpod.dart';

final productListBooksController = FutureProvider<List<ProductBookModel>>((
  ref,
) async {
  final service = APIStateNetwork(createDio());
  return await service.fetchProductBooks();
});

final productListInstrumentController =
    FutureProvider<List<ProductInstrumentModel>>((ref) async {
      final service = APIStateNetwork(createDio());
      return await service.fetchProductInstrument();
    });
