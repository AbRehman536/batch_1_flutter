import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:owais_project/screens/admin_panel/products/get_all_products.dart';
import 'package:owais_project/screens/auth_screen/login.dart';
import 'package:owais_project/screens/home/bottom_bar.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if(snapshot.hasData){
            return BottomBarScreen();
          }
          return LoginScreen();
        });
  }
}
