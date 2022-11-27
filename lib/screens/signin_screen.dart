import 'package:amazonclone/screens/signup_screen.dart';
import 'package:amazonclone/utils/color_themes.dart';
import 'package:amazonclone/utils/constants.dart';
import 'package:amazonclone/utils/uitls.dart';
import 'package:amazonclone/widgets/custom_main_button.dart';
import 'package:flutter/material.dart';

import '../resources/authentication_methods.dart';
import '../widgets/text_field_widget.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  Authenticationmethods authenticationmethods=Authenticationmethods();
  bool isLoading=false;
  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
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
               // box of sign in
               Container(
                 height: screenSize.height*0.5,
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
                     const Text("Sign In",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 28),),
                     TextFieldWidget(title: "Email", controller: emailController, obscureText: false, hintText: "enter your email"),
                     TextFieldWidget(title: "Password", controller: passwordController, obscureText: true, hintText: "enter your password"),
                     Align(
                       alignment: Alignment.center,
                       child: CustomMainButton(
                         color: yellowColor,
                         isLoading: isLoading,
                         onPressed: () async {
                           setState(() {
                             isLoading=true;
                           });
                           String output=await authenticationmethods.signInUser(
                               email: emailController.text,
                               password:passwordController.text);
                           setState(() {
                             isLoading=false;
                           });
                           if(output=="success"){

                           }else{
                             Utils().showSnackBar(context: context, content: output);
                           }
                         },
                         child: const Text(
                             'Sign In',
                            style: TextStyle(letterSpacing: 0.6,
                                color: Colors.black
                            ),

                         ),
                       ),
                     )
                   ],
                 )
               ),
               Row(
                 children: [
                   Expanded(child: Container(height: 1,color: Colors.grey,)),
                   Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 10.0),
                     child: Text("New to Amazon?",style: TextStyle(color: Colors.grey),),
                   ),
                   Expanded(child: Container(height: 1,color: Colors.grey,)),
                 ],
               ),
               // button of going to create new account
               CustomMainButton(
                   color: Colors.grey[400]!,
                   isLoading: false  ,
                   onPressed: (){
                     setState(() {
                       isLoading = true;
                     });
                     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                       return const SignUpScreen();
                     },));
                   },
                   child: const Text(
                       "Create an Amazon Account?",
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
