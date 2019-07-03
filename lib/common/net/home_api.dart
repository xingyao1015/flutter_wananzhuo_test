import 'package:dio/dio.dart';

import 'dio_manager.dart';
import '../entity/banner_entity.dart';

const _homeApi = {"banner": "banner/json"};


Future<BannerEntity> getBanner() async{
  try{
    Response response = await DioManager.instance().get(_homeApi['banner']);
    print(response.data);
    return BannerEntity.fromJson(response.data);
  }catch(e){
    print(e);
    return e;
  }
}
