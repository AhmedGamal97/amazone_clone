
import 'package:amazonclone/screens/signin_screen.dart';
import 'package:flutter/material.dart';
import '../resources/authentication_methods.dart';
import '../utils/color_themes.dart';
import '../utils/constants.dart';

import '../utils/uitls.dart';
import '../widgets/custom_main_button.dart';
import '../widgets/text_field_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  TextEditingController addressController=TextEditingController();
  Authenticationmethods authenticationmethods=Authenticationmethods();
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    addressController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    Size screenSize=Utils().getScreenSize();
    return Scaffold(
      backgroundColor: Colors.white,
      body:  SingleChildScrollView(
        child: SizedBox(
          height: screenSize.height,
          width: screenSize.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 35),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.network(amazonLogo,height:screenSize.height*0.10 ,),
                // box of sign Up
                SizedBox(
                  height: screenSize.height*0.7,
                  child: FittedBox(
                    child: Container(
                        height: screenSize.height*0.85,
                        width: screenSize.width*0.8,
                        padding: const EdgeInsets.all(25),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey,width: 1),
                        ),
                        child:Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Sign Up",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 28),),
                            TextFieldWidget(title: "Name", controller: nameController, obscureText: false, hintText: "enter your name"),
                            TextFieldWidget(title: "Address", controller:addressController, obscureText: false, hintText: "enter your address"),
                            TextFieldWidget(title: "Email", controller: emailController, obscureText: false, hintText: "enter your email"),
                            TextFieldWidget(title: "Password", controller: passwordController, obscureText: true, hintText: "enter your password"),
                            Align(
                              alignment: Alignment.center,
                              child: CustomMainButton(
                                color: yellowColor,
                                isLoading: isLoading, onPressed: ()async{
                                setState(() {
                                  isLoading = true;
                                });
                                  String output=await authenticationmethods.signUpUser(
                                      name: nameController.text,
                                      address: addressController.text,
                                      email: emailController.text,
                                      password:passwordController.text);
                                setState(() {
                                  isLoading = false;
                                });
                                  if(output=="success"){
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignInScreen(),));
                                  }else{
                                    Utils().showSnackBar(context: context, content: output);
                                  }
                              },
                                child: const Text(
                                  'Sign Up',
                                  style: TextStyle(letterSpacing: 0.6,
                                      color: Colors.black
                                  ),

                                ),
                              ),
                            )
                          ],
                        )
                    ),
                  ),
                ),

                // button of going to login to your account
                CustomMainButton(
                    color: Colors.grey[400]!,
                    isLoading: false  ,
                    onPressed: (){
                      setState(() {
                        isLoading = true;
                      });
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                        return SignInScreen();
                      },));
                    },
                    child: const Text(
                      "Already have an account?",
                      style: TextStyle(
                          letterSpacing: 0.6,
                          color: Colors.black
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
