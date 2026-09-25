import 'package:flutter/material.dart';
import 'package:owais_project/constants/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final String? label;
  final String hint;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  const CustomTextField({super.key, this.label, required this.hint, this.prefixIcon, this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        // filled: true,
        // fillColor: AppColors.secondaryColor,
        //label: Text(label!),
        hint: Text(hint),
        hintStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: Color(0xff181725)
        ),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        // border: OutlineInputBorder(
        //   borderRadius: .circular(15),
        //   borderSide: BorderSide(
        //     color: Colors.black,
        //     width: 1
        //   )
        // )
      ),
    );
  }
}
