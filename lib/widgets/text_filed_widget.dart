import 'package:flutter/material.dart';
import 'package:todo_app/resoures/color/color_app.dart';

class TextFiledWidget extends StatelessWidget {
  String title;
  TextEditingController controller;
  TextInputType keyboardType;
  String? Function(String?) validator;
  bool obscureText;

  TextFiledWidget({
    required this.title,
    required this.controller,
    this.keyboardType = TextInputType.text,
    required this.validator,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: TextFormField(
        validator: validator,
        keyboardType: keyboardType,
        controller: controller,
        style: TextStyle(fontSize: 16),
        obscureText: obscureText,
        decoration: InputDecoration(
          label: Text(
            title,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide:
                  BorderSide(color: ColorApp.cPrimaryDarkBackGroundColor)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: ColorApp.cPrimaryColor),
          ),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide(color: ColorApp.cRedColor)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide(color: ColorApp.cRedColor)),
        ),
      ),
    );
  }
}
