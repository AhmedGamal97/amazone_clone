import 'package:amazonclone/screens/search_screen.dart';
import 'package:amazonclone/utils/color_themes.dart';
import 'package:amazonclone/utils/constants.dart';
import 'package:amazonclone/utils/uitls.dart';
import 'package:flutter/material.dart';
class AccountScreenAppBar extends StatelessWidget with PreferredSizeWidget{
  @override
  final Size preferredSize;

  AccountScreenAppBar({Key? key}) :preferredSize= Size.fromHeight(kAppBarHeight), super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize=Utils().getScreenSize();
    return Container(
      height: kAppBarHeight,
      width: screenSize.width,
      decoration:const BoxDecoration(
          gradient:LinearGradient(
              colors: backgroundGradient,
              begin: Alignment.centerLeft,
              end: Alignment.centerRight
          ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Image.network(amazonLogoUrl,height: kAppBarHeight *0.7,),
          ),
          Row(
            children: [
              IconButton(onPressed: (){},icon:const Icon(Icons.notifications_outlined,color: Colors.black,)),
              IconButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchScreen()));
              },icon:const Icon(Icons.search_outlined,color: Colors.black,)),
            ],
          )
        ],
      ),
    );
  }
}
