import 'package:eduma_app/config/network/api.state.dart';
import 'package:eduma_app/config/utils/pretty.dio.dart';
import 'package:eduma_app/data/Model/notificationModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final notifcationController = FutureProvider.family
    .autoDispose<List<NotificationModel>, String>((ref, id) async {
      final service = APIStateNetwork(createDio());
      return await service.notification(id);
    });
