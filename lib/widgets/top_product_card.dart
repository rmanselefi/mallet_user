import 'package:flutter/material.dart';
import 'package:mallet_user/models/shop.dart';
import 'package:mallet_user/models/user_location.dart';
import 'package:mallet_user/scoped_models/main.dart';
import 'package:mallet_user/services/mall_service.dart';
import 'package:mallet_user/ui/product/top_product_wrapper.dart';
import 'package:mallet_user/widgets/shop_top_card.dart';
import 'package:provider/provider.dart';
import 'package:scoped_model/scoped_model.dart';

class TopProductCard extends StatefulWidget {
  final MainModel? model;
  final UserLocation? userLocation;
  final List<Shop>? toplist;
  TopProductCard({this.model, this.userLocation, this.toplist});
  @override
  _TopProductCardState createState() => _TopProductCardState();
}

class _TopProductCardState extends State<TopProductCard> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var model = widget.model;
    var shops = widget.toplist;
    return Container(
      height: 265.0,
      child: shops != null
          ? ListView(
              scrollDirection: Axis.horizontal,
              children: shops.map<Widget>((f) {
                return ShopTopCard(
                  model: model,
                  floorShop: f,
                );
              }).toList(),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
