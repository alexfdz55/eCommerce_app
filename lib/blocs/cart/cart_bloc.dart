import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_app/models/models.dart';
import 'package:equatable/equatable.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartLoading()) {
    on<LoadCart>(_onLoadCart);
    on<AddProduct>(_onAddProduct);
    on<RemoveProduct>(_onRemoveProduct);

    // on<CartStarted>((event, emit) async {
    //    emit(CartLoading());
    //   await Future.delayed(const Duration(seconds: 1));
    //   emit(const CartLoaded());
    // });

    // on<CartProductAdded>((event, emit) {
    //   print(event.product.name);
    //   if (state is CartLoaded) {
    //     try {
    //       final cart = Cart(
    //         products: List.from((state as CartLoaded).cart.products)
    //           ..add(event.product),
    //       );
    //       emit(CartLoaded(cart: cart));
    //     } catch (_) {}
    //   }
    // });

    // on<CartProductRemoved>((event, emit) {
    //   print(event.product.name);
    //   if (state is CartLoaded) {
    //     try {
    //       final cart = Cart(
    //         products: List.from((state as CartLoaded).cart.products)
    //           ..remove(event.product),
    //       );
    //       emit(CartLoaded(cart: cart));
    //     } catch (_) {}
    //   }
    // });
  }

  void _onLoadCart(
    LoadCart event,
    Emitter<CartState> emit,
  ) async {
    emit(CartLoading());
    try {
      await Future<void>.delayed(const Duration(seconds: 1));
      emit(const CartLoaded());
    } catch (_) {
      emit(CartError());
    }
  }

  void _onAddProduct(
    AddProduct event,
    Emitter<CartState> emit,
  ) {
    if (state is CartLoaded) {
      try {
        emit(
          CartLoaded(
            cart: Cart(
              products: List.from((state as CartLoaded).cart.products)
                ..add(event.product),
            ),
          ),
        );
      } on Exception {
        emit(CartError());
      }
    }
  }

  void _onRemoveProduct(
    RemoveProduct event,
    Emitter<CartState> emit,
  ) {
    if (state is CartLoaded) {
      try {
        emit(
          CartLoaded(
            cart: Cart(
              products: List.from((state as CartLoaded).cart.products)
                ..remove(event.product),
            ),
          ),
        );
      } on Exception {
        emit(CartError());
      }
    }
  }
}
