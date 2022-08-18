import 'package:flutter/material.dart';
import 'package:mallet_user/models/shop.dart';
import 'package:mallet_user/scoped_models/main.dart';
import 'package:mallet_user/ui/product/product_detail.dart';
import 'package:mallet_user/ui/shop/shop_detail.dart';
import 'package:mallet_user/ui/shop/shopdetail_card.dart';
import 'package:mallet_user/widgets/general_card.dart';
import 'package:responsive_grid/responsive_grid.dart';

class SeeAllFloor extends StatefulWidget {
  final String? floorNum;
  final List<Shop>? floorData;
  final MainModel? model;

  SeeAllFloor(this.floorNum, this.floorData, this.model);

  @override
  _SeeAllPageState createState() => _SeeAllPageState();
}

class _SeeAllPageState extends State<SeeAllFloor> {
//  List<Product> allProducts=widget.model.allProducts;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.floorNum} Floor',
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
              children: widget.floorData!.map<Widget>((f) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ShopDetail(f, widget.model)),
                    );
                  },
                  child: GeneralCard(f),
                );
              }).toList())),
    );
  }
}
