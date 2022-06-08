import 'package:ecommerce_app/models/models.dart';
import 'package:flutter/material.dart';

class CartProductCard extends StatelessWidget {
  final Product product;
  const CartProductCard({Key? key, required this.product}) : super(key: key);

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
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove_circle),
                onPressed: () {},
              ),
              Text('1', style: textTheme.headline5),
              IconButton(
                icon: const Icon(Icons.add_circle),
                onPressed: () {},
              ),
            ],
          )
        ],
      ),
    );
  }
}
