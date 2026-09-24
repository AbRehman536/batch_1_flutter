import 'package:flutter/material.dart';
import 'package:owais_project/constants/app_colors.dart';

class CustomAppbar extends StatelessWidget {
  final String title;
  final Widget? leading;
  final Widget? icon;
  const CustomAppbar({super.key, required this.title, this.leading, this.icon});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.secondaryColor,
      elevation: 0,
      leading: leading,
      title: Text(title,style: TextStyle(
        fontWeight: FontWeight.w900,
        fontSize: 20,
        color: Colors.black
      ),),
      centerTitle: true,
      actions: [
        ?icon
      ],
    );
  }
}
