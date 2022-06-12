import 'dart:io';

import 'package:ecommerce_app/blocs/blocs.dart';
import 'package:ecommerce_app/models/payment_method_model.dart';
import 'package:ecommerce_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay/pay.dart';

class PaymentSelectionScreen extends StatelessWidget {
  const PaymentSelectionScreen({Key? key}) : super(key: key);
  static const String routeName = '/payment-selection';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const PaymentSelectionScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(title: 'Payment Selection'),
      bottomNavigationBar: const CustomNavBar(screen: routeName),
      body: BlocBuilder<PaymentBloc, PaymentState>(
        builder: (context, state) {
          final paymentBloc = BlocProvider.of<PaymentBloc>(context);

          if (state is PaymentLoading) {
            return const CustomCircularProgress();
          }
          if (state is PaymentLoaded) {
            return ListView(
              padding: const EdgeInsets.all(20),
              children: [
                if (Platform.isIOS)
                  RawApplePayButton(
                    style: ApplePayButtonStyle.black,
                    type: ApplePayButtonType.inStore,
                    onPressed: () {
                      paymentBloc.add(
                        const SelectPaymentMethod(
                            paymentMethod: PaymentMethod.applePay),
                      );
                      Navigator.pop(context);
                    },
                  ),
                const SizedBox(height: 10),
                if (Platform.isAndroid)
                  RawGooglePayButton(
                    style: GooglePayButtonStyle.black,
                    type: GooglePayButtonType.pay,
                    onPressed: () {
                      paymentBloc.add(
                        const SelectPaymentMethod(
                            paymentMethod: PaymentMethod.googlePay),
                      );
                      Navigator.pop(context);
                    },
                  ),
                ElevatedButton(
                  onPressed: () {
                    paymentBloc.add(
                      const SelectPaymentMethod(
                          paymentMethod: PaymentMethod.creditCard),
                    );
                    Navigator.pop(context);
                  },
                  child: const Text('Pay with Credit Card'),
                ),
              ],
            );
          } else {
            return const CustomErrorMessage();
          }
        },
      ),
    );
  }
}
