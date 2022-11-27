import 'package:amazonclone/model/product_model.dart';
import 'package:amazonclone/screens/product_screen.dart';
import 'package:amazonclone/utils/color_themes.dart';
import 'package:amazonclone/utils/uitls.dart';
import 'package:amazonclone/widgets/cost_widget.dart';
import 'package:amazonclone/widgets/rating_star_widget.dart';
import 'package:flutter/material.dart';
class ResultsWidget extends StatelessWidget {
  final ProductModel productModel;
  const ResultsWidget({Key? key,required this.productModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size sizeScreen= Utils().getScreenSize();
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context)=>ProductScreen(productModel: productModel)
          )
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(width: sizeScreen.width/3,child: Image.network(productModel.url)),
            Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: Text(productModel.productName,maxLines: 3,overflow:TextOverflow.ellipsis,),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: Row(
                children: [
                  SizedBox(
                      width:sizeScreen.width/5,
                      child: FittedBox(
                          child: RatingStarWidget(rating: productModel.rating,),
                      ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(productModel.noOfRating.toString(),style: TextStyle(color: activeCyanColor),),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
                child: FittedBox(
                  child: CostWidget(
                      color: Color.fromARGB(255, 92, 9, 3),
                      cost: productModel.cost
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }
}
