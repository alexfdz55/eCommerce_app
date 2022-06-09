import 'dart:async';

import 'package:ecommerce_app/models/product_model.dart';
import 'package:ecommerce_app/repositories/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository _productRepository;
  StreamSubscription? _productSubscription;

  ProductBloc({required ProductRepository productRepository})
      : _productRepository = productRepository,
        super(ProductLoading()) {
    on<LoadProducts>((event, emit) {
      _productSubscription?.cancel();
      _productSubscription =
          _productRepository.getAllProducts().listen((products) {
        add(UpdateProducts(products));
      });
    });

    on<UpdateProducts>((event, emit) {
      emit(ProductLoaded(products: event.products));
    });
  }
}
