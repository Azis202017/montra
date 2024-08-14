import 'package:dio/dio.dart';
import 'package:montra/app/data/model/input/auth/login_input.dart';
import 'package:montra/app/data/model/input/auth/register_input.dart';

import '../../constant/dio_constant.dart';

class AuthService {
  late Dio dio;
  AuthService({Dio? dio}) {
    this.dio = dio ?? Dio();
  }
  Future<bool> login({required LoginInput inputLogin}) async {
    try {
      Map<String, dynamic> data = {
        'email': inputLogin.email,
        'password': inputLogin.password,
      };
      Response response = await dio.post('$url/login', data: data);
      bool isSuccessRegister = response.statusCode == 200;
      if (isSuccessRegister) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> register({required RegisterInput inputRegister}) async {
    try {
      Map<String, dynamic> data = {
        'name': inputRegister.name,
        'email': inputRegister.email,
        'password': inputRegister.password,
        'password_confirmation': inputRegister.passwordConfirmation
      };
      Response response = await dio.post('/register', data: data);
      bool isSuccessRegister = response.statusCode == 200;
      if (isSuccessRegister) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
