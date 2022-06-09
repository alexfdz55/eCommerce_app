import 'package:ecommerce_app/blocs/blocs.dart';
import 'package:ecommerce_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return Scaffold(
      appBar: const CustomAppbar(title: 'Checkout'),
      bottomNavigationBar: const CustomNavBar(screen: routeName),
      body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: BlocBuilder<CheckoutBloc, CheckoutState>(
              builder: (context, state) {
                if (state is CheckoutLoading) {
                  return const CustomCircularProgress();
                }
                if (state is CheckoutLoaded) {
                  final checkoutBloc = BlocProvider.of<CheckoutBloc>(context);

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('CUSTOMER INFORMATION', style: textTheme.headline3),
                      _buildTextFormField(
                        context,
                        'Email',
                        (value) =>
                            checkoutBloc.add(UpdateCheckout(email: value)),
                      ),
                      _buildTextFormField(
                        context,
                        ' Name',
                        (value) =>
                            checkoutBloc.add(UpdateCheckout(fullName: value)),
                      ),
                      Text('DELIVERY INFORMATION', style: textTheme.headline3),
                      _buildTextFormField(
                        context,
                        'Address',
                        (value) =>
                            checkoutBloc.add(UpdateCheckout(address: value)),
                      ),
                      _buildTextFormField(
                        context,
                        'City',
                        (value) =>
                            checkoutBloc.add(UpdateCheckout(city: value)),
                      ),
                      _buildTextFormField(
                        context,
                        'Country',
                        (value) =>
                            checkoutBloc.add(UpdateCheckout(country: value)),
                      ),
                      _buildTextFormField(
                        context,
                        'Zip Code',
                        (value) =>
                            checkoutBloc.add(UpdateCheckout(zipCode: value)),
                      ),
                      Text('ORDER SUMMARY', style: textTheme.headline3),
                      const SizedBox(height: 20),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        alignment: Alignment.bottomCenter,
                        decoration: const BoxDecoration(color: Colors.black),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Center(
                              child: Text(
                                'SELECT A PAYMENT METHOD',
                                style: textTheme.headline3!
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                ))
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      const OrderSummary()
                    ],
                  );
                } else {
                  print(state);
                  return const CustomErrorMessage();
                }
              },
            ),
          )),
    );
  }

  Widget _buildTextFormField(
    BuildContext context,
    String labelText,
    Function(String)? onChanged,
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
              decoration: const InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.only(left: 10),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
              ),
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}
