import 'package:amazonclone/model/user_details_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'cloud_firestore_methods.dart';

class Authenticationmethods{
  FirebaseAuth firebaseAuth=FirebaseAuth.instance;
  CloudFireStore cloudFireStore=CloudFireStore();
  Future<String> signUpUser({
    required String name,
    required String address,
    required String email,
    required String password})async{
    name.trim();
    address.trim();
    email.trim();
    password.trim();
    String output="Something went wrong";
    if(name!="" && address!="" && email!="" && password!=""){
      try{
        await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
        UserDetailsModel user=UserDetailsModel(name: name, address: address);
        await cloudFireStore.uploadNameandAddressToDatabase(user: user);
        output="success";
      }on FirebaseAuthException catch(e){
        output=e.message.toString() ;
      }
    }else{
      output="please fill up all fields";
    }
    return output;
  }
  Future<String> signInUser({
    required String email,
    required String password})async{
    email.trim();
    password.trim();
    String output="";
    if(email!="" && password!=""){
      try{
        await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
        output="success";
      }on FirebaseAuthException catch(e){
        output=e.message.toString() ;
      }
    }else{
      output="please fill up all fields";
    }
    return output;
  }
}