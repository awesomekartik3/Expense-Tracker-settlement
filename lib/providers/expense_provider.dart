import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/expense.dart';
import '../models/person.dart';
import '../models/settlement.dart';
import 'dart:math';

class ExpenseProvider with ChangeNotifier {
  List<Person> _people = [];
  List<Expense> _expenses = [];
  String _currency = '\$';

  ExpenseProvider() {
    _loadData();
  }

  List<Person> get people => _people;
  List<Expense> get expenses => _expenses;
  String get currency => _currency;

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    
    final peopleJson = prefs.getStringList('people');
    if (peopleJson != null) {
      _people = peopleJson.map((e) => Person.fromJson(json.decode(e))).toList();
    }

    final expensesJson = prefs.getStringList('expenses');
    if (expensesJson != null) {
      _expenses = expensesJson.map((e) => Expense.fromJson(json.decode(e))).toList();
    }
    
    _currency = prefs.getString('currency') ?? '\$';
    
    notifyListeners();
  }

  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    
    final peopleJson = _people.map((p) => json.encode(p.toJson())).toList();
    await prefs.setStringList('people', peopleJson);

    final expensesJson = _expenses.map((e) => json.encode(e.toJson())).toList();
    await prefs.setStringList('expenses', expensesJson);

    await prefs.setString('currency', _currency);
  }

  void setCurrency(String currency) {
    _currency = currency;
    _saveData();
    notifyListeners();
  }

  void addPerson(String name) {
    if (name.trim().isNotEmpty) {
      _people.add(Person(name: name.trim()));
      _saveData();
      notifyListeners();
    }
  }

  void removePerson(String id) {
    if (_expenses.any((e) => e.paidById == id || e.splitAmongIds.contains(id))) {
      return;
    }
    _people.removeWhere((p) => p.id == id);
    _saveData();
    notifyListeners();
  }

  void addExpense(Expense expense) {
    _expenses.add(expense);
    _saveData();
    notifyListeners();
  }

  void updateExpense(Expense expense) {
    final index = _expenses.indexWhere((e) => e.id == expense.id);
    if (index != -1) {
      _expenses[index] = expense;
      _saveData();
      notifyListeners();
    }
  }

  void deleteExpense(String id) {
    _expenses.removeWhere((e) => e.id == id);
    _saveData();
    notifyListeners();
  }

  Person? getPersonById(String id) {
    try {
      return _people.firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }

  List<Settlement> calculateSettlements() {
    Map<String, double> balances = {};

    for (var person in _people) {
      balances[person.id] = 0.0;
    }

    for (var expense in _expenses) {
      if (!balances.containsKey(expense.paidById)) {
        balances[expense.paidById] = 0.0;
      }
      balances[expense.paidById] = balances[expense.paidById]! + expense.amount;

      double splitAmount = expense.amount / expense.splitAmongIds.length;
      for (var splitId in expense.splitAmongIds) {
        if (!balances.containsKey(splitId)) {
          balances[splitId] = 0.0;
        }
        balances[splitId] = balances[splitId]! - splitAmount;
      }
    }

    List<MapEntry<String, double>> debtors = balances.entries
        .where((e) => e.value < -0.01)
        .map((e) => MapEntry(e.key, -e.value))
        .toList();
    List<MapEntry<String, double>> creditors = balances.entries
        .where((e) => e.value > 0.01)
        .toList();

    debtors.sort((a, b) => b.value.compareTo(a.value));
    creditors.sort((a, b) => b.value.compareTo(a.value));

    List<Settlement> settlements = [];
    int i = 0; 
    int j = 0; 

    while (i < debtors.length && j < creditors.length) {
      double debtAmount = debtors[i].value;
      double creditAmount = creditors[j].value;
      double minAmount = min(debtAmount, creditAmount);

      if (minAmount > 0.01) {
        settlements.add(Settlement(
          fromPersonId: debtors[i].key,
          toPersonId: creditors[j].key,
          amount: minAmount,
        ));
      }

      debtors[i] = MapEntry(debtors[i].key, debtAmount - minAmount);
      creditors[j] = MapEntry(creditors[j].key, creditAmount - minAmount);

      if (debtors[i].value < 0.01) {
        i++;
      }
      if (creditors[j].value < 0.01) {
        j++;
      }
    }

    return settlements;
  }
}
