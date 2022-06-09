import 'package:ecommerce_app/widgets/widgets.dart';
import 'package:flutter/material.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  static const String routeName = '/checkout';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const CheckoutScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final emailTextCtrl = TextEditingController();
    final nameTextCtrl = TextEditingController();
    final addressTextCtrl = TextEditingController();
    final cityTextCtrl = TextEditingController();
    final countryTextCtrl = TextEditingController();
    final zipCodeTextCtrl = TextEditingController();

    return Scaffold(
      appBar: const CustomAppbar(title: 'Checkout'),
      bottomNavigationBar: const CustomNavBar(screen: routeName),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('CUSTOMER INFORMATION', style: textTheme.headline3),
            _buildTextFormField(emailTextCtrl, context, 'Email'),
            _buildTextFormField(nameTextCtrl, context, ' Name'),
            Text('DELIVERY INFORMATION', style: textTheme.headline3),
            _buildTextFormField(addressTextCtrl, context, 'Address'),
            _buildTextFormField(cityTextCtrl, context, 'City'),
            _buildTextFormField(countryTextCtrl, context, 'Country'),
            _buildTextFormField(zipCodeTextCtrl, context, 'Zip Code'),
            Text('ORDER SUMMARY', style: textTheme.headline3),
            const OrderSummary()
          ],
        ),
      ),
    );
  }

  Widget _buildTextFormField(
    TextEditingController controller,
    BuildContext context,
    String labelText,
  ) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          SizedBox(
              width: 75, child: Text(labelText, style: textTheme.bodyText1)),
          Expanded(
              child: TextFormField(
            controller: controller,
            decoration: const InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.only(left: 10),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)),
            ),
          ))
        ],
      ),
    );
  }
}
