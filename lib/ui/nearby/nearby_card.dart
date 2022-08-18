import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mallet_user/models/mall.dart';
import 'package:mallet_user/models/user_location.dart';
import 'package:mallet_user/scoped_models/main.dart';
import 'package:mallet_user/services/mall_service.dart';
import 'package:mallet_user/ui/mall/mall_detail.dart';
import 'package:mallet_user/ui/nearby/nearby_view.dart';
import 'package:mallet_user/widgets/nearby_reusablcard.dart';

class NearByCard extends StatefulWidget {
  final MainModel? model;
  final List<Mall>? malls;
  final UserLocation? userLocation;
  NearByCard({this.model, this.malls, this.userLocation});
  @override
  _NearByCardState createState() => _NearByCardState();
}

class _NearByCardState extends State<NearByCard> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.model!.fetchAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    var model = widget.model;
    var malls = widget.malls;
    return malls != null
        ? Container(
            height: 250.0,
            margin: EdgeInsets.only(left: 3.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0))),
            child: ListView.separated(
                separatorBuilder: (context, index) => SizedBox(
                      width: 15.0,
                    ),
                itemCount: malls.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                      onTap: () {
                        model!.selectMall(malls[index].Id.toString());
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  MallDetail(malls[index], model)),
                        );
                      },
                      child: NearbyReusableCard(malls[index]));
                }))
        : Center(
            child: CircularProgressIndicator(),
          );
  }
}
