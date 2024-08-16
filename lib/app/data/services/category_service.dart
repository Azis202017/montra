import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:montra/app/constant/dio_constant.dart';

import '../model/category_model.dart';

class CategoryService {
  late Dio dio;


  CategoryService({Dio? dio}) {
    this.dio = dio ?? Dio(options);
  }
  Future<List<Category>> category() async {
      try {
        String  uri ='$url/category';
        dio.options.headers['Authorization'] = 'Bearer ${GetStorage().read('token')}';
        
        Response response = await dio.get(uri);
        if (response.statusCode == 200) {
          List? data =
            response.data['data'];
          if (data == null || data.isEmpty) {
            return [];
          } else {
            return data.map((e) => Category.fromJson(e)).toList();
          }
        }
        return [];
      } catch (e) {
        throw Exception(e);
      }
    }

}