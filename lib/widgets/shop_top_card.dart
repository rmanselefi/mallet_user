// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:mallet_user/models/shop.dart';
import 'package:mallet_user/scoped_models/main.dart';
import 'package:mallet_user/ui/shop/shop_detail.dart';

class ShopTopCard extends StatefulWidget {
  final MainModel? model;
  final Shop? floorShop;
  ShopTopCard({this.model, this.floorShop});
  @override
  _ShopTopCardState createState() => _ShopTopCardState();
}

class _ShopTopCardState extends State<ShopTopCard> {
  @override
  Widget build(BuildContext context) {
    var floorShops = widget.floorShop;
    var model = widget.model;
    return InkWell(
      onTap: () {
        model!.selectShop(floorShops!.Id.toString());
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ShopDetail(floorShops, model)),
        );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: Column(
          children: <Widget>[
            Material(
              elevation: 10.0,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0)),
              child: Container(
                height: 160.0,
                width: 185.0,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        topRight: Radius.circular(15.0)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black54,
                        offset: Offset(0.0, 1.0), //(x,y)
                        blurRadius: 6.0,
                      ),
                    ],
                    border: Border.all(color: Colors.black26, width: 0.4),
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: floorShops!.back_image.toString() != ''
                          ? NetworkImage(
                              floorShops.back_image.toString(),
                            )
                          : AssetImage('assets/shop_bsck.jpg') as ImageProvider,
                    )),
              ),
            ),
            Container(
              height: 55.0,
              width: 185.0,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black26, width: 0.4),
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(15.0),
                      bottomLeft: Radius.circular(15.0))),
              child: Column(
                children: <Widget>[
                  Center(
                      child: Text(
                    floorShops.shopName.toString(),
                    style: TextStyle(
                      color: Color(0xff5a5d6e),
                      fontSize: 15,
                      fontFamily: 'SegoeUI',
                    ),
                  )),
                  Container(
//                                  margin: EdgeInsets.fromLTRB(
//                                      120.0, 4.0, 0.0, 0.0),
                      child: FittedBox(
                    child: Center(
                      child: Text(
                        floorShops.shopMall.toString(),
                        style: TextStyle(
                          color: Colors.grey.withOpacity(0.8),
                          fontSize: 15,
                          fontFamily: 'SegoeUI',
                        ),
                      ),
                    ),
                  )), //
                ],
              ),
            )
          ],
        ),
      ),
//
    );
  }
}
