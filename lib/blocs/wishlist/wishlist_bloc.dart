import 'package:ecommerce_app/models/models.dart';
import 'package:ecommerce_app/repositories/repositories.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  final LocalStorageRepository _localStorageRepository;

  WishlistBloc({required LocalStorageRepository localStorageRepository})
      : _localStorageRepository = localStorageRepository,
        super(WishlistLoading()) {
    on<LoadWishlist>((event, emit) async {
      emit(WishlistLoading());
      await Future.delayed(const Duration(seconds: 1));
      try {
        Box box = await _localStorageRepository.openBox();
        List<Product> products = _localStorageRepository.getWishlist(box);

        emit(WishlistLoaded(wishlist: Wishlist(products: products)));
      } on Exception {
        emit(WishlistError());
      }
    });

    on<AddProductToWishlist>((event, emit) async {
      if (state is WishlistLoaded) {
        final currentState = state as WishlistLoaded;
        try {
          Box box = await _localStorageRepository.openBox();
          _localStorageRepository.addProductToWishlist(box, event.product);
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

    on<RemoveProductFromWishlist>((event, emit) async {
      if (state is WishlistLoaded) {
        final currentState = state as WishlistLoaded;
        try {
          Box box = await _localStorageRepository.openBox();
          _localStorageRepository.removeProductFromWishlist(box, event.product);

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
