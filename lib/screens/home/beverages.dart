import 'package:flutter/material.dart';
import 'package:owais_project/utils/widgets/custom_appbar.dart';

class BeverageScreen extends StatelessWidget {
  const BeverageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: CustomAppbar(
              title: "Beverages",
            leading: Icon(Icons.arrow_back_ios_new),
            icon: Icon(Icons.filter_list_sharp),
          )),
    );
  }
}
