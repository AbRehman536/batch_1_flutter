import 'package:flutter/material.dart';
import 'package:owais_project/constants/app_colors.dart';

class TabBarScreen extends StatefulWidget {
  const TabBarScreen({super.key});

  @override
  State<TabBarScreen> createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<TabBarScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Tab Bar"),
          backgroundColor: AppColors.primaryColor,
          foregroundColor: AppColors.secondaryColor,
          bottom: TabBar(
            labelColor: AppColors.primaryColor,
              unselectedLabelColor: Colors.black,
              indicator: BoxDecoration(
                borderRadius: .circular(14),
                color: Colors.white
              ),
              indicatorSize: .tab,
              tabs: [
                Tab(icon: Icon(Icons.all_inbox),text: "All",),
                Tab(icon: Icon(Icons.mark_as_unread),text: "Unread",),
                Tab(icon: Icon(Icons.groups),text: "Groups",),
                Tab(icon: Icon(Icons.favorite),text: "Favorite",),
              ]),
        ),
        body: TabBarView(
            children: [
              Center(child: Text("All"),),
              Center(child: Text("Unread"),),
              Center(child: Text("Groups"),),
              Center(child: Text("Favorite"),),
        ]),
      ),
    );
  }
}
