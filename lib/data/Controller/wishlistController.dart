import 'package:eduma_app/config/network/api.state.dart';
import 'package:eduma_app/config/utils/pretty.dio.dart';
import 'package:eduma_app/data/Model/wishlistBodyModel.dart';

import 'package:riverpod/riverpod.dart';

class WishliState {
  final bool isLoading;
  final String? successMessage;
  final String? errorMessage;

  const WishliState({
    this.isLoading = false,
    this.successMessage,
    this.errorMessage,
  });

  WishliState copyWith({
    bool? isLoading,
    String? successMessage,
    String? errorMessage,
  }) {
    return WishliState(
      isLoading: isLoading ?? this.isLoading,
      successMessage: successMessage ?? this.successMessage,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  //  @override
  // List<Object?> get props => [isLoading, successMessage, errorMessage];
}

class WishlistNotifier extends StateNotifier<WishliState> {
  WishlistNotifier() : super(WishliState());

  Future<void> addToWishlist(WishlistBodyModel body) async {
    state = state.copyWith(
      isLoading: true,
      successMessage: null,
      errorMessage: null,
    );

    try {
      final serivce = APIStateNetwork(createDio());
      final response = await serivce.wishlist(body);
      if (response != null) {
        state = state.copyWith(
          isLoading: false,
          successMessage: response.message,
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          errorMessage: "Something went wrong",
        );
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }
}

final wishlistNotifierProvider =
    StateNotifierProvider<WishlistNotifier, WishliState>(
      (ref) => WishlistNotifier(),
    );

/// UI me 
///Align(
//   alignment: Alignment.topRight,
//   child: Consumer(
//     builder: (context, ref, _) {
//       final wishlistState = ref.watch(wishlistNotifierProvider);

//       return IconButton(
//         onPressed: wishlistState.isLoading
//             ? null
//             : () {
//                 final body = WishlistBodyModel(
//                   courseId: courseDetails.id,
//                   userId: box.get("storeId"),
//                 );

//                 ref.read(wishlistNotifierProvider.notifier).addToWishlist(body);
//               },
//         icon: Icon(
//           Icons.favorite_border,
//           color: Colors.white,
//           size: 25.sp,
//         ),
//       );
//     },
//   ),
// )



/////  without state


// final wishlistProvider = StateNotifierProvider<WishlistNotifier, bool>(
//   (ref) => WishlistNotifier(),
// );

// class WishlistNotifier extends StateNotifier<bool> {
//   WishlistNotifier() : super(false); // false means not loading

//   Future<void> addToWishlist(WishlistBodyModel body) async {
//     state = true; // loading start
//     try {
//       final service = APIStateNetwork(createDio());
//       final response = await service.wishlist(body);

//       if (response != null) {
//         showSuccessMessage(globalContext, response.message);
//       }
//     } catch (e) {
//       log(e.toString());
//     } finally {
//       state = false; // loading end
//     }
//   }
// }


//// ui me 
// Consumer(
//   builder: (context, ref, _) {
//     final isLoading = ref.watch(wishlistProvider);

//     return IconButton(
//       onPressed: isLoading
//           ? null
//           : () {
//               final body = WishlistBodyModel(
//                 courseId: courseDetails.id,
//                 userId: box.get("storeId"),
//               );
//               ref.read(wishlistProvider.notifier).addToWishlist(body);
//             },
//       icon: Icon(Icons.favorite_border, color: Colors.white),
//     );
//   },
// )