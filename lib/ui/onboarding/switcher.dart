import 'package:flutter/material.dart';
import 'package:mallet_user/models/mall.dart';
import 'package:mallet_user/models/user_location.dart';
import 'package:mallet_user/scoped_models/main.dart';
import 'package:mallet_user/services/mall_service.dart';
import 'package:mallet_user/ui/home/home.dart';
import 'package:mallet_user/ui/onboarding/onboarding.dart';
import 'package:provider/provider.dart';

class Switcher extends StatefulWidget {
  final isFirstTime;
  final UserLocation? userLocation;
  final MainModel? model;
  Switcher(this.userLocation,this.isFirstTime,this.model);
  @override
  _SwitcherState createState() => _SwitcherState();
}

class _SwitcherState extends State<Switcher> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    List<Mall> malls = Provider.of<List<Mall>>(context);
    return widget.isFirstTime
        ? OnBoardingPage(widget.model, widget.userLocation,malls)
        : Home(widget.model, widget.userLocation,malls);
    // return Container();
  }
}
