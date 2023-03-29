// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:match/match.dart';

import 'package:dw9_delivery_app/app/dto/order_product_dto.dart';
import 'package:dw9_delivery_app/app/models/payment_type_model.dart';

part 'order_state.g.dart';

@match
enum OrderStatus{
  initial,
  loading,
  loaded,
  error,
  updateOrder, 
  confirmRemoveProduct, 
  emptyBag, successfull
}

class OrderState extends Equatable {
  final OrderStatus status;
  final String? errorMessage;
  final List<OrderProductDto> orderProducts;
  final List<PaymentTypeModel> paymentTypes;
  const OrderState({
    required this.status,
    required this.orderProducts,
    required this.paymentTypes,
    this.errorMessage
  });

  const OrderState.initial() : status = OrderStatus.initial, orderProducts = const [], paymentTypes = const[], errorMessage = null;
  
  @override
  List<Object?> get props => [status, orderProducts, paymentTypes, errorMessage];
  

  OrderState copyWith({
    OrderStatus? status,
    String? errorMessage,
    List<OrderProductDto>? orderProducts,
    List<PaymentTypeModel>? paymentTypes,
  }) {
    return OrderState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      orderProducts: orderProducts ?? this.orderProducts,
      paymentTypes: paymentTypes ?? this.paymentTypes,
    );
  }
}

class OrderConfirmDeleteProductState extends OrderState {
  final OrderProductDto orderProduct;
  final int index;
  const OrderConfirmDeleteProductState({
    required this.orderProduct,
    required this.index,
    required super.status,
    super.errorMessage,
    required super.orderProducts, 
    required super.paymentTypes
  });
  
}
