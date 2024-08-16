import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:montra/app/data/model/input/expense/expense_input.dart';
import '../../constant/dio_constant.dart';
import '../model/expense_model.dart';

class ExpenseService {
  late Dio dio;
  String _message = "";

  ExpenseService({Dio? dio}) {
    this.dio = dio ?? Dio(options);
  }

  String get message => _message;
  Future<List<Expense>> fetchExpenses({
    String? search,
    int? walletId,
    int? categoryId,
  }) async {
    try {
      dio.options.headers['Authorization'] =
          'Bearer ${GetStorage().read('token')}';
      Map<String, dynamic>? query = {
        'page': 1,
        'per_page': 10,
      };
      if (search != null) {
        query['search'] = search;
      } else if (walletId != null) {
        query['wallet_id'] = walletId;
      } else if (categoryId != null) {
        query['category_id'] = categoryId;
      }
      final response = await dio.get(
        '$url/expense',
        queryParameters: query,
      );
      if (response.statusCode == 200) {
        final List<dynamic> expensesJson = response.data['data'];
        return expensesJson.map((json) => Expense.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load expenses');
      }
    } on DioException catch (_) {
      throw Exception('Failed to load expenses');
    }
  }
  Future<Expense> fetchDetailExpense({int? id}) async{
    try {
      dio.options.headers['Authorization'] =
          'Bearer ${GetStorage().read('token')}';
      final response = await dio.get('$url/expense/$id');
      if (response.statusCode == 200) {
        final Expense expense = Expense.fromJson(response.data);
        return expense;
      } else {
        throw Exception('Failed to load expense detail');
      }
    } on DioException catch (_) {
      throw Exception('Failed to load expense detail');
    }
  }

  Future<bool> createExpense(
      {required ExpenseInput inputExpense, required int walletId}) async {
    try {
      Map<String, dynamic> data = {
        'name': inputExpense.name,
        'category_id': inputExpense.categoryId,
        'amount': inputExpense.amount,
        'time': inputExpense.time?.toIso8601String(),
      };
      dio.options.headers['Authorization'] =
          'Bearer ${GetStorage().read('token')}';
      final response =
          await dio.post('$url/wallet/$walletId/expense', data: data);

      if (response.statusCode == 200) {
        _message = "Expense created successfully.";
        return true;
      } else {
        _message = response.data['message'];
        return false;
      }
    } catch (e) {
      return false;
    }
  }
 Future<bool> updateExpense(
      {required ExpenseInput inputExpense, required int expenseId}) async {
    try {
      Map<String, dynamic> data = {
        'name': inputExpense.name,
        'category_id': inputExpense.categoryId,
        'amount': inputExpense.amount,
        'time': inputExpense.time?.toIso8601String(),
      };
      dio.options.headers['Authorization'] =
          'Bearer ${GetStorage().read('token')}';
      final response =
          await dio.put('$url/expense/$expenseId', data: data);

      if (response.statusCode == 200) {
        _message = "Expense created successfully.";
        return true;
      } else {
        _message = response.data['message'];
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteExpense({required int id}) async {
    try {
      dio.options.headers['Authorization'] = 'Bearer ${GetStorage().read('token')}';
      final response = await dio.delete('$url/expense/$id');
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
