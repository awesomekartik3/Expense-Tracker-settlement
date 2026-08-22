import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../providers/expense_provider.dart';
import '../utils/formatters.dart';

class SettlementPage extends StatelessWidget {
  const SettlementPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ExpenseProvider>();
    final settlements = provider.calculateSettlements();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settlements', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        centerTitle: true,
      ),
      body: settlements.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: const Color(0xFF10B981).withOpacity(0.15),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.check_circle_outline_rounded, size: 72, color: Color(0xFF10B981)),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'All Settled Up!',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      provider.expenses.isEmpty
                          ? 'Add expenses to see automatic debt settlements.'
                          : 'No outstanding debts. Everyone has paid their fair share.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15, color: Colors.grey[400], height: 1.4),
                    ),
                  ],
                ),
              ),
            ).animate().fadeIn(duration: 400.ms).scale()
          : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              itemCount: settlements.length,
              itemBuilder: (context, index) {
                final settlement = settlements[index];
                final fromPerson = provider.getPersonById(settlement.fromPersonId);
                final toPerson = provider.getPersonById(settlement.toPersonId);

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  color: const Color(0xFF1E293B),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(color: Colors.white.withOpacity(0.06)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        // Payer (Owes)
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 22,
                                backgroundColor: const Color(0xFFEF4444).withOpacity(0.2),
                                child: Text(
                                  fromPerson?.name.isNotEmpty == true ? fromPerson!.name[0].toUpperCase() : '?',
                                  style: const TextStyle(
                                    color: Color(0xFFF87171),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                fromPerson?.name ?? 'Unknown',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 2),
                              const Text(
                                'Owes',
                                style: TextStyle(color: Color(0xFFF87171), fontSize: 12, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),

                        // Transfer Arrow & Formatted Amount (e.g. 3,00,000)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF10B981).withOpacity(0.15),
                                  shape: BoxShape.circle,
                                  border: Border.all(color: const Color(0xFF10B981).withOpacity(0.3)),
                                ),
                                child: const Icon(Icons.arrow_forward_rounded, color: Color(0xFF10B981), size: 22),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                AppFormatters.formatCurrency(
                                  settlement.amount,
                                  provider.currency,
                                  space: true,
                                ),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 17,
                                  color: Color(0xFF10B981),
                                  letterSpacing: -0.3,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Receiver (Gets)
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 22,
                                backgroundColor: const Color(0xFF10B981).withOpacity(0.2),
                                child: Text(
                                  toPerson?.name.isNotEmpty == true ? toPerson!.name[0].toUpperCase() : '?',
                                  style: const TextStyle(
                                    color: Color(0xFF34D399),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                toPerson?.name ?? 'Unknown',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 2),
                              const Text(
                                'Receives',
                                style: TextStyle(color: Color(0xFF34D399), fontSize: 12, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ).animate().fadeIn(delay: (60 * index).ms).slideY(begin: 0.1, end: 0);
              },
            ),
    );
  }
}
