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

  // Show interstitial ad every 3 expenses saved
  static int _saveCount = 0;

  @override
  void initState() {
    super.initState();
    if (widget.expense != null) {
      _titleController.text = widget.expense!.title;
      // Format number without unnecessary .0 for cleaner editing
      final amt = widget.expense!.amount;
      _amountController.text = amt % 1 == 0 ? amt.toInt().toString() : amt.toString();
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
        } else {
          // If editing and selected payer is no longer valid, fallback
          if (!provider.people.any((p) => p.id == _selectedPayerId) && provider.people.isNotEmpty) {
            _selectedPayerId = provider.people.first.id;
          }
        }
      });
    });
  }

  void _saveExpense() {
    final title = _titleController.text.trim();
    final amountText = _amountController.text.trim().replaceAll(',', '');

    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter an expense description/title.')),
      );
      return;
    }

    if (amountText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter an amount.')),
      );
      return;
    }

    final amount = double.tryParse(amountText);
    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid positive number for amount.')),
      );
      return;
    }

    if (_selectedPayerId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select who paid for this expense.')),
      );
      return;
    }

    if (_selectedSplitAmongIds.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select at least one person to split with.')),
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

    final isEdit = widget.expense != null;
    if (isEdit) {
      context.read<ExpenseProvider>().updateExpense(expense);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Updated "$title" successfully!'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } else {
      context.read<ExpenseProvider>().addExpense(expense);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Added "$title" successfully!'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }

    // Show interstitial every 3rd expense save
    _saveCount++;
    if (_saveCount % 3 == 0 && AdService.instance.isInterstitialReady) {
      AdService.instance.showInterstitialAd();
    }

    Navigator.pop(context);
  }

  void _toggleSelectAll(List people) {
    setState(() {
      if (_selectedSplitAmongIds.length == people.length) {
        _selectedSplitAmongIds.clear();
      } else {
        _selectedSplitAmongIds.clear();
        _selectedSplitAmongIds.addAll(people.map((p) => p.id));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ExpenseProvider>();
    final people = provider.people;
    final isEditing = widget.expense != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditing ? 'Edit Expense' : 'New Expense',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Title Input
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white.withOpacity(0.08)),
              ),
              child: TextField(
                controller: _titleController,
                style: const TextStyle(fontSize: 17, color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'What was it for?',
                  hintText: 'e.g. Dinner, Groceries, Hotel booking',
                  labelStyle: TextStyle(color: Colors.grey),
                  hintStyle: TextStyle(color: Colors.white24),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(16),
                  prefixIcon: Icon(Icons.description_outlined, color: Color(0xFF3B82F6)),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Amount Input
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white.withOpacity(0.08)),
              ),
              child: TextField(
                controller: _amountController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF10B981)),
                decoration: InputDecoration(
                  labelText: 'Amount (${provider.selectedCurrency.code})',
                  hintText: '0.00',
                  labelStyle: const TextStyle(color: Colors.grey, fontSize: 15),
                  hintStyle: const TextStyle(color: Colors.white24),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.all(16),
                  prefixText: '${provider.currency} ',
                  prefixStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF10B981)),
                ),
              ),
            ),
            const SizedBox(height: 28),

            // Who Paid Selector
            const Text(
              'Who paid?',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white.withOpacity(0.08)),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: people.any((p) => p.id == _selectedPayerId) ? _selectedPayerId : (people.isNotEmpty ? people.first.id : null),
                  isExpanded: true,
                  dropdownColor: const Color(0xFF1E293B),
                  icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFF3B82F6)),
                  items: people.map((person) {
                    return DropdownMenuItem(
                      value: person.id,
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 12,
                            backgroundColor: const Color(0xFF3B82F6).withOpacity(0.2),
                            child: Text(
                              person.name.isNotEmpty ? person.name[0].toUpperCase() : '?',
                              style: const TextStyle(fontSize: 12, color: Color(0xFF60A5FA), fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(person.name, style: const TextStyle(fontSize: 16, color: Colors.white)),
                        ],
                      ),
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
            const SizedBox(height: 28),

            // Split Among Selector
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Split equally among:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
                ),
                TextButton(
                  onPressed: () => _toggleSelectAll(people),
                  child: Text(
                    _selectedSplitAmongIds.length == people.length ? 'Deselect All' : 'Select All',
                    style: const TextStyle(color: Color(0xFF60A5FA), fontWeight: FontWeight.w600, fontSize: 13),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white.withOpacity(0.08)),
              ),
              child: Column(
                children: people.map((person) {
                  final isChecked = _selectedSplitAmongIds.contains(person.id);
                  return CheckboxListTile(
                    title: Text(
                      person.name,
                      style: TextStyle(
                        fontSize: 15,
                        color: isChecked ? Colors.white : Colors.grey[400],
                        fontWeight: isChecked ? FontWeight.w600 : FontWeight.normal,
                      ),
                    ),
                    activeColor: const Color(0xFF3B82F6),
                    checkColor: Colors.white,
                    value: isChecked,
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
            const SizedBox(height: 36),

            // Save / Update Button
            ElevatedButton(
              onPressed: _saveExpense,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3B82F6),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 8,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(isEditing ? Icons.check_circle_outline : Icons.add_circle_outline, size: 22),
                  const SizedBox(width: 8),
                  Text(
                    isEditing ? 'Update Expense' : 'Save Expense',
                    style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
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
