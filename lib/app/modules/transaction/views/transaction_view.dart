import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:montra/app/shared/widgets/custom_text_form_field.dart';
import '../../../data/model/expense_model.dart';
import '../controllers/transaction_controller.dart';
import 'package:intl/intl.dart';

class TransactionView extends GetView<TransactionController> {
  const TransactionView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<TransactionController>(
          builder: (controller) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Category Dropdown
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: DropdownButton<int>(
                    value: controller.selectedCategoryId,
                    hint: const Text('Select Category'),
                    items: controller.categories.map((category) {
                      return DropdownMenuItem<int>(
                        value: category.id,
                        child: Text(category.name ?? ""),
                      );
                    }).toList(),
                    onChanged: (value) {
                      controller.onCategoryChanged(value);
                    },
                    isExpanded: true, // Make dropdown take full width
                  ),
                ),
                // Search TextField
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CustomTextField(
                    controller: controller.searchController,
                    hint: 'Search transactions...',
                  ),
                ),

                // Transactions List
                Expanded(
                  child: ListView.builder(
                    itemCount: controller.transactions.length,
                    itemBuilder: (_, index) {
                      var transaction = controller.transactions[index];
                      return _buildTransactionTile(transaction);
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
Widget _buildTransactionTile(Expense transaction) {
  // Format Date and Time
  String formattedTime = DateFormat('hh:mm a').format(transaction.time);

  return Dismissible(
    key: Key(transaction.id.toString()), // Use a unique key for each item
    direction: DismissDirection.endToStart,
    onDismissed: (direction) {
      // Call the deleteTransaction method from the controller
      Get.find<TransactionController>().deleteTransaction(transaction.id);
    },
    background: Container(
      color: Colors.redAccent,
      child: const Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Icon(Icons.delete, color: Colors.white),
        ),
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: const Offset(0, 5),
              blurRadius: 15,
            ),
          ],
        ),
        child: Row(
          children: [
            // Icon
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.orangeAccent,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: const Icon(Icons.shopping_bag, color: Colors.white),
            ),
            const SizedBox(width: 16.0),
            // Transaction Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaction.name,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  // Combined Amount and Time
                  Text(
                    "- \$${transaction.amount.toStringAsFixed(2)}  •  $formattedTime",
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
            ),
            // Edit Button
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                Get.toNamed('/expense', arguments: {'id': transaction.id});
              },
            ),
          ],
        ),
      ),
    ),
  );
}

}
