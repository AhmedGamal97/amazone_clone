import 'package:amazonclone/layout/screen_layout.dart';
import 'package:amazonclone/providers/user_details_provider.dart';
import 'package:amazonclone/screens/sell_screen.dart';
import 'package:provider/provider.dart';
import 'package:amazonclone/screens/signin_screen.dart';
import 'package:amazonclone/utils/color_themes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  if(kIsWeb){
    await Firebase.initializeApp(
      options:const FirebaseOptions(
          apiKey: "AIzaSyDCM2m9rjLi5vBQJNrQ5rA2spZ240nJYHY",
          authDomain: "clone-4c2be.firebaseapp.com",
          projectId: "clone-4c2be",
          storageBucket: "clone-4c2be.appspot.com",
          messagingSenderId: "116076432725",
          appId: "1:116076432725:web:f430dc213e55368c6273dc",      ),
    );
  }else{
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  runApp(const AmazonClone());
}

class AmazonClone extends StatelessWidget {
  const AmazonClone({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers:[
        ChangeNotifierProvider(create: (context)=> UserDetailsProvider())
      ],
      child: MaterialApp(
        title: 'Amazon Clone',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: backgroundColor,
        ),
        home:StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, AsyncSnapshot<User?> user) {
            if(user.connectionState==ConnectionState.waiting){
              return const Center(
                child: CircularProgressIndicator(color: Colors.orange,),);
            }else if(user.hasData){
              return const ScreenLayout();

            }else{
              return const SignInScreen();
            }
          },
        ),
      ),
    );
  }
}
