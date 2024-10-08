import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:montra/app/data/model/input/auth/login_input.dart';
import 'package:montra/app/data/model/input/auth/register_input.dart';

import '../../constant/dio_constant.dart';
import '../model/user_model.dart';

class AuthService {
  late Dio dio;
  String _message = "";

  AuthService({Dio? dio}) {
    this.dio = dio ?? Dio(options);
  }
  String get message => _message;
  Future<bool> login({required LoginInput inputLogin}) async {
    try {
      Map<String, dynamic> data = {
        'email': inputLogin.email,
        'password': inputLogin.password,
      };
      Response response = await dio.post('$url/login', data: data);
      bool isLoginSuccess = response.statusCode == 200;
      if (isLoginSuccess) {
        Map<String, dynamic> map = {
          "name": response.data['user']['name'],
          "email": response.data['user']['email'],
        };
        User user = User.fromMap(map);
        GetStorage().write('token', response.data['token']);
        if (GetStorage().read('user') == null) {
          GetStorage().write('user', user.toJson());
        }
        return true;
      } else {
        _message = response.data['message'];
        return false;
      }
    } catch (e) {
      _message = e.toString();

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
      } else {
        _message = response.data['message'];

        return false;
      }
    } catch (e) {
      _message = e.toString();
      return false;
    }
  }
}
