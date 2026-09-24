import 'package:flutter/material.dart';
import 'package:owais_project/utils/widgets/custom_appbar.dart';

class FilterScreen extends StatelessWidget {
  const FilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: CustomAppbar(
            leading: Icon(Icons.close),
              title: "Filters")),
    );
  }
}
