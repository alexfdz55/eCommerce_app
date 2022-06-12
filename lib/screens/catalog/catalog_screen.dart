import 'package:ecommerce_app/models/models.dart';
import 'package:ecommerce_app/widgets/widgets.dart';
import 'package:flutter/material.dart';

class CatalogScreen extends StatelessWidget {
  final Category category;
  const CatalogScreen({Key? key, required this.category}) : super(key: key);

  static const String routeName = '/catalog';

  static Route route({required Category category}) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => CatalogScreen(category: category),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Product> categoryProducts = Product.products
        .where((product) => product.category == category.name)
        .toList();

    return Scaffold(
      appBar: const CustomAppbar(title: 'Catalog'),
      bottomNavigationBar: const CustomNavBar(screen: routeName),
      body: GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.15,
        ),
        itemCount: categoryProducts.length,
        itemBuilder: (_, index) => Center(
          child: ProductCard.catalog(product: categoryProducts[index]),
        ),
      ),
    );
  }
}
