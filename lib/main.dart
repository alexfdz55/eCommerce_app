import 'package:ecommerce_app/blocs/blocs.dart';
import 'package:ecommerce_app/repositories/repositories.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'config/app_router.dart';
import 'config/theme.dart';
import '/screens/screens.dart';
import 'simple_bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  BlocOverrides.runZoned(
    () {
      runApp(const MyApp());
    },
    blocObserver: SimpleBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        // RepositoryProvider(create: (context) => CategoryRepository()),
        RepositoryProvider(create: (context) => ProductRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => CartBloc()..add(LoadCart())),
          BlocProvider(
              create: (context) => CheckoutBloc(
                    cartBloc: BlocProvider.of<CartBloc>(context),
                    checkoutRepository: CheckoutRepository(),
                  )),
          BlocProvider(
            create: (_) =>
                CategoryBloc(categoryRepository: CategoryRepository())
                  ..add(LoadCategories()),
          ),
          BlocProvider(
            create: (_) => ProductBloc(productRepository: ProductRepository())
              ..add(LoadProducts()),
          ),
          BlocProvider(create: (_) => WishlistBloc()..add(LoadWishlist())),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Material App',
          theme: theme(),
          onGenerateRoute: AppRouter.onGenerateRoute,
          initialRoute: HomeScreen.routeName,
        ),
      ),
    );
  }
}
