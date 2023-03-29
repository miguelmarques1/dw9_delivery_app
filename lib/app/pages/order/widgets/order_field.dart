import 'package:dw9_delivery_app/app/core/ui/styles/text_styles.dart';
import 'package:flutter/material.dart';

class OrderField extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final FormFieldValidator validator;
  final String hintText;

  const OrderField({super.key, required this.controller, required this.hintText, required this.title, required this.validator});

  @override
  Widget build(BuildContext context) {
    const defaultBorder = UnderlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey
      )
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: SizedBox(
              height: 35,
              child: Text(title,
                style: context.textStyles.textRegular.copyWith(
                  fontSize: 16,
                  overflow: TextOverflow.ellipsis
                ),
              ),
            ),
          ),
          TextFormField(
            validator: validator,
            controller: controller,
            decoration: InputDecoration(
              hintText: hintText,
              border: defaultBorder,
              enabledBorder: defaultBorder,
              focusedBorder: defaultBorder
            ),
          )
        ],
      ),
    );
  }
}