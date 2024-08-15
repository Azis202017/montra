import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../data/model/expense_model.dart';
import '../controllers/home_controller.dart';
import 'package:intl/intl.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final RxString selectedFilter = "Hari Ini".obs; // Filter default
    String? previousDay;

    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.expenses.isEmpty) {
          return RefreshIndicator(
            onRefresh: () async => controller.fetchExpenses(),
            child: const SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Center(child: Text('No expenses found')),
            ),
          );
        }

        // Dapatkan daftar pengeluaran yang sudah difilter
        List<Expense> filteredExpenses =
            _filterExpensesByDate(selectedFilter.value);

        // Kelompokkan pengeluaran berdasarkan tanggal
        Map<String, double> groupedExpenses =
            _groupExpensesByDate(filteredExpenses);

        // Ubah data menjadi FlSpot untuk LineChart
        List<FlSpot> spots = _convertGroupedExpensesToSpots(groupedExpenses);

        return RefreshIndicator(
          onRefresh: () async {
            controller.fetchExpenses();
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                // Dropdown Filter
                _buildDropdownFilter(selectedFilter),
                // Line Chart
                _buildLineChart(spots, groupedExpenses, previousDay),
                // Expense List
                _buildExpenseList(groupedExpenses),
              ],
            ),
          ),
        );
      }),
    );
  }

  // Fungsi untuk membangun dropdown filter
  Widget _buildDropdownFilter(RxString selectedFilter) {
    final filterOptions = ["Hari Ini", "30 Hari Terakhir", "1 Tahun Terakhir"];
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownButton<String>(
        value: selectedFilter.value,
        onChanged: (String? newValue) {
          if (newValue != null) {
            selectedFilter.value = newValue;
          }
        },
        items: filterOptions.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  // Fungsi untuk membangun LineChart
  Widget _buildLineChart(List<FlSpot> spots,
      Map<String, double> groupedExpenses, String? previousDay) {
    return SizedBox(
      height: 200,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: LineChart(
          LineChartData(
            gridData: const FlGridData(show: true),
            titlesData: FlTitlesData(
              topTitles:
                  const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    final date =
                        DateTime.fromMillisecondsSinceEpoch(value.toInt());
                    String formattedDate =
                        DateFormat('yyyy-MM-dd').format(date);
                    if (groupedExpenses.containsKey(formattedDate)) {
                      String currentDay = DateFormat('E', 'id_ID').format(date);
                      if (previousDay == currentDay) {
                        return const SizedBox();
                      } else {
                        previousDay = currentDay;
                        return Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(currentDay),
                        );
                      }
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ),
              leftTitles: const AxisTitles(
                sideTitles: SideTitles(
                  showTitles: false, // Menyembunyikan sumbu Y
                ),
              ),
              rightTitles:
                  const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            ),
            lineBarsData: [
              LineChartBarData(
                spots: spots,
                isCurved: true,
                barWidth: 3,
                color: Colors.purple,
                dotData: const FlDotData(show: false),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Fungsi untuk membangun daftar pengeluaran
  Widget _buildExpenseList(Map<String, double> groupedExpenses) {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: groupedExpenses.length,
      itemBuilder: (context, index) {
        final entry = groupedExpenses.entries.toList()[index];
        DateTime date = DateFormat('yyyy-MM-dd').parse(entry.key);
        String formattedDay =
            DateFormat('EEEE, dd MMMM yyyy', 'id_ID').format(date);

        return ListTile(
          title: Text(formattedDay),
          subtitle: Text('Total: \$${entry.value.toString()}'),
        );
      },
    );
  }

  // Fungsi untuk memfilter pengeluaran berdasarkan tanggal
  List<Expense> _filterExpensesByDate(String selectedFilter) {
    final now = DateTime.now();
    return controller.expenses.where((expense) {
      switch (selectedFilter) {
        case "Hari Ini":
          return DateFormat('yyyy-MM-dd').format(expense.time) ==
              DateFormat('yyyy-MM-dd').format(now);
        case "30 Hari Terakhir":
          return expense.time.isAfter(now.subtract(const Duration(days: 30)));
        case "1 Tahun Terakhir":
          return expense.time.isAfter(now.subtract(const Duration(days: 365)));
        default:
          return true;
      }
    }).toList();
  }

  // Fungsi untuk mengelompokkan pengeluaran berdasarkan tanggal
  Map<String, double> _groupExpensesByDate(List<Expense> expenses) {
    Map<String, double> groupedExpenses = {};
    for (var expense in expenses) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(expense.time);
      if (groupedExpenses.containsKey(formattedDate)) {
        groupedExpenses[formattedDate] =
            groupedExpenses[formattedDate]! + expense.amount;
      } else {
        groupedExpenses[formattedDate] = expense.amount;
      }
    }
    return groupedExpenses;
  }

  // Fungsi untuk mengubah groupedExpenses menjadi FlSpot
  List<FlSpot> _convertGroupedExpensesToSpots(
      Map<String, double> groupedExpenses) {
    return groupedExpenses.entries.map((entry) {
      DateTime date = DateFormat('yyyy-MM-dd').parse(entry.key);
      return FlSpot(
        date.millisecondsSinceEpoch.toDouble(),
        entry.value,
      );
    }).toList();
  }
}
