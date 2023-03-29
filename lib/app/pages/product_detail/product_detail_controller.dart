
import 'package:bloc/bloc.dart';
import 'package:dw9_delivery_app/app/dto/order_product_dto.dart';

class ProductDetailController extends Cubit<int> {
  late final bool _hasOrder; 
  ProductDetailController() : super(1);

  void initial(bool hasOrder, int amount) {
    _hasOrder = hasOrder;
    emit(amount);
  }

  void increment() => emit(state + 1);
  void decrement() {
    if(state > (_hasOrder ? 0 : 1)) emit(state - 1);
  }
}