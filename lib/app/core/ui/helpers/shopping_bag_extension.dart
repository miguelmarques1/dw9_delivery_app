import '../../../dto/order_product_dto.dart';

extension ShoppingBagExtension on List<OrderProductDto> {
  double get totalPrice {
    double price = 0;
    for(var orderProduct in this) {
      price = price + (orderProduct.product.price * orderProduct.amount);
    }
    return price;
  }
}