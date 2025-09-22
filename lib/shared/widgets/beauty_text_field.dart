import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

final RegExp emailRegex = RegExp(
  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
);

// ignore: must_be_immutable
class BeautyTextField extends StatelessWidget {
  BeautyTextField({
    super.key,
    required this.fieldName,
    this.textInputType,
    this.textInputAction = TextInputAction.next,
    this.validator,
    this.onChanged,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.enabled = true,
    this.controller,
    this.textDirection,
    this.maxLines = 1,
    this.inputFormatters,
  });

  final String fieldName;
  final TextInputType? textInputType;
  TextInputAction? textInputAction;
  String? Function(String?)? validator;
  void Function(String)? onChanged;
  Widget? prefixIcon;
  Widget? suffixIcon;
  bool obscureText;
  TextEditingController? controller;
  TextDirection? textDirection;
  bool? enabled;
  int? maxLines;
  List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: TextFormField(
        enabled: enabled,
        onChanged: onChanged,
        controller: controller,
        validator: validator,
        maxLines: maxLines,
        scrollPadding: const EdgeInsets.all(50),
        keyboardType: textInputType,
        textInputAction: textInputAction,
        textDirection: textDirection,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.green, width: 2.0),
          ),
          border: const OutlineInputBorder(borderSide: BorderSide(width: 2.0)),
          label: Text(fieldName.tr),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
        ),
        obscureText: obscureText,
      ),
    );
  }
}
