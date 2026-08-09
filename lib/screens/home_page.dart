import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../providers/expense_provider.dart';
import 'add_expense_page.dart';
import 'package:intl/intl.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ExpenseProvider>();
    final expenses = provider.expenses;

    double totalExpenses = 0;
    for (var expense in expenses) {
      totalExpenses += expense.amount;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Overview', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.currency_exchange),
            onSelected: (String currency) {
              provider.setCurrency(currency);
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(value: '\$', child: Text('US Dollar (\$)')),
              const PopupMenuItem<String>(value: '€', child: Text('Euro (€)')),
              const PopupMenuItem<String>(value: '£', child: Text('British Pound (£)')),
              const PopupMenuItem<String>(value: '₹', child: Text('Indian Rupee (₹)')),
              const PopupMenuItem<String>(value: '¥', child: Text('Japanese Yen (¥)')),
              const PopupMenuItem<String>(value: 'A\$', child: Text('Australian Dollar (A\$)')),
              const PopupMenuItem<String>(value: 'C\$', child: Text('Canadian Dollar (C\$)')),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(16.0),
            padding: const EdgeInsets.all(24.0),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: const LinearGradient(
                colors: [Color(0xFF3B82F6), Color(0xFF8B5CF6)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF3B82F6).withOpacity(0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              children: [
                const Text(
                  'Total Spent',
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                ),
                const SizedBox(height: 8),
                Text(
                  "${provider.currency}${NumberFormat('#,##0.00').format(totalExpenses)}",
                  style: const TextStyle(fontSize: 42, fontWeight: FontWeight.w900, color: Colors.white),
                ),
              ],
            ),
          ).animate().fadeIn(duration: 500.ms).slideY(begin: -0.2, end: 0),
          
          Expanded(
            child: expenses.isEmpty
                ? const Center(child: Text('No expenses recorded yet.', style: TextStyle(color: Colors.grey)))
                : ListView.builder(
                    itemCount: expenses.length,
                    itemBuilder: (context, index) {
                      final expense = expenses[index];
                      final payer = provider.getPersonById(expense.paidById);
                      
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(16),
                          leading: CircleAvatar(
                            backgroundColor: const Color(0xFF3B82F6).withOpacity(0.2),
                            child: const Icon(Icons.receipt_long, color: Color(0xFF3B82F6)),
                          ),
                          title: Text(expense.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              'Paid by ${payer?.name ?? 'Unknown'}\nSplit among ${expense.splitAmongIds.length} people',
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "${provider.currency}${NumberFormat('#,##0.00').format(expense.amount)}",
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Color(0xFF10B981)),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => AddExpensePage(expense: expense),
                                        ),
                                      );
                                    },
                                    child: const Icon(Icons.edit_outlined, size: 20, color: Colors.blueAccent),
                                  ),
                                  const SizedBox(width: 12),
                                  GestureDetector(
                                    onTap: () => provider.deleteExpense(expense.id),
                                    child: const Icon(Icons.delete_outline, size: 20, color: Colors.redAccent),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          isThreeLine: true,
                        ),
                      ).animate().fadeIn(delay: (100 * index).ms).slideX(begin: 0.1, end: 0);
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (provider.people.isEmpty) {
             ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Please add participants first!')),
            );
            return;
          }
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddExpensePage()),
          );
        },
        backgroundColor: const Color(0xFF3B82F6),
        child: const Icon(Icons.add, color: Colors.white),
      ).animate().scale(delay: 500.ms),
    );
  }
}
