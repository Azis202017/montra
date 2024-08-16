import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; // For date formatting
import 'package:montra/app/data/services/expense_service.dart';
import 'package:montra/app/helpers/alert_error.dart';
import 'package:montra/app/helpers/alert_success.dart';
import 'package:montra/app/modules/transaction/controllers/transaction_controller.dart';

import '../../../data/model/expense_model.dart';
import '../../../data/services/category_service.dart';
import '../../../data/services/wallet_service.dart';
import '../../../data/model/category_model.dart';
import '../../../data/model/input/expense/expense_input.dart';
import '../../../data/model/wallet_model.dart';
import '../../home/controllers/home_controller.dart';

class ExpenseController extends GetxController {
  int? id;
  HomeController controller = Get.put(HomeController());
  TransactionController tfController = Get.put(TransactionController());

  TextEditingController amount = TextEditingController();
  List<Category> listCategory = [];
  List<Wallet> listWallet = [];
  TextEditingController timeController = TextEditingController();
  Expense? getDetail;
  Category selectedCategory = Category();
  Wallet selectedWallet = Wallet();
  TextEditingController name = TextEditingController();

  DateTime? selectedDateTime; // Store the selected date and time

  bool isLoading = true;

  @override
  void onInit() {
    category();
    wallet();
    if(id == null) {

    expense();
    }
    super.onInit();
  }

  void category() async {
    listCategory = await CategoryService().category();
    print(listCategory);
    isLoading = false;
    update();
  }

  void expense() async {
    if (id == null) {
      id = Get.arguments['id'];

      getDetail = await ExpenseService().fetchDetailExpense(id: id);
      amount.text = "${getDetail?.amount.toString().replaceAll("-", "")}";
      name.text = getDetail?.name ?? "";
    }

    isLoading = false;
    update();
  }

  void wallet() async {
    listWallet = await WalletService().wallet();
    isLoading = false;
    update();
  }

  void onChangeCategory(Category? category) {
    selectedCategory = category!;
    update();
  }

  void onChangeWallet(Wallet? wallet) {
    selectedWallet = wallet!;
    update();
  }

  // Method to show the date-time picker
  void pickDateTime() async {
    DateTime? selectedDate = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (selectedDate != null) {
      TimeOfDay? selectedTime = await showTimePicker(
        context: Get.context!,
        initialTime: TimeOfDay.now(),
      );

      if (selectedTime != null) {
        final DateTime fullDateTime = DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          selectedTime.hour,
          selectedTime.minute,
        );

        // Update the DateTime variable
        selectedDateTime = fullDateTime;

        // Update the TextEditingController for display purposes
        String formattedDateTime =
            DateFormat('yyyy-MM-dd HH:mm').format(fullDateTime);
        timeController.text = formattedDateTime;
        update();
      }
    }
  }

  void submitExpense() async {
    if (id == null) {
      createExpense();
    } else {
      updateExpense();
    }
  }

  void createExpense() async {
    String amountValue = amount.text;
    double amountDouble = double.tryParse(amountValue) ?? 0.0;
    String formattedAmount = amountDouble.toStringAsFixed(2);

    // Instead of parsing the formattedAmount back to double, pass it as a string
    ExpenseInput expenseInput = ExpenseInput(
      amount: formattedAmount,
      categoryId: selectedCategory.id,
      name: name.text,
      time: selectedDateTime, // Pass the DateTime object here
    );

    ExpenseService expenseService = ExpenseService();
    bool isSuccessCreateExpanse = await expenseService.createExpense(
      inputExpense: expenseInput,
      walletId: selectedWallet.id ?? 0,
    );
    // if(formKey.current)
    if (isSuccessCreateExpanse) {
      Get.back();
      controller.fetchExpenses();
      tfController.fetchTransactions();
      controller.update();
      tfController.update();
      alertSuccess(title: "Success", subtitle: "Added expense successfully");
    } else {
      alertError(title: "Error", subtitle: expenseService.message);
    }
  }

  void updateExpense() async {
    String amountValue = amount.text;
    double amountDouble = double.tryParse(amountValue) ?? 0.0;
    String formattedAmount = amountDouble.toStringAsFixed(2);

    // Instead of parsing the formattedAmount back to double, pass it as a string
    ExpenseInput expenseInput = ExpenseInput(
      amount: formattedAmount,
      categoryId: selectedCategory.id,
      name: name.text,
      time: selectedDateTime, // Pass the DateTime object here
    );

    ExpenseService expenseService = ExpenseService();
    bool isSuccessCreateExpanse = await expenseService.updateExpense(
      inputExpense: expenseInput,
      expenseId: id ?? 0,
    );
    // if(formKey.current)
    if (isSuccessCreateExpanse) {
      Get.back();
      controller.fetchExpenses();
      tfController.fetchTransactions();
      controller.update();
      tfController.update();
      alertSuccess(title: "Success", subtitle: "Update expense successfully");
    } else {
      alertError(title: "Error", subtitle: expenseService.message);
    }
  }
}
