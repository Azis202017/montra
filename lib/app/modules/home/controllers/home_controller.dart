import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:montra/app/constant/dio_constant.dart';
import '../../../data/model/expense_model.dart';

class HomeController extends GetxController {
  final dio = Dio();
  var isLoading = true.obs;
  var expenses = <Expense>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchExpenses();
  }

  void fetchExpenses() async {
    try {
      isLoading(true);
      dio.options.headers['Authorization'] =
          'Bearer ${GetStorage().read('token')}';
      final response = await dio.get('$url/expense',queryParameters: {
        
      });
      print(response.data);
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
