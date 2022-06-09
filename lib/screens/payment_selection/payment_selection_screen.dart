import 'package:ecommerce_app/widgets/widgets.dart';
import 'package:flutter/material.dart';

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
    );
  }
}
