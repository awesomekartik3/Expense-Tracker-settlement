import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Expense {
  final String id;
  final String title;
  final double amount;
  final String paidById;
  final List<String> splitAmongIds; // IDs of people sharing this expense
  final DateTime date;

  Expense({
    String? id,
    required this.title,
    required this.amount,
    required this.paidById,
    required this.splitAmongIds,
    DateTime? date,
  })  : id = id ?? uuid.v4(),
        date = date ?? DateTime.now();

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'amount': amount,
        'paidById': paidById,
        'splitAmongIds': splitAmongIds,
        'date': date.toIso8601String(),
      };

  factory Expense.fromJson(Map<String, dynamic> json) => Expense(
        id: json['id'] as String,
        title: json['title'] as String,
        amount: (json['amount'] as num).toDouble(),
        paidById: json['paidById'] as String,
        splitAmongIds: List<String>.from(json['splitAmongIds']),
        date: DateTime.parse(json['date'] as String),
      );
}
