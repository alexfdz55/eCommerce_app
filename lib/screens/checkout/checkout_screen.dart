import 'package:ecommerce_app/blocs/blocs.dart';
import 'package:ecommerce_app/screens/screens.dart';
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
                      CustomTextFormField(
                        labelText: 'Email',
                        onChanged: (value) => checkoutBloc.add(
                          UpdateCheckout(email: value),
                        ),
                      ),
                      CustomTextFormField(
                        labelText: ' Name',
                        onChanged: (value) => checkoutBloc.add(
                          UpdateCheckout(fullName: value),
                        ),
                      ),
                      Text('DELIVERY INFORMATION', style: textTheme.headline3),
                      CustomTextFormField(
                        labelText: 'Address',
                        onChanged: (value) => checkoutBloc.add(
                          UpdateCheckout(address: value),
                        ),
                      ),
                      CustomTextFormField(
                        labelText: 'City',
                        onChanged: (value) => checkoutBloc.add(
                          UpdateCheckout(city: value),
                        ),
                      ),
                      CustomTextFormField(
                        labelText: 'Country',
                        onChanged: (value) => checkoutBloc.add(
                          UpdateCheckout(country: value),
                        ),
                      ),
                      CustomTextFormField(
                        labelText: 'Zip Code',
                        onChanged: (value) => checkoutBloc.add(
                          UpdateCheckout(zipCode: value),
                        ),
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
                              child: TextButton(
                                child: Text(
                                  'SELECT A PAYMENT METHOD',
                                  style: textTheme.headline3!
                                      .copyWith(color: Colors.white),
                                ),
                                onPressed: () => Navigator.pushNamed(
                                  context,
                                  PaymentSelectionScreen.routeName,
                                ),
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
                  return const CustomErrorMessage();
                }
              },
            ),
          )),
    );
  }
}
