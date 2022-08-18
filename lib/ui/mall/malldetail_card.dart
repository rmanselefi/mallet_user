import 'package:flutter/material.dart';
import 'package:mallet_user/models/shop.dart';

import 'package:mallet_user/scoped_models/main.dart';
import 'package:mallet_user/ui/category/category_list.dart';
import 'package:mallet_user/ui/mall/floor_cards.dart';
import 'package:mallet_user/widgets/carousel.dart';

class MallDetailCard extends StatefulWidget {
  final mall;
  final MainModel? model;
  MallDetailCard({this.mall, this.model});

  @override
  _MallDetailCardState createState() => _MallDetailCardState();
}

class _MallDetailCardState extends State<MallDetailCard> {
  @override
  Widget build(BuildContext context) {
    var model = widget.model;
    var name = widget.mall.mallName;
    if (!model!.isLoading && model.selectedShops.length != 0) {
      return Container(
          padding: EdgeInsets.only(top: 10.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                    child: ListView(children: <Widget>[
                  SizedBox(
                    height: 5.0,
                  ),
                  Center(
                    child: widget.model!.mallImages.length != 0
                        ? Carousel(
                            model: widget.model,
                            mall: widget.mall,
                            name: name,
                            height: 170.0)
                        : Container(
                            height: 120.0,
                            width: MediaQuery.of(context).size.width - 30.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage('assets/placeh.png'),
                                )),
                          ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    'Categories',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                        color: Color(0xfff56667)),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  model.distinctCats.length != 0
                      ? CategoryList(
                          mall: widget.mall,
                          model: model,
                        )
                      : Container(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Column(
                      children: model.floorNum.map<Widget>((floor) {
                    List<Shop> floorShops = model.selectedShops
                        .where((sh) => sh.shopFloorName == floor.shopFloorName)
                        .toList();
                    return floorShops.length != 0
                        ? FloorCard(
                            model: model,
                            mall: widget.mall,
                            index: floor,
                            floorShop: floorShops,
                          )
                        : Container();
                  }).toList())
                ])),
              ]));
    } else if (!model.isLoading && model.selectedShops.length == 0) {
      return Center(
        child: Text('No Shop to show'),
      );
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
