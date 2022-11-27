import 'package:amazonclone/model/product_model.dart';
import 'package:amazonclone/model/user_details_model.dart';
import 'package:amazonclone/providers/user_details_provider.dart';
import 'package:amazonclone/resources/cloud_firestore_methods.dart';
import 'package:amazonclone/utils/color_themes.dart';
import 'package:amazonclone/utils/constants.dart';
import 'package:amazonclone/utils/uitls.dart';
import 'package:amazonclone/widgets/cart_item_widget.dart';
import 'package:amazonclone/widgets/custom_main_button.dart';
import 'package:amazonclone/widgets/search_bar_widget.dart';
import 'package:amazonclone/widgets/user_details_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchBarWidget(hasBackButton: false,isReadOnly: true,),
      body:Center(
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(height: kAppBarHeight/2,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:StreamBuilder(
                    stream:FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("cart").snapshots(),
                    builder: (context,AsyncSnapshot<QuerySnapshot<Map<String,dynamic>>>snapshot){
                        if(snapshot.connectionState==ConnectionState.waiting){
                          return CustomMainButton(
                              child: Text("loading"),color: yellowColor, isLoading: true, onPressed: (){});
                        }else{
                          return CustomMainButton(
                              child: Text("Proceed to order (${snapshot.data!.docs.length}) items",style: TextStyle(color: Colors.black),),
                              color: yellowColor, isLoading: false, onPressed: ()async{
                                await CloudFireStore().buyAllItemsInCart(
                                    userDetails: Provider.of<UserDetailsProvider>(context,listen: false).userDetails as UserDetailsModel);
                                Utils().showSnackBar(context: context, content: "Done");
                          });
                        }
                    },
                  )
                ),
                Expanded(
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("cart").snapshots(),
                    builder: (context,AsyncSnapshot<QuerySnapshot<Map<String,dynamic>>>snapshot){
                      if(snapshot.connectionState==ConnectionState.waiting){
                        return Container();
                      }else{
                        return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context,index){
                              ProductModel model=ProductModel.getModelFromJson(json: snapshot.data!.docs[index].data());
                              return CartItemWidget(productModel: model);
                            }
                        );
                      }
                    },
                  )
                ),
              ],
            ),
            UserDetailsBar(offset: 0,

            ),
          ],
        ),
      ),
    );
  }
}
