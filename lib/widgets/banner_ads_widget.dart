import 'package:amazonclone/utils/color_themes.dart';
import 'package:amazonclone/utils/constants.dart';
import 'package:flutter/material.dart';
class BannerAdWidget extends StatefulWidget {
  const BannerAdWidget({Key? key}) : super(key: key);

  @override
  State<BannerAdWidget> createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends State<BannerAdWidget> {
  int currrentAd=0;
  double smallAdHeight=90;

  @override
  Widget build(BuildContext context) {
    Size screenSize=MediaQuery.of(context).size;
    return GestureDetector(
      onHorizontalDragEnd: (_){
       if(currrentAd==(largeAds.length-1)){
         currrentAd=-1;
       }
       setState(() {
         currrentAd ++;
       });

      },
      child: Column(
        children: [
          Stack(
            children: [
              Image.network(largeAds[currrentAd],width: double.infinity,),
              Positioned(
                bottom: 0,
                child: Container(
                  width: screenSize.width,
                  height: 200,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                          colors: [
                            backgroundColor,
                            backgroundColor.withOpacity(0),
                          ],
                      ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            color: backgroundColor,
            width: screenSize.width,
            height: smallAdHeight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                getSmallAdsFromIndex(0, smallAdHeight),
                getSmallAdsFromIndex(1, smallAdHeight),
                getSmallAdsFromIndex(2, smallAdHeight),
                getSmallAdsFromIndex(3, smallAdHeight),

              ],
            ),
          )
        ],
      ),

    );
  }
  Widget getSmallAdsFromIndex(int index,double height){
   return Padding(
     padding: const EdgeInsets.all(0),
     child: Container(
       height: height,
       width: height,
       decoration: ShapeDecoration(
         color: Colors.white,
         shadows: [
           BoxShadow(color: Colors.black.withOpacity(0.2),blurRadius: 5,spreadRadius: 1),
         ],
         shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.circular(10),
         )
       ),
       child: Center(
         child: Column(
           mainAxisSize: MainAxisSize.min,
           children: [
             Image.network(smallAds[index]),

             Text(adItemNames[index])
           ],
         ),
       ),
     ),
   );
  }
}
