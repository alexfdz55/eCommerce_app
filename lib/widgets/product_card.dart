import 'package:ecommerce_app/blocs/blocs.dart';
import 'package:ecommerce_app/screens/screens.dart';
import 'package:ecommerce_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/models.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final double widthFactor;
  final double leftPosition;
  final bool isWishList;
  const ProductCard({
    Key? key,
    required this.product,
    this.widthFactor = 2.5,
    this.leftPosition = 5,
    this.isWishList = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    // final size = MediaQuery.of(context).size;
    final widthValue = MediaQuery.of(context).size.width / widthFactor;

    return InkWell(
      onTap: () => Navigator.pushNamed(
        context,
        ProductScreen.routeName,
        arguments: product,
      ),
      child: Stack(
        children: [
          SizedBox(
            width: widthValue,
            height: 150,
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 60,
            left: leftPosition,
            child: Container(
              width: widthValue - 5 - leftPosition,
              alignment: Alignment.bottomCenter,
              height: 80,
              decoration: BoxDecoration(color: Colors.black.withAlpha(50)),
            ),
          ),
          Positioned(
            top: 65,
            left: leftPosition + 5,
            child: Container(
              width: widthValue - 15 - leftPosition,
              height: 70,
              decoration: const BoxDecoration(color: Colors.black),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name,
                            style: textTheme.headline5!
                                .copyWith(fontSize: 14, color: Colors.white),
                          ),
                          Text(
                            '\$${product.price}',
                            style: textTheme.headline6!
                                .copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    BlocBuilder<CartBloc, CartState>(
                      builder: (context, state) {
                        if (state is CartLoading) {
                          return const CustomCircularProgress();
                        }
                        if (state is CartLoaded) {
                          return Expanded(
                            child: IconButton(
                              icon: const Icon(
                                Icons.add_circle,
                                color: Colors.white,
                              ),
                              onPressed: () =>
                                  BlocProvider.of<CartBloc>(context).add(
                                CartProductAdded(product),
                              ),
                            ),
                          );
                        } else {
                          return const CustomErrorMessage();
                        }
                      },
                    ),
                    if (isWishList)
                      Expanded(
                        child: IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                          onPressed: () {},
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
