import 'dart:async';

import 'package:ecommerce_app/blocs/cart/cart_bloc.dart';
import 'package:ecommerce_app/repositories/checkout/checkout_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_app/models/models.dart';
import 'package:equatable/equatable.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  final CartBloc _cartBloc;
  // final PaymentBloc _paymentBloc;
  final CheckoutRepository _checkoutRepository;
  StreamSubscription? _cartSubscription;
  // StreamSubscription? _paymentSubscription;
  StreamSubscription? _checkoutSubscription;

  CheckoutBloc({
    required CartBloc cartBloc,
    // required PaymentBloc paymentBloc,
    required CheckoutRepository checkoutRepository,
  })  : _cartBloc = cartBloc,
        // _paymentBloc = paymentBloc,
        _checkoutRepository = checkoutRepository,
        super(
          cartBloc.state is CartLoaded
              ? CheckoutLoaded(
                  products: (cartBloc.state as CartLoaded).cart.products,
                  deliveryFee:
                      (cartBloc.state as CartLoaded).cart.deliveryFeeString,
                  subtotal: (cartBloc.state as CartLoaded).cart.subtotalString,
                  total: (cartBloc.state as CartLoaded).cart.totalString,
                )
              : CheckoutLoading(),
        ) {
    on<UpdateCheckout>(_onUpdateCheckout);
    on<ConfirmCheckout>(_onConfirmCheckout);

    _cartSubscription = _cartBloc.stream.listen(
      (state) {
        if (state is CartLoaded) {
          add(UpdateCheckout(cart: state.cart));
        }
      },
    );

    // _paymentSubscription = _paymentBloc.stream.listen((state) {
    //   if (state is PaymentLoaded) {
    //     add(
    //       UpdateCheckout(paymentMethod: state.paymentMethod),
    //     );
    //   }
    // });
  }

  void _onUpdateCheckout(
    UpdateCheckout event,
    Emitter<CheckoutState> emit,
  ) {
    if (state is CheckoutLoaded) {
      final state = this.state as CheckoutLoaded;
      emit(
        CheckoutLoaded(
          email: event.email ?? state.email,
          fullName: event.fullName ?? state.fullName,
          products: event.cart?.products ?? state.products,
          deliveryFee: event.cart?.deliveryFeeString ?? state.deliveryFee,
          subtotal: event.cart?.subtotalString ?? state.subtotal,
          total: event.cart?.totalString ?? state.total,
          address: event.address ?? state.address,
          city: event.city ?? state.city,
          country: event.country ?? state.country,
          zipCode: event.zipCode ?? state.zipCode,
          // paymentMethod: event.paymentMethod ?? state.paymentMethod,
        ),
      );
    }
  }

  void _onConfirmCheckout(
    ConfirmCheckout event,
    Emitter<CheckoutState> emit,
  ) async {
    _checkoutSubscription?.cancel();
    if (state is CheckoutLoaded) {
      try {
        await _checkoutRepository.addCheckout(event.checkout);
        print('Done');
        emit(CheckoutLoading());
      } catch (_) {}
    }
  }

  @override
  Future<void> close() {
    _cartSubscription?.cancel();
    return super.close();
  }
}


// class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
//   final CartBloc _cartBloc;
//   final CheckoutRepository _checkoutRepository;
//   StreamSubscription? _cartSubscription;
//   StreamSubscription? _checkoutSubscription;

//   CheckoutBloc({
//     required CartBloc cartBloc,
//     required CheckoutRepository checkoutRepository,
//   })  : _cartBloc = cartBloc,
//         _checkoutRepository = checkoutRepository,
//         super(cartBloc.state is CartLoaded
//             ? CheckoutLoaded(
//                 products: (cartBloc.state as CartLoaded).cart.products,
//                 subtotal: (cartBloc.state as CartLoaded).cart.subtotalString,
//                 deliveryFee:
//                     (cartBloc.state as CartLoaded).cart.deliveryFeeString,
//                 total: (cartBloc.state as CartLoaded).cart.totalString,
//               )
//             : CheckoutLoading()) {
//     _cartSubscription = cartBloc.stream.listen((state) {
//       if (state is CartLoaded) {
//         add(UpdateCheckout(cart: state.cart));
//       }
//     });
//     on<UpdateCheckout>((event, emit) {
//       if (state is CheckoutLoaded) {
//         final curretState = state as CheckoutLoaded;
//         emit(CheckoutLoaded(
//           email: event.email ?? curretState.email,
//           fullName: event.fullName ?? curretState.fullName,
//           products: event.cart?.products ?? curretState.products,
//           deliveryFee: event.cart?.deliveryFeeString ?? curretState.deliveryFee,
//           subtotal: event.cart?.subtotalString ?? curretState.subtotal,
//           total: event.cart?.totalString ?? curretState.total,
//           address: event.address ?? curretState.address,
//           city: event.city ?? curretState.city,
//           country: event.country ?? curretState.country,
//           zipCode: event.zipCode ?? curretState.zipCode,
//         ));
//       }
//     });

//     on<ConfirmCheckout>((event, emit) async {
//       _checkoutSubscription?.cancel();

//       if (state is CheckoutLoaded) {
//         try {
//           await _checkoutRepository.addCheckout(event.checkout);
//           emit(CheckoutLoading());
//         } catch (_) {}
//       }
//     });
//   }
// }
