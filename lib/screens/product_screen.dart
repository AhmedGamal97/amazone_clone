import 'package:amazonclone/model/product_model.dart';
import 'package:amazonclone/model/review_model.dart';
import 'package:amazonclone/model/user_details_model.dart';
import 'package:amazonclone/resources/cloud_firestore_methods.dart';
import 'package:amazonclone/utils/color_themes.dart';
import 'package:amazonclone/utils/constants.dart';
import 'package:amazonclone/utils/uitls.dart';
import 'package:amazonclone/widgets/cost_widget.dart';
import 'package:amazonclone/widgets/custom_main_button.dart';
import 'package:amazonclone/widgets/custom_simple_rounded_button.dart';
import 'package:amazonclone/widgets/rating_star_widget.dart';
import 'package:amazonclone/widgets/review_dialog.dart';
import 'package:amazonclone/widgets/review_widget.dart';
import 'package:amazonclone/widgets/search_bar_widget.dart';
import 'package:amazonclone/widgets/user_details_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_details_provider.dart';
class ProductScreen extends StatefulWidget {
  final ProductModel productModel;
  const ProductScreen({Key? key,required this.productModel}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  Expanded spaceThingy= Expanded(child: Container(),);
  @override
  Widget build(BuildContext context) {
    Size screenSize=Utils().getScreenSize();
    return SafeArea(
        child: Scaffold(
          appBar: SearchBarWidget(isReadOnly:true ,hasBackButton:true ,),
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: screenSize.height - (kAppBarHeight + (kAppBarHeight)),
                        child: Column(
                          children: [
                            SizedBox(height: kAppBarHeight/2,),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 5.0),
                                        child: Text(widget.productModel.sellerName,style: TextStyle(color: activeCyanColor,fontSize: 16),),
                                      ),
                                      Text(widget.productModel.productName),
                                    ],
                                  ),
                                  RatingStarWidget(rating: widget.productModel.rating),
                                ],
                              ),
                            ),
                            Padding(
                              padding:EdgeInsets.all(15),
                              child:Container(
                                height: screenSize.height/3,
                                constraints: BoxConstraints(maxHeight: screenSize.height/3),
                                child: Image.network(widget.productModel.url),
                              ),
                            ),
                            spaceThingy,
                            CostWidget(color: Colors.black, cost: widget.productModel.cost),
                            spaceThingy,
                            CustomMainButton(
                                child:Text('Buy Now',style: TextStyle(color: Colors.black),),
                                color:Colors.orange,
                                isLoading: false , onPressed: ()async{
                                  await CloudFireStore().addProductToOrders(
                                      model: widget.productModel,
                                    userDetails: Provider.of<UserDetailsProvider>(context,listen: false).userDetails as UserDetailsModel,
                                  );
                                  Utils().showSnackBar(context: context, content: "Done");
                            }),
                            spaceThingy,
                            CustomMainButton(
                                child:Text('Add to Cart',style: TextStyle(color: Colors.black),),
                                color:Colors.yellow,
                                isLoading: false , onPressed: ()async{
                                 await CloudFireStore().addProductToCart(productModel: widget.productModel);
                                 Utils().showSnackBar(context: context, content: "Add to cart");
                                }),
                            spaceThingy,
                            CustomSimpleRoundedButton(onPressed: (){
                              showDialog(context: context, builder: (context)=>ReviewDialog(productUid: widget.productModel.uid,));
                            },
                                text:"Add a review for this product"),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: screenSize.height,
                        child:StreamBuilder(
                          stream: FirebaseFirestore.instance.collection("products").doc(widget.productModel.uid).collection("reviews").snapshots(),
                          builder: (context,AsyncSnapshot<QuerySnapshot<Map<String,dynamic>>>snapshot){
                            if(snapshot.connectionState==ConnectionState.waiting){
                              return Container();
                            }else{
                              return ListView.builder(itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context,index){
                                    ReviewModel model=ReviewModel.getMOdelFromJson(json: snapshot.data!.docs[index].data());
                                    return ReviewWidget(reviewModel: model);
                                  }
                              );
                            }
                          },
                        )
                      ),
                    ],
                  ),
                ),
              ),
              UserDetailsBar(offset: 0,)
            ],
          ),
        )
    );
  }
}
