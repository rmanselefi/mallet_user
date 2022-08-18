import 'package:flutter/material.dart';
import 'package:mallet_user/models/mall.dart';
import 'package:mallet_user/scoped_models/main.dart';
import 'package:mallet_user/ui/mall/mall_detail.dart';
import 'package:mallet_user/widgets/nearby_reusablcard.dart';
import 'package:responsive_grid/responsive_grid.dart';


class SeeAllNearby extends StatefulWidget {
  final List<Mall>? malls;
  final MainModel? model;

  SeeAllNearby(this.malls,this.model);
  @override
  _SeeAllNearbyState createState() => _SeeAllNearbyState();
}

class _SeeAllNearbyState extends State<SeeAllNearby> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Nearby Buildings',
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
              children: widget.malls!.map<Widget>((f) {
                return InkWell(
                  onTap: () {
                    widget.model!.selectMall(f.Id.toString());
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MallDetail(f,widget.model)),
                    );
                  },
                  child: NearbyReusableCard(f),
                );
              }).toList()))
    );
  }
}
