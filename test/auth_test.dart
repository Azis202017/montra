import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:montra/app/data/model/input/auth/login_input.dart';
import 'package:montra/app/data/services/auth_service.dart';
import 'auth_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  group("Login", () {
    test("Login is successful when the data passes all of the requirements",
        () async {
      final dio = MockDio();
      Map<String, dynamic> data = {
        "email": "it@nusantarainfrastructure.com",
        "password": "HelloWorld"
      };

      when(dio.post('https://msib-6-test-7uaujedvyq-et.a.run.app/api/login',
              data: data))
          .thenAnswer((_) async {
        final response = Response<dynamic>(
          data: {
            "message": "User authenticated",
            "token": "1|bMPQsQUkGbjSxmHZ88NZslMwGfUuFBVd0G853Xb03626bd85",
            "user": {
              "id": 1,
              "name": "IT Nusantara",
              "email": "it@nusantarainfrastructure.com",
              "email_verified_at": null,
              "created_at": "2024-06-19T02:55:08.000000Z",
              "updated_at": "2024-06-19T02:55:08.000000Z"
            }
          },
          statusCode: 200,
          requestOptions: RequestOptions(
              path: 'https://msib-6-test-7uaujedvyq-et.a.run.app/api/login'),
        );


        return Future.value(response);
      });

      String email = data['email'];
      String password = data['password'];
      bool loginSuccessful = await AuthService(dio: dio)
          .login(inputLogin: LoginInput(email: email, password: password));
      expect(loginSuccessful, true);
    });
    test("Login is failed when the data for the request is unauthenticated",
        () async {
      final dio = MockDio();
      Map<String, dynamic> data = {
        "email": "its@nusantarainfrastructure.com",
        "password": "HelloWorld"
      };

      when(dio.post('https://msib-6-test-7uaujedvyq-et.a.run.app/api/login',
              data: data))
          .thenAnswer((_) async {
        final response = Response<dynamic>(
          data: {"message": "invalid credentials"},
          statusCode: 401,
          requestOptions: RequestOptions(
              path: 'https://msib-6-test-7uaujedvyq-et.a.run.app/api/login'),
        );


        return Future.value(response);
      });

      String email = data['email'];
      String password = data['password'];
      bool loginSuccessful = await AuthService(dio: dio)
          .login(inputLogin: LoginInput(email: email, password: password));
      expect(loginSuccessful, false);
    });
    test("Login is failed when the email is empty", () async {
      final dio = MockDio();
      Map<String, dynamic> data = {"email": "", "password": "HelloWorld"};

      when(dio.post('https://msib-6-test-7uaujedvyq-et.a.run.app/api/login',
              data: data))
          .thenAnswer((_) async {
        final response = Response<dynamic>(
          data: {
            "message": "The email field is required.",
            "errors": {
              "email": ["The email field is required."]
            }
          },
          statusCode: 422,
          requestOptions: RequestOptions(
              path: 'https://msib-6-test-7uaujedvyq-et.a.run.app/api/login'),
        );


        return Future.value(response);
      });

      String email = data['email'];
      String password = data['password'];
      bool loginSuccessful = await AuthService(dio: dio)
          .login(inputLogin: LoginInput(email: email, password: password));
      expect(loginSuccessful, false);
    });
    test("Login is failed when the password is empty", () async {
      final dio = MockDio();
      Map<String, dynamic> data = {"email": "aaa", "password": ""};

      when(dio.post('https://msib-6-test-7uaujedvyq-et.a.run.app/api/login',
              data: data))
          .thenAnswer((_) async {
        final response = Response<dynamic>(
          data: {
            "message": "The email field is required.",
            "errors": {
              "email": ["The email field is required."]
            }
          },
          statusCode: 422,
          requestOptions: RequestOptions(
              path: 'https://msib-6-test-7uaujedvyq-et.a.run.app/api/login'),
        );


        return Future.value(response);
      });

      String email = data['email'];
      String password = data['password'];
      bool loginSuccessful = await AuthService(dio: dio)
          .login(inputLogin: LoginInput(email: email, password: password));
      expect(loginSuccessful, false);
    });
    test("Login is failed when the password and email is empty", () async {
      final dio = MockDio();
      Map<String, dynamic> data = {"email": "aaa", "password": ""};

      when(dio.post('https://msib-6-test-7uaujedvyq-et.a.run.app/api/login',
              data: data))
          .thenAnswer((_) async {
        final response = Response<dynamic>(
          data: {
            "message": "The email field is required.",
            "errors": {
              "email": ["The email field is required."],
              "password": ['The password field is required'],
            }
          },
          statusCode: 422,
          requestOptions: RequestOptions(
              path: 'https://msib-6-test-7uaujedvyq-et.a.run.app/api/login'),
        );


        return Future.value(response);
      });

      String email = data['email'];
      String password = data['password'];
      bool loginSuccessful = await AuthService(dio: dio)
          .login(inputLogin: LoginInput(email: email, password: password));
      expect(loginSuccessful, false);
    });
  });
  group("Register", () {
    
    test("Register is successfull when the data pass all of the requirement ",
        () {

        });
   
  });
}
