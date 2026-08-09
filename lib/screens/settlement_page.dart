import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../providers/expense_provider.dart';
import 'package:intl/intl.dart';

class SettlementPage extends StatelessWidget {
  const SettlementPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ExpenseProvider>();
    final settlements = provider.calculateSettlements();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settlements', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: settlements.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check_circle_outline, size: 80, color: Color(0xFF10B981)),
                  SizedBox(height: 16),
                  Text(
                    'All settled up!',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'No debts to pay.',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 500.ms).scale()
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: settlements.length,
              itemBuilder: (context, index) {
                final settlement = settlements[index];
                final fromPerson = provider.getPersonById(settlement.fromPersonId);
                final toPerson = provider.getPersonById(settlement.toPersonId);

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                fromPerson?.name ?? 'Unknown',
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              const Text('Owes', style: TextStyle(color: Colors.grey)),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF10B981).withOpacity(0.2),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.arrow_forward_rounded, color: Color(0xFF10B981)),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "${provider.currency}${NumberFormat('#,##0.00').format(settlement.amount)}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 20,
                                  color: Color(0xFF10B981),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                toPerson?.name ?? 'Unknown',
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              const Text('Gets', style: TextStyle(color: Colors.grey)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ).animate().fadeIn(delay: (100 * index).ms).slideX(begin: 0.1, end: 0);
              },
            ),
    );
  }
}
