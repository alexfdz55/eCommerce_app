import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_app/models/models.dart';
import 'package:equatable/equatable.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartLoading()) {
    on<CartStarted>((event, emit) async {
      await Future.delayed(const Duration(seconds: 1));
      emit(const CartLoaded());
    });

    on<CartProductAdded>((event, emit) {
      print(event.product.name);
      if (state is CartLoaded) {
        try {
          final cart = Cart(
            products: List.from((state as CartLoaded).cart.products)
              ..add(event.product),
          );
          emit(CartLoaded(cart: cart));
        } catch (_) {}
      }
    });

    on<CartProductRemoved>((event, emit) {
      print(event.product.name);
      if (state is CartLoaded) {
        try {
          final cart = Cart(
            products: List.from((state as CartLoaded).cart.products)
              ..remove(event.product),
          );
          emit(CartLoaded(cart: cart));
        } catch (_) {}
      }
    });
  }
}
