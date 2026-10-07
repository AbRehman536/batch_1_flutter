import 'package:flutter/material.dart';
import 'package:owais_project/constants/app_colors.dart';
import 'package:owais_project/screens/home/explore.dart';
import 'package:owais_project/screens/home/favorite.dart';
import 'package:owais_project/screens/home/home.dart';
import 'package:owais_project/screens/home/my_cart.dart';
import 'package:owais_project/screens/profile/profile.dart';

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({super.key});

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  List<Widget> screenList = [
    HomeScreen(),
    ExploreScreen(),
    MyCartScreen(),
    FavoriteScreen(),
    ProfileScreen()
  ];
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Bottom Bar"),
      //   backgroundColor: Colors.blue,
      // ),
      body: screenList.elementAt(selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: .fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: AppColors.primaryColor,
          unselectedItemColor: Colors.black,
          onTap: (value){
          setState(() {
            selectedIndex = value;
          });
          },
          currentIndex: selectedIndex,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.shopping_bag_outlined),label: "Shop"),
            BottomNavigationBarItem(icon: Icon(Icons.manage_search),label: "Explore"),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_outlined),label: "Cart"),
            BottomNavigationBarItem(icon: Icon(Icons.favorite),label: "Favorite"),
            BottomNavigationBarItem(icon: Icon(Icons.person),label: "Profile"),
          ]),
    );
  }
}
