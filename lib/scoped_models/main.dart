import 'package:mallet_user/scoped_models/auth.dart';
import 'package:mallet_user/scoped_models/mall.dart';
import 'package:mallet_user/scoped_models/shop.dart';
import 'package:scoped_model/scoped_model.dart';
import 'connected_models.dart';

class MainModel extends Model with ConnectedModels, MallModel,ShopModel {

}