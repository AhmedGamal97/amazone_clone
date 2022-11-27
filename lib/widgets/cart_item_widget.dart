import 'package:amazonclone/model/product_model.dart';
import 'package:amazonclone/resources/cloud_firestore_methods.dart';
import 'package:amazonclone/screens/product_screen.dart';
import 'package:amazonclone/utils/color_themes.dart';
import 'package:amazonclone/utils/uitls.dart';
import 'package:amazonclone/widgets/custom_simple_rounded_button.dart';
import 'package:amazonclone/widgets/custom_square_button.dart';
import 'package:amazonclone/widgets/product_information_widget.dart';
import 'package:flutter/material.dart';

class CartItemWidget extends StatelessWidget {
  final ProductModel productModel;
  const CartItemWidget({Key? key,required this.productModel }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size screenSize=Utils().getScreenSize();
    return Container(
      padding: EdgeInsets.only(top: 25,left: 25),
      height: screenSize.height/2,
      width: screenSize.width,
      decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 1
          )
        )
      ),
      child: Column(
        children: [
          Expanded(
            flex: 5,
            child:GestureDetector(
              onTap: (){
                Navigator.push(
                  context, MaterialPageRoute(
                  builder: (context)=>ProductScreen(productModel: productModel),
                ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: screenSize.width/3,
                    child: Align(
                        alignment: Alignment.topCenter,
                        child: Center(
                            child: Image.network(
                             productModel.url,)
                        )
                    ),
                  ),
                  ProductInformationWidget(productName:productModel.productName, cost: productModel.cost, seller: productModel.sellerName),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              children: [
                CustomSquareButton(onPressed: (){}, color:backgroundColor, dimension: 37, child: const Icon(Icons.remove)),
                CustomSquareButton(onPressed: (){}, color: Colors.white, dimension: 37, child: const Text("0",style: TextStyle(color: activeCyanColor),)),
                CustomSquareButton(onPressed: ()async{
                  CloudFireStore().addProductToCart(
                      productModel:ProductModel(
                          url: productModel.url,
                          productName: productModel.productName,
                          cost: productModel.cost,
                          discount: productModel.discount,
                          uid: Utils().getUid(),
                          sellerName: productModel.sellerName,
                          sellerUid: productModel.sellerUid, rating: productModel.rating, noOfRating: productModel.noOfRating));
                }, color:backgroundColor, dimension: 37, child: const Icon(Icons.add)),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child:Padding(
              padding: EdgeInsets.only(top: 5),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      CustomSimpleRoundedButton(onPressed: ()async{
                        CloudFireStore().deleteProductFromCart(uid: productModel.uid);
                      }, text: "Delete"),
                      SizedBox(width: 5,),
                      CustomSimpleRoundedButton(onPressed: (){}, text: "Save for later"),
                    ],
                  ),
                  const Padding(
                    padding:EdgeInsets.only(top:3),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("See more of this",style: TextStyle(color: activeCyanColor),
                        )
                    ),
                  )
                ],
              ),
            )
          ),
        ],
      ),
    );
  }
}
