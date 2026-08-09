import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/expense.dart';
import '../providers/expense_provider.dart';
import '../services/ad_service.dart';

class AddExpensePage extends StatefulWidget {
  final Expense? expense;

  const AddExpensePage({super.key, this.expense});

  @override
  State<AddExpensePage> createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  String? _selectedPayerId;
  final Set<String> _selectedSplitAmongIds = {};

  // Show interstitial ad every 3 expenses added
  static int _saveCount = 0;

  @override
  void initState() {
    super.initState();
    if (widget.expense != null) {
      _titleController.text = widget.expense!.title;
      _amountController.text = widget.expense!.amount.toString();
      _selectedPayerId = widget.expense!.paidById;
      _selectedSplitAmongIds.addAll(widget.expense!.splitAmongIds);
    }
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<ExpenseProvider>();
      setState(() {
        if (widget.expense == null) {
          _selectedSplitAmongIds.addAll(provider.people.map((p) => p.id));
          if (provider.people.isNotEmpty) {
            _selectedPayerId = provider.people.first.id;
          }
        }
      });
    });
  }

  void _saveExpense() {
    final title = _titleController.text;
    final amountText = _amountController.text;

    if (title.isEmpty || amountText.isEmpty || _selectedPayerId == null || _selectedSplitAmongIds.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields and select at least one person.')),
      );
      return;
    }

    final amount = double.tryParse(amountText);
    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid amount.')),
      );
      return;
    }

    final expense = Expense(
      id: widget.expense?.id, // Keep same ID if editing
      title: title,
      amount: amount,
      paidById: _selectedPayerId!,
      splitAmongIds: _selectedSplitAmongIds.toList(),
      date: widget.expense?.date,
    );

    if (widget.expense == null) {
      context.read<ExpenseProvider>().addExpense(expense);
    } else {
      context.read<ExpenseProvider>().updateExpense(expense);
    }

    // Show interstitial every 3rd expense
    _saveCount++;
    if (_saveCount % 3 == 0 && AdService.instance.isInterstitialReady) {
      AdService.instance.showInterstitialAd();
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ExpenseProvider>();
    final people = provider.people;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.expense == null ? 'New Expense' : 'Edit Expense', style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(16),
              ),
              child: TextField(
                controller: _titleController,
                style: const TextStyle(fontSize: 18),
                decoration: const InputDecoration(
                  labelText: 'What was it for?',
                  labelStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(16),
                  prefixIcon: Icon(Icons.description, color: Color(0xFF3B82F6)),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(16),
              ),
              child: TextField(
                controller: _amountController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF10B981)),
                decoration: InputDecoration(
                  labelText: 'Amount',
                  labelStyle: const TextStyle(color: Colors.grey, fontSize: 16),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.all(16),
                  prefixText: provider.currency,
                  prefixStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF10B981)),
                ),
              ),
            ),
            const SizedBox(height: 32),
            const Text('Who paid?', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white70)),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(16),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedPayerId,
                  isExpanded: true,
                  icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFF3B82F6)),
                  items: people.map((person) {
                    return DropdownMenuItem(
                      value: person.id,
                      child: Text(person.name, style: const TextStyle(fontSize: 16)),
                    );
                  }).toList(),
                  onChanged: (val) {
                    setState(() {
                      _selectedPayerId = val;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 32),
            const Text('Split equally among:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white70)),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: people.map((person) {
                  return CheckboxListTile(
                    title: Text(person.name, style: const TextStyle(fontSize: 16)),
                    activeColor: const Color(0xFF3B82F6),
                    checkColor: Colors.white,
                    value: _selectedSplitAmongIds.contains(person.id),
                    onChanged: (bool? checked) {
                      setState(() {
                        if (checked == true) {
                          _selectedSplitAmongIds.add(person.id);
                        } else {
                          _selectedSplitAmongIds.remove(person.id);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: _saveExpense,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3B82F6),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 20),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 8,
              ),
              child: Text(widget.expense == null ? 'Save Expense' : 'Update Expense', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }
}
