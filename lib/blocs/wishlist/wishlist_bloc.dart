import 'package:ecommerce_app/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistLoading()) {
    on<StartWishlist>((event, emit) async {
      await Future.delayed(const Duration(seconds: 1));
      try {
        emit(const WishlistLoaded());
      } catch (_) {}
    });

    on<AddWishlistProduct>((event, emit) {
      if (state is WishlistLoaded) {
        final currentState = state as WishlistLoaded;
        try {
          emit(
            WishlistLoaded(
              wishlist: Wishlist(
                products: List.from(currentState.wishlist.products)
                  ..add(event.product),
              ),
            ),
          );
        } catch (_) {}
      }
    });

    on<RemoveWishlistProduct>((event, emit) {
      if (state is WishlistLoaded) {
        final currentState = state as WishlistLoaded;
        try {
          emit(
            WishlistLoaded(
              wishlist: Wishlist(
                products: List.from(currentState.wishlist.products)
                  ..remove(event.product),
              ),
            ),
          );
        } catch (_) {}
      }
    });
  }
}
