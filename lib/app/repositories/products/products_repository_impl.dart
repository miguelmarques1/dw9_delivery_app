
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dw9_delivery_app/app/core/rest/custom_dio.dart';
import 'package:dw9_delivery_app/app/models/product_model.dart';
import 'package:dw9_delivery_app/app/repositories/products/products_repository.dart';

import '../../core/exceptions/repository_exception.dart';

class ProductsRepositoryImpl implements ProductRepository {
  final CustomDio dio;
  ProductsRepositoryImpl({required this.dio});

  @override
  Future<List<ProductModel>> findAllProducts() async {
    try {
      final result = await dio.unauth().get('/products');
      return result.data.map<ProductModel>((product) => ProductModel.fromMap(product)).toList();
    } on DioError catch(e, s) {
      log('Erro ao buscar produtos', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao buscar produtos');
    }
  }
  
}