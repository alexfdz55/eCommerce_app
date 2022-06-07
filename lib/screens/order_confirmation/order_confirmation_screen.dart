import 'package:ecommerce_app/widgets/widgets.dart';
import 'package:flutter/material.dart';

class OrderConfirmationScreen extends StatelessWidget {
  const OrderConfirmationScreen({Key? key}) : super(key: key);

  static const String routeName = '/order-confirmation';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const OrderConfirmationScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(title: 'OrderConfirmation'),
      bottomNavigationBar: CustomNavBar(),
    );
  }
}
