import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mallet_user/models/shop.dart';
import 'package:mallet_user/scoped_models/main.dart';
import 'package:mallet_user/ui/shop/shop_detail.dart';
import 'package:mallet_user/widgets/general_card.dart';

class ShopCard extends StatefulWidget {
  final MainModel? model;
  final List<Shop>? floorShop;
  ShopCard({this.model,this.floorShop});
  @override
  _ShopCardState createState() => _ShopCardState();
}

class _ShopCardState extends State<ShopCard> {
  @override
  Widget build(BuildContext context) {
    var floorShops = widget.floorShop;
    var model = widget.model;
    return Container(
      height: 250.0,
      padding: EdgeInsets.only(bottom: 20.0),
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: floorShops!.map((sf) {
          return InkWell(
            onTap: () {
              model!.selectShop(sf.Id.toString());
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ShopDetail(sf, model)),
              );
            },
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 0,horizontal: 5),
                child: GeneralCard(sf)
              ),
            ),
//
          );
        }).toList(),
      ),
    );
  }
}
