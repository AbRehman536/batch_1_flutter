import 'package:flutter/material.dart';
import 'package:owais_project/constants/app_assets.dart';
import 'package:owais_project/constants/app_colors.dart';
import 'package:owais_project/utils/widgets/custom_button.dart';
import 'package:owais_project/utils/widgets/custom_textField.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(AppAssets.backgroundImage),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 28,),
                Align(
                    alignment: Alignment.center,
                    child: Image.asset(AppAssets.carrotImage,width: 47,height: 55,)),

                SizedBox(height: 100,),
                Text("Login",style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff181725)
                ),),
                SizedBox(height: 15,),
                Text("Enter your email and password"
                  ,style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff7C7C7C)
                  ),),
                SizedBox(height: 40,),
                Text("Email",style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff7C7C7C)
                ),),
                CustomTextField(
                    hint: "abdullah@gmail.com"),
                SizedBox(height: 30,),
                Text("Password",style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff7C7C7C)
                ),),
                CustomTextField(
                  hint: "*********",
                  suffixIcon: Icon(Icons.visibility_off_outlined),
                ),
                SizedBox(height: 10,),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(onPressed: (){}, child: Text("Forget Password?",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff181725)
                    ),)),
                ),
                SizedBox(height: 10,),
                Center(child: CustomButton(btnLabel: "Login", onPressed: (){})),

                SizedBox(height: 25,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff181725)
                      ),),
                    TextButton(onPressed: (){}, child: Text("Sign Up",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryColor
                      ),))
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
