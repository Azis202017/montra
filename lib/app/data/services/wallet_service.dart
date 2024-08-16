import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:montra/app/data/model/input/wallet/wallet_input.dart';

import '../../constant/dio_constant.dart';
import '../model/wallet_model.dart';

class WalletService {
  late Dio dio;
  String _message = "";
  String get message => _message;

  WalletService({Dio? dio}) {
    this.dio = dio ?? Dio(options);
  }
   Future<List<Wallet>> wallet() async {
      try {
        String  uri ='$url/wallet';
        dio.options.headers['Authorization'] = 'Bearer ${GetStorage().read('token')}';

        Response response = await dio.get(uri);
        if (response.statusCode == 200) {
          List? data =
            response.data['data'];
          if (data == null || data.isEmpty) {
            return [];
          } else {
            return data.map((e) => Wallet.fromJson(e)).toList();
          }
        }
        return [];
      } catch (e) {
        throw Exception(e);
      }
    }
 Future<Wallet> fetchDetailWallet({int? id}) async{
    try {
      dio.options.headers['Authorization'] =
          'Bearer ${GetStorage().read('token')}';
      final response = await dio.get('$url/wallet/$id');
      print(response.data);
      if (response.statusCode == 200) {
        final Wallet wallet = Wallet.fromJson(response.data);
        return wallet;
      } else {
        throw Exception('Failed to load wallet detail');
      }
    } on DioException catch (_) {
      throw Exception('Failed to load wallet detail');
    }
  }
  Future<bool> createWallet({required WalletInput inputWallet}) async {
    try {
      Map<String, dynamic> data = {
        'name': inputWallet.name,
      };
      dio.options.headers['Authorization'] =
          'Bearer ${GetStorage().read('token')}';
      final response = await dio.post('$url/wallet', data: data);

      if (response.statusCode == 200) {
        _message = "Wallet created successfully.";
        return true;
      } else {
        _message = "Failed to create wallet.";
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> editWallet(
      {required int id, required WalletInput inputWallet}) async {
    try {
      Map<String, dynamic> data = {"name": inputWallet.name};
      final response = await dio.put('$url/wallet/$id', data: data);
      if (response.statusCode == 200) {
        _message = "Wallet updated successfully.";
        return true;
      } else {
        _message = "Failed to update wallet.";
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteWallet({required int id}) async {
    try {
      final response = await dio.delete('$url/wallet/$id');
      if (response.statusCode == 200) {
        _message = "Wallet deleted successfully.";
        return true;
      } else {
        _message = "Failed to delete wallet.";
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
