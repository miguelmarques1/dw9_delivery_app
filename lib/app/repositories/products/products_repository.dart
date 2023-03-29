import 'package:dw9_delivery_app/app/models/product_model.dart';

abstract class ProductRepository {
  Future<List<ProductModel>> findAllProducts();
}