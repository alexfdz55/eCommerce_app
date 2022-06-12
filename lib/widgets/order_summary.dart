import 'package:ecommerce_app/blocs/blocs.dart';
import 'package:ecommerce_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderSummary extends StatelessWidget {
  const OrderSummary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final size = MediaQuery.of(context).size;

    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoading) {
          return const CustomCircularProgress();
        }

        if (state is CartLoaded) {
          return Column(
            children: [
              const Divider(thickness: 2),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
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
                        Text('DELIVERY FEE', style: textTheme.headline5),
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
                    decoration:
                        BoxDecoration(color: Colors.black.withAlpha(50)),
                  ),
                  Container(
                    width: size.width,
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    height: 50,
                    decoration: const BoxDecoration(color: Colors.black),
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
          );
        } else {
          return const CustomErrorMessage();
        }
      },
    );
  }
}
