import 'package:dio/dio.dart';
const String url = "https://msib-6-test-7uaujedvyq-et.a.run.app/api";
BaseOptions options = BaseOptions(
  baseUrl: url,
  headers: {
    'Accept' : 'application/json',
    'Content-Type':'application/json',
  },
  validateStatus: (code) {
    if(code! >= 200) {
      return true;
    }
    return false;
  }
);
Dio dio = Dio(options);
