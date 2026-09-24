import 'package:flutter/material.dart';
import 'package:owais_project/constants/app_assets.dart';
import 'package:owais_project/constants/app_colors.dart';
import 'package:owais_project/utils/widgets/custom_button.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(AppAssets.onBoarding,
            fit: BoxFit.fill,
            width: double.infinity,
            height: double.infinity,),
          Center(
            child: Column(
              children: [
                SizedBox(height: 500,),
                Text("Welcome to our store",
                  style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.w600,
                      color: AppColors.secondaryColor
                  ),),
                Text("Get you groceries in as fast as in one hour",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                      color: AppColors.secondaryColor
                  ),),
                CustomButton(
                    btnLabel: "Get Started",
                    onPressed: (){}),
              ],
            ),
          )
        ],
      ),
    );
  }
}
