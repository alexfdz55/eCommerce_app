import 'package:ecommerce_app/blocs/blocs.dart';
import 'package:ecommerce_app/models/models.dart';
import 'package:ecommerce_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  static const String routeName = '/cart';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const CartScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: const CustomAppbar(title: 'Cart'),
      bottomNavigationBar: SizedBox(
        height: 70,
        child: BottomAppBar(
          color: Colors.black,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.white),
                child: Text(
                  'GO TO CHECKOUT',
                  style: textTheme.headline3,
                ),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return const CustomCircularProgress();
          }

          if (state is CartLoaded) {
            print('Cart lenth: ${state.cart.products.length}');
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            state.cart.freeDeliverString,
                            style: textTheme.headline5,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.black,
                                shape: const RoundedRectangleBorder(),
                                elevation: 0),
                            child: Text(
                              'Add More Items',
                              style: textTheme.headline5!
                                  .copyWith(color: Colors.white),
                            ),
                            onPressed: () => Navigator.pushNamed(context, '/'),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 400,
                        child: ListView.builder(
                          itemCount: state.cart
                              .productQuantity(state.cart.products)
                              .keys
                              .length,
                          itemBuilder: (_, index) => CartProductCard(
                            product: state.cart
                                .productQuantity(state.cart.products)
                                .keys
                                .elementAt(index),
                            quantity: state.cart
                                .productQuantity(state.cart.products)
                                .values
                                .elementAt(index),
                          ),
                        ),
                      ),
                      // CartProductCard(product: Product.products[0]),
                      // CartProductCard(product: Product.products[1]),
                      // CartProductCard(product: Product.products[3]),
                    ],
                  ),
                  Column(
                    children: [
                      const Divider(thickness: 2),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 10),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('SUBTOTAL', style: textTheme.headline5),
                                Text('\$${state.cart.subtotalString}',
                                    style: textTheme.headline5),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('DELIVERY FEE',
                                    style: textTheme.headline5),
                                Text('\$${state.cart.deliveryFeeString}',
                                    style: textTheme.headline5),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Stack(
                        children: [
                          Container(
                            width: size.width,
                            height: 60,
                            decoration: BoxDecoration(
                                color: Colors.black.withAlpha(50)),
                          ),
                          Container(
                            width: size.width,
                            margin: const EdgeInsets.all(5),
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            height: 50,
                            decoration:
                                const BoxDecoration(color: Colors.black),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('TOTAL',
                                    style: textTheme.headline5!
                                        .copyWith(color: Colors.white)),
                                Text('\$${state.cart.totalString}',
                                    style: textTheme.headline5!
                                        .copyWith(color: Colors.white)),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            );
          } else {
            return const CustomErrorMessage();
          }
        },
      ),
    );
  }
}
