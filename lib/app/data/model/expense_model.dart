class Expense {
  final int id;
  final int userId;
  final int categoryId;
  final int walletId;
  final String name;
  final double amount;
  final DateTime time;

  Expense({
    required this.id,
    required this.userId,
    required this.categoryId,
    required this.walletId,
    required this.name,
    required this.amount,
    required this.time,
  });

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      id: json['id'],
      userId: json['user_id'],
      categoryId: json['category_id'],
      walletId: json['wallet_id'],
      name: json['name'],
      amount: double.parse(json['amount']),
      time: DateTime.parse(json['time']),
    );
  }
}
