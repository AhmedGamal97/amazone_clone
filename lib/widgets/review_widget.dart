import 'package:amazonclone/model/review_model.dart';
import 'package:amazonclone/utils/constants.dart';
import 'package:amazonclone/utils/uitls.dart';
import 'package:amazonclone/widgets/rating_star_widget.dart';
import 'package:flutter/material.dart';
class ReviewWidget extends StatelessWidget {
  final ReviewModel reviewModel;
  const ReviewWidget({Key? key,required this.reviewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSized=Utils().getScreenSize();
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(reviewModel.senderName,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: SizedBox(
                      width:screenSized.width/4,
                      child: FittedBox(
                        child: RatingStarWidget(rating: reviewModel.rating,),
                      ),
                    ),
                  ),
                  Text(keysOfRating[reviewModel.rating-1],style: TextStyle(fontWeight: FontWeight.bold,),)
                ],
              ),
            ),
            Text(reviewModel.description,maxLines: 3,overflow: TextOverflow.ellipsis,)
          ],
        )
    );
  }
}
