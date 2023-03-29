import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dw9_delivery_app/app/dto/order_dto.dart';
import 'package:dw9_delivery_app/app/dto/order_product_dto.dart';
import 'package:dw9_delivery_app/app/repositories/order/order_repository.dart';

import 'order_state.dart';

class OrderController extends Cubit<OrderState> {
  final OrderRepository _orderRepository;
  OrderController(this._orderRepository) : super(const OrderState.initial());

  Future<void> load(List<OrderProductDto> products) async {
    try {
      emit(state.copyWith(status: OrderStatus.loading));
      final paymentTypes = await _orderRepository.getAllPaymentsTypes();
      emit(state.copyWith(status: OrderStatus.loaded, orderProducts: products, paymentTypes: paymentTypes));
    } catch(e, s) {
      log('Erro ao carregar página', error: e, stackTrace: s);
      emit(state.copyWith(status: OrderStatus.error, errorMessage: 'Erro ao carregar página'));
    }
  }
  
  void incrementProduct(int index) {
    final orders = [...state.orderProducts];
    final order = orders[index];
    orders[index] = order.copyWith(amount: order.amount + 1);
    emit(state.copyWith(orderProducts: orders, status: OrderStatus.updateOrder));
  }

  void decrementProduct(int index) {
    final orders = [...state.orderProducts];
    final order = orders[index];
    final amount = order.amount;
    print(state.status);
    if(amount == 1) {
      if(state.status != OrderStatus.confirmRemoveProduct) {
        emit(OrderConfirmDeleteProductState(
          orderProduct: order, 
          index: index, 
          status: OrderStatus.confirmRemoveProduct, 
          orderProducts: state.orderProducts,
          paymentTypes: state.paymentTypes
        ));
        return;
      } else {
        orders.removeAt(index);
        emit(state.copyWith(status: OrderStatus.loaded, orderProducts: orders));
      }
      if(orders.isEmpty) {
        emit(state.copyWith(status: OrderStatus.emptyBag));
      }
    } else {
      orders[index] = order.copyWith(amount: order.amount - 1);
    }
    emit(state.copyWith(orderProducts: orders, status: OrderStatus.updateOrder));
  }

  void cancelDeleteProcess() {
    emit(state.copyWith(status: OrderStatus.loaded));
  }

  void clearBag() {
    emit(state.copyWith(status: OrderStatus.emptyBag));
  }

  void saveOrder({required String address, required String document, required int paymentMethodId}) async {
    try {
      emit(state.copyWith(status: OrderStatus.loading));
      await _orderRepository.saveOrder(OrderDto(products: state.orderProducts, address: address, document: document, paymentMethodId: paymentMethodId));
      emit(state.copyWith(status: OrderStatus.successfull));
    } catch(e, s) {
      log('Erro ao registrar pedido', error: e, stackTrace: s);
      emit(state.copyWith(status: OrderStatus.error, errorMessage: 'Erro ao registrar pedido'));
    }
  }
}