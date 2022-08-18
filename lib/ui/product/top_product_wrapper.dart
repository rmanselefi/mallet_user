import 'package:flutter/material.dart';
import 'package:mallet_user/models/shop.dart';
import 'package:mallet_user/scoped_models/main.dart';
import 'package:mallet_user/widgets/shop_top_card.dart';
import 'package:provider/provider.dart';

class TopProductWrapper extends StatefulWidget {
  final MainModel model;
  TopProductWrapper(this.model);
  @override
  _TopProductWrapperState createState() => _TopProductWrapperState();
}

class _TopProductWrapperState extends State<TopProductWrapper> {
  @override
  Widget build(BuildContext context) {
    List<Shop> shops = Provider.of<List<Shop>>(context);
    return Container(
      height: 200.0,
      child:shops!=null? ListView(
        scrollDirection: Axis.horizontal,
        children:shops.map<Widget>((f){
          return  ShopTopCard(model: widget.model,floorShop: f,);
        }).toList(),
      ):Center(child: CircularProgressIndicator(),),
    );
  }
}
