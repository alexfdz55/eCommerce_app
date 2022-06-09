import 'package:ecommerce_app/blocs/blocs.dart';
import 'package:ecommerce_app/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartProductCard extends StatelessWidget {
  final Product product;
  final int quantity;
  const CartProductCard({
    Key? key,
    required this.product,
    required this.quantity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Image.network(
            product.imageUrl,
            width: 100,
            height: 80,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.name, style: textTheme.headline5),
                Text('\$${product.price}', style: textTheme.headline6),
              ],
            ),
          ),
          const SizedBox(width: 10),
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              final cartBloc = BlocProvider.of<CartBloc>(context);
              return Row(
                children: [
                  IconButton(
                      icon: const Icon(Icons.remove_circle),
                      onPressed: () {
                        const snackBar = SnackBar(
                          content: Text('Removed to your Cart'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        cartBloc.add(CartProductRemoved(product));
                      }),
                  Text('$quantity', style: textTheme.headline5),
                  IconButton(
                      icon: const Icon(Icons.add_circle),
                      onPressed: () {
                        const snackBar = SnackBar(
                          content: Text('Added to your Cart'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);

                        cartBloc.add(CartProductAdded(product));
                      }),
                ],
              );
            },
          )
        ],
      ),
    );
  }
}
