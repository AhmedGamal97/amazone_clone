import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
class CostWidget extends StatelessWidget {
  final Color color;
  final double cost;
  const CostWidget({Key? key,required this.color,required this.cost}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
         Text("7",style: TextStyle(color: color,fontSize: 10,fontFeatures: [FontFeature.superscripts(),],),),
        Text(cost.toInt().toString(),style: TextStyle(color:color,fontSize: 25,fontWeight: FontWeight.w800),),
        Text((cost-cost.toInt()).toString(),style: TextStyle(color: color,fontSize: 10,fontFeatures: [FontFeature.superscripts()]),),
        
      ],
    );
  }
}
