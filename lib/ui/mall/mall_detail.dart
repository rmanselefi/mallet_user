import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mallet_user/scoped_models/main.dart';
import 'package:mallet_user/shared/MapUtils.dart';
import 'package:mallet_user/ui/mall/malldetail_card.dart';
import 'package:mallet_user/ui/search/search_mall.dart';
import 'package:scoped_model/scoped_model.dart';

class MallDetail extends StatefulWidget {
  final mall;
  final MainModel? model;
  const MallDetail(this.mall, this.model);

  @override
  _MallDetailState createState() => _MallDetailState();
}

class _MallDetailState extends State<MallDetail> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.model!.fetchShops();
    widget.model!.fetchProductsMall();
    widget.model!.fetchMallImages(widget.mall.Id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        leading: IconButton(
          padding: EdgeInsets.only(right: 10.0),
            icon: Icon(
              Icons.arrow_back,
            ),
            color: Color(0xff29b6f6),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        backgroundColor: Color(0xff2a2e42),
        title: Text(widget.mall.mallName,style: TextStyle(color: Colors.white),),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search,color: Color(0xff29b6f6),), onPressed: (){
            showSearch(context: context, delegate: MallSearch());
          }),
          Image.asset('assets/icon_sid.png',width: 40.0,height: 40.0,),
          SizedBox(
            width: 10.0,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          MapUtils.openMap(widget.mall.mallLatitude, widget.mall.mallLongitude);
        },
        child: Icon(Icons.location_on),
        backgroundColor: Color(0xff29b6f6),
      ),
      body: Container(
          decoration: BoxDecoration(
            color: Color(0xff2a2e42),
          ),
          child: ScopedModelDescendant(
              builder: (BuildContext context, Widget child, MainModel model) {
            return MallDetailCard(
              mall: widget.mall,
              model: model,
            );
          })),
    );
  }
}
