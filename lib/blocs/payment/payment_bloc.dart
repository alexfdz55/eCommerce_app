import 'package:ecommerce_app/models/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc() : super(PaymentLoading()) {
    on<LoadPaymentMethod>((event, emit) {
      emit(const PaymentLoaded());
    });

    on<SelectPaymentMethod>((event, emit) {
      emit(PaymentLoaded(paymentMethod: event.paymentMethod));
    });
  }
}
