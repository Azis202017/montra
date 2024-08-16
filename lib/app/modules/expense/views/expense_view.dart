import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:montra/app/data/model/wallet_model.dart';
import 'package:montra/app/shared/widgets/custom_text_form_field.dart';

import '../../../data/model/category_model.dart';
import '../../../shared/theme/colors.dart';
import '../../../shared/theme/font.dart';
import '../controllers/expense_controller.dart';

class ExpenseView extends GetView<ExpenseController> {
  const ExpenseView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ExpenseController());
    return GetBuilder<ExpenseController>(builder: (_) {
      return controller.isLoading
          ? const Material(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Scaffold(
              backgroundColor: red100,
              appBar: AppBar(
                foregroundColor: Colors.white,
                title: Text(
                  'Expense',
                  style: title3.copyWith(color: Colors.white),
                ),
                backgroundColor: red100,
                centerTitle: true,
              ),
              body: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 50,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "How Much?",
                          style: title3.copyWith(color: Colors.white),
                        ),
                        TextFormField(
                          controller: controller.amount,
                          keyboardType: TextInputType.number,
                          style: titleX.copyWith(color: light100),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Amount is required';
                            }
                            return null;
                          },
                          autovalidateMode: AutovalidateMode.always,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              hintText: "0",
                              hintStyle: titleX.copyWith(color: light100),
                              errorStyle: title3.copyWith(color: light100)),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: DraggableScrollableSheet(
                      maxChildSize: 1,
                      minChildSize: 0.3,
                      initialChildSize: 0.3,
                      expand: false,
                      builder: (_, scrollController) {
                        return Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16.0),
                          decoration: const BoxDecoration(
                            color: light100, // Use the same background color
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(16.0)),
                          ),
                          child: SingleChildScrollView(
                            controller: scrollController,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomTextField(
                                  controller: controller.name,
                                  hint: "Description",
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                DropdownSearch<Category>(
                                  popupProps: const PopupProps.menu(
                                      showSearchBox: true),
                                  dropdownDecoratorProps:
                                      const DropDownDecoratorProps(
                                    dropdownSearchDecoration: InputDecoration(
                                      hintText: "Category",
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: 16,
                                      ),
                                    ),
                                  ),
                                  validator: (Category? category) {
                                    if (category == null) {
                                      return 'Wallet is required';
                                    }
                                    return null;
                                  },
                                  autoValidateMode: AutovalidateMode.always,
                                  items: controller.listCategory,
                                  itemAsString: (Category category) =>
                                      category.name ?? "",
                                  selectedItem: controller.selectedCategory,
                                  onChanged: controller.onChangeCategory,
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                DropdownSearch<Wallet>(
                                  popupProps: const PopupProps.menu(
                                      showSearchBox: true),
                                  dropdownDecoratorProps:
                                      const DropDownDecoratorProps(
                                    dropdownSearchDecoration: InputDecoration(
                                      hintText: "Wallet",
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: 16,
                                      ),
                                    ),
                                  ),
                                  autoValidateMode: AutovalidateMode.always,
                                  validator: (Wallet? wallet) {
                                    if (wallet == null) {
                                      return 'Wallet is required';
                                    }
                                    return null;
                                  },
                                  items: controller.listWallet,
                                  itemAsString: (Wallet wallet) =>
                                      wallet.name ?? "",
                                  selectedItem: controller.selectedWallet,
                                  onChanged: controller.onChangeWallet,
                                ),
                                CustomTextField(
                                  controller: controller.timeController,
                                  readOnly: true,
                                  hint: controller.timeController.text,
                                  suffixIcon: InkWell(
                                    onTap: controller.pickDateTime,
                                    child: const Icon(Icons.date_range),
                                  ),
                                ),
                                const SizedBox(
                                  height: 23,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  height: 50,
                                  child: ElevatedButton(
                                    onPressed: controller.submitExpense,
                                    child: const Text('Save'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
    });
  }
}
