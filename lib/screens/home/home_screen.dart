import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_app/models/models.dart';
import 'package:ecommerce_app/widgets/widgets.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const String routeName = '/';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const HomeScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: const CustomAppbar(title: 'Zero to Unicorn'),
      bottomNavigationBar: const CustomNavBar(),
      body: Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              aspectRatio: 1.5,
              viewportFraction: 0.9,
              enlargeCenterPage: true,
              enlargeStrategy: CenterPageEnlargeStrategy.height,
            ),
            items: Category.categories
                .map((category) => HeroCarouselCard(category: category))
                .toList(),
          ),
          const SectionTitle(title: 'RECOMMENDED'),
          ProductCarousel(
            products: Product.products
                .where((product) => product.isRecommended)
                .toList(),
          ),
          const SectionTitle(title: 'MOST POPULAR'),
          ProductCarousel(
            products:
                Product.products.where((product) => product.isPopular).toList(),
          ),
        ],
      ),
    );
  }
}
