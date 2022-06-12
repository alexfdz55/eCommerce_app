import 'package:hive/hive.dart';

import 'package:ecommerce_app/models/product_model.dart';

import 'base_local_storage_repository.dart';

class LocalStorageRepository extends BaseLocalStorageRepository {
  final String _boxName = 'wishlist_products';

  @override
  Future<Box> openBox() async {
    return await Hive.openBox<Product>(_boxName);
  }

  @override
  List<Product> getWishlist(Box box) {
    return box.values.toList() as List<Product>;
  }

  @override
  Future<void> addProductToWishlist(Box box, Product product) async {
    await box.put(product.id, product);
  }

  @override
  Future<void> removeProductFromWishlist(Box box, Product product) async {
    await box.delete(product.id);
  }

  @override
  Future<void> clearWishlist(Box box) async {
    await box.clear();
  }
}
