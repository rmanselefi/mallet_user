import 'package:flutter/material.dart';
import 'package:mallet_user/models/platform.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PlatformService extends ChangeNotifier {
  List<Platform> platforms=[];

  void getPlatformImages() async {
    try {
      var docs = await FirebaseFirestore.instance.collection('platform').get();
      if (docs.docs.isNotEmpty) {
        for (var i = 0; i < docs.docs.length; i++) {
          var data = docs.docs[i].data();
          final Platform platform = Platform(
            url: data.containsKey('image') ? data['image'] : '',
          );
          platforms.add(platform);
          notifyListeners();

        }
      }

    }
    catch (error) {
      print('erroror $error');
    }
  }
  List<Platform> get platformList => platforms;
}