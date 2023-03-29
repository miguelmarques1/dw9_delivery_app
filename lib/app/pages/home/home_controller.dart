import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dw9_delivery_app/app/dto/order_product_dto.dart';
import 'package:dw9_delivery_app/app/repositories/products/products_repository.dart';

import 'home_state.dart';



class HomeController extends Cubit<HomeState> {
  final ProductRepository _productsRepository;
  HomeController(this._productsRepository) : super(const HomeState.initial());
  
  Future<void> loadProducts() async {
    try {
      emit(state.copyWith(status: HomeStateStatus.loading));
      final products = await _productsRepository.findAllProducts();
      emit(state.copyWith(status: HomeStateStatus.loaded, products: products));
    } catch(e, s) {
      log('Erro ao buscar produtos', error: e, stackTrace: s);
      emit(state.copyWith(status: HomeStateStatus.error, errorMessage: 'Erro ao buscar produtos'));
    }
  }

  void addOrUpdateBag(OrderProductDto orderProduct) {
    final shoppingBag = [...state.shoppingBag];
    final orderIndex = shoppingBag.indexWhere((orderP) => orderP.product == orderProduct.product);
    if(orderIndex == -1) {
      shoppingBag.add(orderProduct);
    } else {
      if(orderProduct.amount == 0) {
        shoppingBag.removeAt(orderIndex);
      } else {  
        print('Era para cair aqui');
        print(shoppingBag);
        shoppingBag[orderIndex] = orderProduct;
        print(shoppingBag);
      }
    }
    emit(state.copyWith(
      shoppingBag: shoppingBag
    ));
  }

  void updateBag(List<OrderProductDto> updatedBag) {
    emit(state.copyWith(shoppingBag: updatedBag));
    print('Atualizou');
  }
}