import 'package:flutter/material.dart';
import 'package:owais_project/constants/app_assets.dart';
import 'package:owais_project/constants/app_colors.dart';
import 'package:owais_project/screens/admin_panel/products/get_all_products.dart';
import 'package:owais_project/screens/auth_screen/signup.dart';
import 'package:owais_project/screens/home/bottom_bar.dart';
import 'package:owais_project/services/auth.dart';
import 'package:owais_project/utils/widgets/custom_button.dart';
import 'package:owais_project/utils/widgets/custom_textField.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController emailController = TextEditingController();
  bool isLoading = false;
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
                Text("Reset Password",style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff181725)
                ),),
                SizedBox(height: 15,),
                Text("Enter your email "
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
                    controller: emailController,
                    hint: "abdullah@gmail.com"),
                SizedBox(height: 30,),
                isLoading ? Center(child: CircularProgressIndicator(),)
                    : Center(
                    child: CustomButton(
                        btnLabel: "Send Link",
                        onPressed: ()async{
                          try{
                            isLoading = true;
                            setState(() {});
                            await AuthService().resetPassword(
                                email: emailController.text,)
                                .then((val){
                              isLoading = false;
                              setState(() {});
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    content: Text("Link Send Successfully"),
                                    actions: [
                                      CustomButton(
                                          btnLabel: "Okay", onPressed: (){
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                      })
                                    ],
                                  );
                                },);
                            });
                          }catch(e){
                            isLoading = false;
                            setState(() {});
                            ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(content: Text(e.toString())));

                          }
                        }
                    )),

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
                    TextButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> SignUpScreen()));
                    }, child: Text("Sign Up",
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
