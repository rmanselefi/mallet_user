import 'package:flutter/material.dart';
import 'package:mallet_user/models/shop.dart';
import 'package:mallet_user/scoped_models/main.dart';
import 'package:mallet_user/ui/shop/shop_card.dart';
import 'package:mallet_user/widgets/custom_divider.dart';
import 'package:mallet_user/widgets/seeall_floor.dart';

class FloorCard extends StatefulWidget {
  final mall;
  final MainModel? model;
  final Shop? index;
  final List<Shop>? floorShop;
  FloorCard({this.mall, this.model, this.index, this.floorShop});
  @override
  _FloorCardState createState() => _FloorCardState();
}

class _FloorCardState extends State<FloorCard> {
  @override
  Widget build(BuildContext context) {
    var model = widget.model;
    var index = widget.index;
    var floorShops = widget.floorShop;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: CustomDivider(
                name: '${index!.shopFloorName} Floor',
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SeeAllFloor(
                                index.shopFloorName.toString(), floorShops, model)),
                      );
                    },
                    child: Text(
                      "See all",
                      style: TextStyle(
                          color: Color(0xff29b6f6), fontWeight: FontWeight.bold),
                    )),
              ),
            )
          ],
        ),
        ShopCard(
          floorShop: floorShops,
          model: model,
        ),

      ],
    );
  }
}
