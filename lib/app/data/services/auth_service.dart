import 'package:dio/dio.dart';
import 'package:montra/app/constant/dio_constant.dart';
import 'package:montra/app/data/model/input/auth/login_input.dart';
import 'package:montra/app/data/model/input/auth/register_input.dart';

class AuthService {
  Future<bool> login({required LoginInput inputRegister}) async {
    try{
      Map<String,dynamic> data = {
        'email' : inputRegister.email,
        'password': inputRegister.password,
      };
      Response response = await dio.post('/login', data: data);
      bool isSuccessRegister = response.statusCode == 200;
      if(isSuccessRegister) {
        return true;
      }
      return false;
    }catch(e) {
      return false;
    }
  }
  Future<bool> register({required RegisterInput inputRegister}) async {
    try{
      Map<String,dynamic> data = {
        'name' : inputRegister.name,
        'email' : inputRegister.email,
        'password': inputRegister.password,
        'password_confirmation': inputRegister.passwordConfirmation
      };
      Response response = await dio.post('/register', data: data);
      bool isSuccessRegister = response.statusCode == 200;
      if(isSuccessRegister) {
        return true;
      }
      return false;
    }catch(e) {
      return false;
    }
  }
}
