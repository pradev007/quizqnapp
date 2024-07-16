import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class MyTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String text1;
  final int maxLine1;
  // final InputDecoration decoration;
  final String? Function(String?) validator;
  MyTextFormField({
    super.key,
    required this.text1,
    required this.maxLine1,
    required this.controller,
    // required this.decoration,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: key,
        child: TextFormField(
          validator: validator,
          controller: controller,
          maxLines: maxLine1,
          decoration: InputDecoration(
              hintText: text1,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              filled: true,
              fillColor: Colors.green[100]),
        ),
      ),
    );
  }
}
