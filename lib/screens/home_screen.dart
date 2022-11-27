import 'package:amazonclone/model/user_details_model.dart';
import 'package:amazonclone/resources/cloud_firestore_methods.dart';
import 'package:amazonclone/utils/constants.dart';
import 'package:amazonclone/widgets/banner_ads_widget.dart';
import 'package:amazonclone/widgets/categories_horizontal_listView_bar.dart';
import 'package:amazonclone/widgets/products_showcase_list_view.dart';
import 'package:amazonclone/widgets/search_bar_widget.dart';
import 'package:flutter/material.dart';

import '../widgets/loading _widget.dart';
import '../widgets/user_details_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  ScrollController controller=ScrollController();
  double offset=0;
  List<Widget>? discount70;
  List<Widget>? discount60;
  List<Widget>? discount50;
  List<Widget>? discount0;
  @override
  void initState() {
    super.initState();
    getData();
    controller.addListener(() { 
     setState(() {
       offset=controller.position.pixels;
     });
    });
  }
  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }
  void getData()async{
    List<Widget> temp70=await CloudFireStore().getProductDiscount(70);
    List<Widget> temp60=await CloudFireStore().getProductDiscount(60);
    List<Widget> temp50=await CloudFireStore().getProductDiscount(50);
    List<Widget> temp0=await CloudFireStore().getProductDiscount(0);
    setState(() {
      discount70=temp70;
      discount60=temp60;
      discount50=temp50;
      discount0=temp0;

    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:SearchBarWidget(isReadOnly: true , hasBackButton: false,),
      body:discount70 !=null && discount60!=null && discount50!=null && discount0!=null? Stack(
        children: [
          SingleChildScrollView(
            controller: controller,
            child: Column(
              children: [
                const SizedBox(height: kAppBarHeight/2,),
                const CategoriesHorizontalListViewBar(),
                const BannerAdWidget(),
                ProductsShowcaseListView(title: "Upto 70% off", children: discount70!),
                ProductsShowcaseListView(title: "Upto 60% off", children: discount60!),
                ProductsShowcaseListView(title: "Upto 50% off", children:discount50!),
                ProductsShowcaseListView(title: "Explore", children: discount0!),
              ],
            ),
          ),
          UserDetailsBar(offset: offset),
        ],
      ):LoadingWidget(),
    );
  }
}
