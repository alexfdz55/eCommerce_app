import 'package:ecommerce_app/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistLoading()) {
    on<LoadWishlist>((event, emit) async {
      emit(WishlistLoading());
      await Future.delayed(const Duration(seconds: 1));
      try {
        emit(const WishlistLoaded());
      } on Exception {
        emit(WishlistError());
      }
    });

    on<AddProductToWishlist>((event, emit) {
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
        } on Exception {
          emit(WishlistError());
        }
      }
    });

    on<RemoveProductFromWishlist>((event, emit) {
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
        } on Exception {
          emit(WishlistError());
        }
      }
    });
  }
}
