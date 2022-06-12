import 'package:ecommerce_app/blocs/blocs.dart';
import 'package:ecommerce_app/models/models.dart';
import 'package:ecommerce_app/screens/screens.dart';
import 'package:ecommerce_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomNavBar extends StatelessWidget {
  final String screen;
  final Product? product;
  const CustomNavBar({
    Key? key,
    required this.screen,
    this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.black,
      child: SizedBox(
        height: 70,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: _selectNavBar(context, screen)!),
      ),
    );
  }

  List<Widget>? _selectNavBar(BuildContext context, String screen) {
    switch (screen) {
      case HomeScreen.routeName:
        return _buildNavBar(context);
      case CatalogScreen.routeName:
        return _buildNavBar(context);
      case WishlistScreen.routeName:
        return _buildNavBar(context);
      case ProductScreen.routeName:
        return _buildAddToCartNavBar(context, product);
      case CartScreen.routeName:
        return _buildGoToCheckoutNavBar(context);
      case CheckoutScreen.routeName:
        return _buildOrderNowNavBar(context);

      default:
        _buildNavBar(context);
    }
    return null;
  }

  List<Widget> _buildNavBar(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.home, color: Colors.white),
        onPressed: () => Navigator.pushNamed(context, HomeScreen.routeName),
      ),
      IconButton(
        icon: const Icon(Icons.shopping_cart, color: Colors.white),
        onPressed: () => Navigator.pushNamed(context, CartScreen.routeName),
      ),
      IconButton(
        icon: const Icon(Icons.person, color: Colors.white),
        onPressed: () => Navigator.pushNamed(context, '/user'),
      ),
    ];
  }

  List<Widget> _buildAddToCartNavBar(BuildContext context, Product? product) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return [
      IconButton(
        icon: const Icon(Icons.share, color: Colors.white),
        onPressed: () {},
      ),
      BlocBuilder<WishlistBloc, WishlistState>(
        builder: (context, state) {
          return IconButton(
              icon: const Icon(Icons.favorite, color: Colors.white),
              onPressed: () {
                BlocProvider.of<WishlistBloc>(context)
                    .add(AddProductToWishlist(product: product!));

                const snackBar = SnackBar(
                  content: Text('Added to your WishList'),
                );

                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              });
        },
      ),
      ElevatedButton(
          style: ElevatedButton.styleFrom(primary: Colors.white),
          child: Text(
            'ADD TO CART',
            style: textTheme.headline3,
          ),
          onPressed: () {
            BlocProvider.of<CartBloc>(context).add(AddProduct(product!));
            Navigator.pushNamed(context, CartScreen.routeName);
          }),
    ];
  }

  List<Widget> _buildGoToCheckoutNavBar(BuildContext context) {
    return [
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          shape: const RoundedRectangleBorder(),
        ),
        child: Text(
          'GO TO CHECKOUT',
          style: Theme.of(context).textTheme.headline3,
        ),
        onPressed: () => Navigator.pushNamed(context, CheckoutScreen.routeName),
      ),
    ];
  }

  List<Widget> _buildOrderNowNavBar(BuildContext context) {
    return [
      BlocBuilder<CheckoutBloc, CheckoutState>(
        builder: (context, state) {
          if (state is CheckoutLoading) {
            return const CustomCircularProgress();
          }
          if (state is CheckoutLoaded) {
            return ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                shape: const RoundedRectangleBorder(),
              ),
              child: Text(
                'ORDER NOW',
                style: Theme.of(context).textTheme.headline3,
              ),
              onPressed: () {
                BlocProvider.of<CheckoutBloc>(context)
                    .add(ConfirmCheckout(checkout: state.checkout));
              },
            );
          } else {
            return const CustomErrorMessage();
          }
        },
      ),
    ];
  }
}
