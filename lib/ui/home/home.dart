import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mallet_user/models/mall.dart';
import 'package:mallet_user/models/shop.dart';
import 'package:mallet_user/models/user_location.dart';
import 'package:mallet_user/scoped_models/main.dart';
import 'package:mallet_user/services/location_services.dart';
import 'package:mallet_user/services/mall_service.dart';
import 'package:mallet_user/ui/nearby/nearby.dart';
import 'package:mallet_user/ui/search/search_delgate.dart';
import 'package:mallet_user/widgets/custom_drawer.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:geolocator/geolocator.dart';

class Home extends StatefulWidget {
  final MainModel? model;
  final UserLocation? userLocation;
  List<Mall>? malls;
  Home(this.model, this.userLocation, this.malls);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _saving = false;
  UserLocation? currentLocation;
  List<Mall> mallList = [];
  List<Shop> shops = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          titleSpacing: 0.0,
          backgroundColor: Color(0xff2a2e42),
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(
                  Icons.menu,
                  color: Color(0xff29b6f6),
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
          title: Text('Mall ET',style: TextStyle(color: Colors.white),),
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.search,
                  color: Color(0xff29b6f6),
                ),
                onPressed: () {
                  showSearch(context: context, delegate: DataSearch());
                }),
            Image.asset(
              'assets/icon_sid.png',
              width: 40.0,
              height: 40.0,
            ),
            SizedBox(
              width: 10.0,
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.refresh),
          backgroundColor: Color(0xff29b6f6),
          onPressed: () async {
            setState(() {
              _saving = true;
            });
            widget.model!.getCurrentLocation();
            List<Mall>? malls = await widget.model!.fetchNearByMalls();
            List<Shop>? shops = await widget.model!.getTopProduct();
            if (shops != null && malls != null) {
              setState(() {
                _saving = false;
              });
            }
          },
        ),
        drawer: CustomDrawer(),
        body: ModalProgressHUD(
            inAsyncCall: _saving,
            dismissible: true,
            child: Nearby(widget.model, widget.userLocation, widget.malls)));
  }
}
