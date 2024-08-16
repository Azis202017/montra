import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:montra/app/constant/dio_constant.dart';
import 'package:montra/app/data/model/user_model.dart';
import '../../../data/model/expense_model.dart';

class HomeController extends GetxController {
  final dio = Dio();
  var isLoading = true.obs;
  var expenses = <Expense>[].obs;
  GetStorage storage = GetStorage();
  User? user;

  @override
  void onInit() {
    getUser();

    super.onInit();
    fetchExpenses();
  }

  void getUser() {
    storage.read('user');
    if (storage.read('user') != null) {
      user = User.fromJson(storage.read('user'));
    }
  }

  void fetchExpenses() async {
    try {
      isLoading(true);
      dio.options.headers['Authorization'] =
          'Bearer ${GetStorage().read('token')}';
      final response = await dio.get('$url/expense', queryParameters: {});
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        expenses.value = data.map((json) => Expense.fromJson(json)).toList();
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch expenses: $e');
    } finally {
      isLoading(false);
    }
  }
}
