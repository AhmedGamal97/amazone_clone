import 'package:amazonclone/model/review_model.dart';
import 'package:amazonclone/model/user_details_model.dart';
import 'package:amazonclone/providers/user_details_provider.dart';
import 'package:amazonclone/resources/cloud_firestore_methods.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rating_dialog/rating_dialog.dart';
class ReviewDialog extends StatelessWidget {
  final String productUid;
  const ReviewDialog({Key? key,required this.productUid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RatingDialog(
      title:const Text(
        'Type a review for this product',
        textAlign: TextAlign.center,
        style:  TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      submitButtonText: 'Send',
      commentHint: 'Type here ',
      onSubmitted: (RatingDialogResponse res)async{
        CloudFireStore().uploadReviewToDatabase(
            productUid: productUid,
            model: ReviewModel(
                senderName:Provider.of<UserDetailsProvider>(context,listen: false).userDetails!.name,
                description:res.comment,
                rating: res.rating.toInt()),
        );
      },
    );
  }
}