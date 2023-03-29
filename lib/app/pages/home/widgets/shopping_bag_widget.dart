import 'package:dw9_delivery_app/app/core/extensions/formatter_extension.dart';
import 'package:dw9_delivery_app/app/core/ui/helpers/shopping_bag_extension.dart';
import 'package:dw9_delivery_app/app/core/ui/helpers/size_extensions.dart';
import 'package:dw9_delivery_app/app/core/ui/styles/text_styles.dart';
import 'package:dw9_delivery_app/app/dto/order_product_dto.dart';
import 'package:dw9_delivery_app/app/pages/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShoppingBagWidget extends StatelessWidget {
  final List<OrderProductDto> shoppingBag;
  const ShoppingBagWidget({ super.key, required this.shoppingBag });

  Future<void> _goOrder(BuildContext context) async {
    final navigator = Navigator.of(context);
    final controller = context.read<HomeController>();
    final sp = await SharedPreferences.getInstance();
    if(!sp.containsKey('accessToken')) {
      final loginResult = await navigator.pushNamed('/auth/login');
      if(loginResult == null || loginResult == false) {
        return;
      }
    }
    final updatedBag = await navigator.pushNamed('/order', arguments: shoppingBag);
    controller.updateBag(updatedBag as List<OrderProductDto>);
  }

   @override
   Widget build(BuildContext context) {
       return Container(
                  width: context.screenWidth,
                  height: 65,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow:  [
                      BoxShadow(color: Colors.black26, blurRadius: 5)
                    ],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)
                    )
                  ),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: ElevatedButton(
                    onPressed: () {
                      _goOrder(context);
                    },
                    child: Stack(
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Icon(Icons.shopping_cart_outlined, 
                          color: Colors.white,
                          )
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text('Ver sacola',
                            style: context.textStyles.textExtraBold.copyWith(
                              color: Colors.white,
                              fontSize: 14
                            ),
                          ), 
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(shoppingBag.totalPrice.currencyPTBR,
                            style: context.textStyles.textExtraBold.copyWith(
                              color: Colors.white,
                              fontSize: 14
                            )
                          ), 
                        ),
                      ],
                    ),
                  ),
                );
  }
}