import 'package:eduma_app/config/network/api.state.dart';
import 'package:eduma_app/config/utils/pretty.dio.dart';
import 'package:eduma_app/data/Model/notificationModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final notifcationController = FutureProvider.family
    .autoDispose<List<NotificationModel>, String>((ref, id) async {
      final service = APIStateNetwork(createDio());
      return await service.notification(id);
    });

/////////////////////////////////////////////

// class NotificationState {
//   final int unreadCount;
//   NotificationState({required this.unreadCount});

//   NotificationState copyWith({int? unreadCount}) {
//     return NotificationState(unreadCount: unreadCount ?? this.unreadCount);
//   }
// }

// class NotificationNotifier extends StateNotifier<NotificationState> {
//   NotificationNotifier() : super(NotificationState(unreadCount: 0));

//   void setUnread(int count) {
//     state = state.copyWith(unreadCount: count);
//   }

//   void resetUnread() {
//     state = state.copyWith(unreadCount: 0);
//   }
// }

// final showNotification =
//     StateNotifierProvider<NotificationNotifier, NotificationState>(
//       (ref) => NotificationNotifier(),
//     );

class NotificationState {
  final int unreadCount;
  final bool
  isNotificationPageOpen; // नया फ्लैग जो ट्रैक करेगा कि NotificationPage खुला है या नहीं
  NotificationState({
    required this.unreadCount,
    this.isNotificationPageOpen = false,
  });

  NotificationState copyWith({int? unreadCount, bool? isNotificationPageOpen}) {
    return NotificationState(
      unreadCount: unreadCount ?? this.unreadCount,
      isNotificationPageOpen:
          isNotificationPageOpen ?? this.isNotificationPageOpen,
    );
  }
}

class NotificationNotifier extends StateNotifier<NotificationState> {
  NotificationNotifier() : super(NotificationState(unreadCount: 0));

  void setUnread(int count) {
    // केवल तभी अपडेट करें जब NotificationPage खुला न हो
    if (!state.isNotificationPageOpen) {
      state = state.copyWith(unreadCount: count);
    }
  }

  void resetUnread() {
    state = state.copyWith(unreadCount: 0, isNotificationPageOpen: true);
  }

  void leaveNotificationPage() {
    state = state.copyWith(isNotificationPageOpen: false);
  }
}

final showNotification =
    StateNotifierProvider<NotificationNotifier, NotificationState>(
      (ref) => NotificationNotifier(),
    );
