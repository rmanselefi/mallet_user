import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mallet_user/scoped_models/main.dart';
import 'package:mallet_user/services/mall_service.dart';
import 'package:mallet_user/services/platform_services.dart';

import 'package:mallet_user/ui/onboarding/switcher.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';

import 'models/mall.dart';
import 'models/user_location.dart';

void main() async{
  Provider.debugCheckInvalidValueType = null;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    Provider<MallService>(create: (_) => MallService()),
    Provider<PlatformService>(create: (_) => PlatformService()),
  ], child: MyApp()));
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color(0xff29b6f6),
      statusBarIconBrightness: Brightness.light));
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  final MainModel _model = new MainModel();
  UserLocation? currentLocation;
  bool? isFirstTime = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _model.getCurrentLocation();
    _model.getTopProduct();
    _model.getPlatformImages();
    checkFirstTime();
  }

  checkFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool checkValue = prefs.containsKey('first_time');
    if (!checkValue) {
      setState(() {
        isFirstTime = true;
      });
    } else {
      setState(() {
        isFirstTime = prefs.getBool('first_time');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainModel>(
        model: _model,
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(body: ScopedModelDescendant(builder:
                    (BuildContext context, Widget child, MainModel modell) {
              return modell.currentLocation != null
                  ? FutureProvider<List<Mall>>(
                      initialData: _model.nearMall,
                      create: (context) => _model.fetchNearByMalls(),
                      child: Switcher(currentLocation, isFirstTime, _model),
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    );
            })

                // routes: {'/home': (BuildContext context) => Home(_model)},
                )));
  }
}
