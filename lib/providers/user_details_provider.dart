import 'package:amazonclone/model/user_details_model.dart';
import 'package:amazonclone/resources/cloud_firestore_methods.dart';
import 'package:flutter/material.dart';

class UserDetailsProvider with ChangeNotifier{
  UserDetailsModel? userDetails;
  UserDetailsProvider(): userDetails=UserDetailsModel(name: "Loading", address:"Loading" );

  Future getData()async{
    userDetails=await CloudFireStore().getNameAndAddress();
    notifyListeners();
  }
}