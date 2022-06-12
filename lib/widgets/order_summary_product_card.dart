import 'package:ecommerce_app/models/models.dart';
import 'package:flutter/material.dart';

class OrderSummaryProductCard extends StatelessWidget {
  final Product product;
  final int quantity;
  const OrderSummaryProductCard({
    Key? key,
    required this.product,
    required this.quantity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Image.network(
            Product.products[0].imageUrl,
            fit: BoxFit.cover,
            height: 80,
            width: 100,
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: textTheme.headline5,
                ),
                Text('Qty. $quantity', style: textTheme.headline6),
              ],
            ),
          ),
          Expanded(
            child: Text(
              '\$${product.price}',
              style: textTheme.headline4,
            ),
          ),
        ],
      ),
    );
  }
}
