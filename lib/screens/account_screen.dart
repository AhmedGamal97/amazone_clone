import 'package:amazonclone/model/order_request_model.dart';
import 'package:amazonclone/model/product_model.dart';
import 'package:amazonclone/model/user_details_model.dart';
import 'package:amazonclone/providers/user_details_provider.dart';
import 'package:amazonclone/screens/sell_screen.dart';
import 'package:amazonclone/utils/color_themes.dart';
import 'package:amazonclone/utils/constants.dart';
import 'package:amazonclone/utils/uitls.dart';
import 'package:amazonclone/widgets/custom_main_button.dart';
import 'package:amazonclone/widgets/products_showcase_list_view.dart';
import 'package:amazonclone/widgets/simple_product_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/account_screen_app__bar.dart';
class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);
  @override
  State<AccountScreen> createState() => _AccountScreenState();
}
class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    Size screenSized=Utils().getScreenSize();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AccountScreenAppBar(),
      body: SingleChildScrollView(
        child: SizedBox(
          height: screenSized.height -( kAppBarHeight /2),
          width: screenSized.width,
          child: Column(
            children: [
              IntroductionWidgetAccountScreen(),
              CustomMainButton(child: Text("Sign Out",style: TextStyle(color: Colors.black),), color: Colors.orange, isLoading: false, onPressed: (){
                FirebaseAuth.instance.signOut();
              }),
              CustomMainButton(child: Text("Sell",style: TextStyle(color: Colors.black),), color:yellowColor, isLoading: false, onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SellScreen()));
              }
              ),
              FutureBuilder(
                future:FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("orders").get(),
                builder: (context, AsyncSnapshot<QuerySnapshot<Map<String,dynamic>>>snapshot) {
                  if(snapshot.connectionState ==ConnectionState.waiting){
                    return Container();
                  }else{
                    List<Widget> children=[];
                    for(int i=0;i<snapshot.data!.docs.length;i++){
                      ProductModel model=ProductModel.getModelFromJson(json: snapshot.data!.docs[i].data());
                      children.add(SimpleProductWidget(productModel: model));
                    }
                    return ProductsShowcaseListView(title: "Your orders", children: children);
                  }
                  },
              ),
              Padding(padding: EdgeInsets.all(15),child:Align(alignment: Alignment.centerLeft,child: Text("Order Requests",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)),),
              Expanded(
                  child:StreamBuilder(
                      stream:FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("orderRequests").snapshots(),
                      builder: (context,AsyncSnapshot<QuerySnapshot<Map<String,dynamic>>>snapshot){
                        if(snapshot.connectionState==ConnectionState.waiting){
                          return Container();
                        }else{
                          return ListView.builder(
                              itemCount:snapshot.data!.docs.length ,
                              itemBuilder: (context,index) {
                                OrderRequesModel model = OrderRequesModel.getModelFromJson(json: snapshot.data!.docs[index].data());
                                return ListTile(
                                  title: Text("Orders: ${model.orderName}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500),),
                                  subtitle: Text(
                                      "Address: ${model.buyerAddress}"),
                                  trailing: IconButton(
                                    onPressed: () async{
                                      FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection("orderRequests").doc(snapshot.data!.docs[index].id).delete();
                                    }, icon: Icon(Icons.check),),
                                );
                              }
                              );
                        }
                      }
                  )
              )
           ],
         ),
       ),
     ),
    );
  }
}

class IntroductionWidgetAccountScreen extends StatelessWidget {
  const IntroductionWidgetAccountScreen ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserDetailsModel? userDetailsModel=Provider.of<UserDetailsProvider>(context).userDetails;
    return Container(
        height: kAppBarHeight/2,
        decoration:const BoxDecoration(
          gradient:LinearGradient(
              colors: backgroundGradient,
              begin: Alignment.centerLeft,
              end: Alignment.centerRight
          ),
        ),
      child:Container(
        height: kAppBarHeight/2,
        decoration: BoxDecoration(
          gradient:LinearGradient(
              colors: [
                Colors.white,
                Colors.white.withOpacity(0.0000000000001)
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 17.0),
              child: RichText(
                  text: TextSpan(
                      children: [
                        TextSpan(text:"Hello, ",style: TextStyle(color: Colors.grey[800],fontSize: 27)),
                        TextSpan(text:"${userDetailsModel!.name}",style: TextStyle(color: Colors.grey[800],fontSize: 27,fontWeight: FontWeight.bold)),
                      ]
                  )
              ),
            ),
            const Padding(
              padding:  EdgeInsets.only(right: 20.0),
              child: CircleAvatar(
                backgroundImage: NetworkImage("https://m.media-amazon.com/images/I/116KbsvwCRL._SX90_SY90_.png"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
