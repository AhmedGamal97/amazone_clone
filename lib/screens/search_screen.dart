import 'package:flutter/material.dart';

import '../widgets/search_bar_widget.dart';
class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchBarWidget(isReadOnly: false,hasBackButton: true,),
    );
  }
}
