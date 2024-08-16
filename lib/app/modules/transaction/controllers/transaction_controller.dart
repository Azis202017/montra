import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/model/category_model.dart';
import '../../../data/model/expense_model.dart';
import '../../../data/services/category_service.dart';
import '../../../data/services/expense_service.dart';

class TransactionController extends GetxController {
  TextEditingController searchController = TextEditingController();
  List<Expense> transactions = [];
  List<Category> categories = [];
  int? selectedCategoryId;
  bool isLoading = true;

  @override
  void onInit() {
    fetchCategories();
    fetchTransactions();

    searchController.addListener(() {
      if (searchController.text.isNotEmpty) {
        fetchTransactions(search: searchController.text);
      } else if (selectedCategoryId != null) {
        fetchTransactions(categoryId: selectedCategoryId);
      } else if (searchController.text.isNotEmpty &&
          selectedCategoryId != null) {
        {
          fetchTransactions(
              categoryId: selectedCategoryId, search: searchController.text);
          
        }
      }
    });
    super.onInit();
  }

  void fetchTransactions({String? search, int? categoryId}) async {
    isLoading = true;
    update();
      transactions = await ExpenseService()
          .fetchExpenses(search: search, categoryId: categoryId);
    // if(search == null) {
    //   transactions = await ExpenseService().fetchExpenses();

    // }
    // if (search != null) {
    //   transactions = await ExpenseService().fetchExpenses(search: search);
    // } else if (categoryId != null) {
    //   transactions = await ExpenseService()
    //       .fetchExpenses(search: search, categoryId: categoryId);
    // } else {
    //   transactions = await ExpenseService()
    //       .fetchExpenses(search: search, categoryId: categoryId);
    // }

    isLoading = false;
    update();
  }

  void fetchCategories() async {
    isLoading = true;
    categories = await CategoryService().category();
    update();
  }

  void onCategoryChanged(int? categoryId) {
    selectedCategoryId = categoryId;
    fetchTransactions(categoryId: selectedCategoryId);
  }

  void deleteTransaction(int id) async {
    await ExpenseService().deleteExpense(id: id);
    fetchTransactions(
        search: searchController.text, categoryId: selectedCategoryId);
  }
}
