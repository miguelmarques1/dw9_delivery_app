import 'package:dw9_delivery_app/app/pages/home/home_controller.dart';
import 'package:dw9_delivery_app/app/repositories/products/products_repository.dart';
import 'package:dw9_delivery_app/app/repositories/products/products_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/rest/custom_dio.dart';
import 'home_page.dart';

class HomeRouter {
  HomeRouter._();

  static Widget get page => MultiProvider(
    providers: [
      Provider<ProductRepository>(create: (context) => ProductsRepositoryImpl(dio: context.read<CustomDio>())),
      Provider(create: (context) => HomeController(context.read<ProductRepository>()))
    ],
    child: const HomePage(),
  );
}