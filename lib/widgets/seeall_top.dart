import 'package:flutter/material.dart';
import 'package:mallet_user/models/product.dart';
import 'package:mallet_user/models/shop.dart';
import 'package:mallet_user/scoped_models/main.dart';
import 'package:mallet_user/widgets/shop_top_card.dart';
import 'package:responsive_grid/responsive_grid.dart';

class SeeAllTop extends StatefulWidget {
  final List<Shop> shops;
  final MainModel? model;
  SeeAllTop(this.shops, this.model);

  @override
  _SeeAllTopState createState() => _SeeAllTopState();
}

class _SeeAllTopState extends State<SeeAllTop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Nearby Top Services',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color(0xff2a2e42),
          leading: IconButton(
              padding: EdgeInsets.only(right: 10.0),
              icon: Icon(
                Icons.arrow_back,
              ),
              color: Color(0xff29b6f6),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ),
        body: Container(
            decoration: BoxDecoration(color: Color(0xff2a2e42)),
            padding: EdgeInsets.all(10.0),
            child: ResponsiveGridList(
                minSpacing: 5,
                desiredItemWidth:
                    MediaQuery.of(context).size.width > 370 ? 180 : 120,
                scroll: true,
                children: widget.shops.map<Widget>((f) {
                  return ShopTopCard(model: widget.model, floorShop: f);
                }).toList())));
  }
}
