import 'package:dw9_delivery_app/app/core/ui/helpers/size_extensions.dart';
import 'package:dw9_delivery_app/app/core/ui/styles/text_styles.dart';
import 'package:dw9_delivery_app/app/core/ui/widgets/delivery_button.dart';
import 'package:flutter/material.dart';

class OrderCompletedPage extends StatelessWidget {

  const OrderCompletedPage({ super.key });

   @override
   Widget build(BuildContext context) {
       return Scaffold(
           appBar: AppBar(title: const Text('Order '),),
           body: Center(
             child: Column(
               mainAxisAlignment: MainAxisAlignment.start,
               children: [
                 SizedBox(
                   height: context.percentHeight(.1),
                 ),
                 Image.asset('assets/images/logo_rounded.png'),
                 Text('Pedido realizado com sucesso, em breve, você irá receber a confirmação do seu pedido',
                 textAlign: TextAlign.center,
                   style: context.textStyles.textExtraBold.copyWith(
                     fontSize: 18
                   ),
                 ),
                 Spacer(),
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: DeliveryButton(
                     label: 'FECHAR',
                     width: context.percentWidth(.9),
                     onPressed: () {
                      Navigator.pop(context);
                     }
                   ),
                 )
               ],
             ),
           ),
       );
  }
}