import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mallet_user/models/mall.dart';
import 'package:mallet_user/models/user_location.dart';
import 'package:mallet_user/scoped_models/main.dart';
import 'package:mallet_user/services/mall_service.dart';
import 'package:mallet_user/ui/nearby/nearby_comp.dart';
import 'package:mallet_user/scoped_models/main.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';

class Nearby extends StatefulWidget {
  final MainModel? model;
  final UserLocation? currentLocation;
  final List<Mall>? malls;
  const Nearby(this.model, this.currentLocation, this.malls);
  @override
  _NearbyState createState() => _NearbyState();
}

class _NearbyState extends State<Nearby> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.model!.fetchMallNames();
    widget.model!.fetchAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    var currentLocation = widget.currentLocation;
    return NearByComp(
      userLocation: currentLocation,
      malls: widget.malls,
      model:widget.model
    );
  }
}
