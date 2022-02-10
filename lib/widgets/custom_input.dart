import 'package:ecommerce/constants.dart';
import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {

  final String text;
  final Function(String) onChanged;
  final Function(String) onSubmitted;
  final FocusNode focusNode;
  final TextInputAction textInputAction;
  final bool isPasswordField;

  const CustomInput({ Key? key, required this.text, 
  required this.onChanged, 
  required this.onSubmitted, 
  required this.focusNode, required this.textInputAction, required this.isPasswordField }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(
          vertical: 6.0,
          horizontal: 15.0,
        ),


      decoration: BoxDecoration(
        color: const Color(0xFFF2F2F2),
        borderRadius: BorderRadius.circular(12.0),

      ),
      child: TextField(
        onChanged: onChanged,
        focusNode: focusNode,
        onSubmitted: onSubmitted,
        textInputAction: textInputAction,
        obscureText: isPasswordField,

        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: text,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 15.0,
            vertical: 5.0,
          ),
        ),

        style: Constants.regularDarkText,
      ),
    );
  }
}