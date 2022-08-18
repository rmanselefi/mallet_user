import 'package:flutter/material.dart';
import 'package:mallet_user/models/mall.dart';
import 'package:mallet_user/models/user_location.dart';
import 'package:mallet_user/scoped_models/main.dart';
import 'package:mallet_user/ui/nearby/nearby_card.dart';
import 'package:mallet_user/widgets/platform_carousel.dart';
import 'package:mallet_user/widgets/custom_divider.dart';
import 'package:mallet_user/widgets/seeall_floor.dart';
import 'package:mallet_user/widgets/seeall_nearby.dart';
import 'package:mallet_user/widgets/seeall_top.dart';
import 'package:mallet_user/widgets/top_product_card.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:provider/provider.dart';

class NearByComp extends StatefulWidget {
  final UserLocation? userLocation;
  final List<Mall>? malls;
  final MainModel? model;
  NearByComp({this.userLocation, this.malls, this.model});
  @override
  _NearByCompState createState() => _NearByCompState();
}

class _NearByCompState extends State<NearByComp> {
  @override
  Widget build(BuildContext context) {
    List<Mall>? malls = widget.malls;
    return Container(
      decoration: BoxDecoration(
        color: Color(0xff2a2e42)
      ),
//      padding: EdgeInsets.only(top: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 15.0,
            child: Container(
              color: Color(0xff2a2e42),
            ),
          ),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: <Widget>[
                Container(child: PlatformCarousel()),
                SizedBox(
                  height: 5.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomDivider(name: 'NearBy Buildings'),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      SeeAllNearby(malls, widget.model)),
                            );
                          },
                          child: Text(
                            "See all",
                            style: TextStyle(
                                color: Color(0xff29b6f6),
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                ScopedModelDescendant(builder:
                    (BuildContext context, Widget child, MainModel model) {
                  return NearByCard(
                    model: model,
                    malls: malls,
                    userLocation: widget.userLocation,
                  );
                }),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomDivider(name: 'NearBy Top services'),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SeeAllTop(
                                      widget.model!.nearTopList, widget.model)),
                            );
                          },
                          child: Text(
                            "See all",
                            style: TextStyle(
                                color: Color(0xff29b6f6),
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.0,
                ),
                ScopedModelDescendant(builder:
                    (BuildContext context, Widget child, MainModel model) {
                  return TopProductCard(
                    toplist: model.nearTopList,
                    model: model,
                    userLocation: widget.userLocation,
                  );
                }),
              ],
            ),
          )
        ],
      ),
    );
  }
}
