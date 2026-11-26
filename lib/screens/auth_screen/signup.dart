import 'package:flutter/material.dart';
import 'package:owais_project/constants/app_assets.dart';
import 'package:owais_project/constants/app_colors.dart';
import 'package:owais_project/models/User_model.dart';
import 'package:owais_project/screens/auth_screen/login.dart';
import 'package:owais_project/services/auth.dart';
import 'package:owais_project/services/user_service.dart';
import 'package:owais_project/utils/widgets/custom_button.dart';
import 'package:owais_project/utils/widgets/custom_textField.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
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
                Text("Sign Up",style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff181725)
                ),),
                SizedBox(height: 15,),
                Text("Enter your username, email and password"
                  ,style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff7C7C7C)
                  ),),
                SizedBox(height: 40,),
                Text("Username",style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff7C7C7C)
                ),),
                CustomTextField(
                  controller: usernameController,
                    hint: "abdullahrehman"),
                SizedBox(height: 30,),
                Text("Email",style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff7C7C7C)
                ),),
                CustomTextField(
                  controller: emailController,
                    hint: "abdullah@gmail.com"),
                SizedBox(height: 30,),
                Text("Password",style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff7C7C7C)
                ),),
                CustomTextField(
                  controller: passwordController,
                  hint: "*********",
                  suffixIcon: Icon(Icons.visibility_off_outlined),
                ),
                SizedBox(height: 10,),
                isLoading ? Center(child: CircularProgressIndicator(),)
                :Center(
                    child:
                    CustomButton(
                        btnLabel: "Sign Up",
                        onPressed: ()async{
                          try{
                            isLoading = true;
                            setState(() {});
                            await AuthService().registerUser(
                                email: emailController.text,
                                password: passwordController.text)
                                .then((value)async{
                                  await UserService().createUser(
                                    UserModel(
                                      docId: value.uid.toString(),
                                      username: usernameController.text,
                                      email: emailController.text,
                                      createdAt: DateTime.now().millisecondsSinceEpoch
                                    )
                                  ).then((val){
                                    isLoading = false;
                                    setState(() {});
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          content: Text("Register User Successfully"),
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
                    Text("Already have an account?",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff181725)
                      ),),
                    TextButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen()));
                    }, child: Text("Login",
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
