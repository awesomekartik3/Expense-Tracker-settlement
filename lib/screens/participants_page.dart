import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../providers/expense_provider.dart';

class ParticipantsPage extends StatefulWidget {
  const ParticipantsPage({super.key});

  @override
  State<ParticipantsPage> createState() => _ParticipantsPageState();
}

class _ParticipantsPageState extends State<ParticipantsPage> {
  final _nameController = TextEditingController();

  void _addPerson() {
    final name = _nameController.text;
    if (name.isNotEmpty) {
      context.read<ExpenseProvider>().addPerson(name);
      _nameController.clear();
      FocusScope.of(context).unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ExpenseProvider>();
    final people = provider.people;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Participants', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E293B),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: TextField(
                      controller: _nameController,
                      style: const TextStyle(fontSize: 16),
                      decoration: const InputDecoration(
                        labelText: 'Enter name',
                        labelStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                      onSubmitted: (_) => _addPerson(),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [Color(0xFF3B82F6), Color(0xFF8B5CF6)]),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: IconButton(
                    onPressed: _addPerson,
                    icon: const Icon(Icons.person_add, color: Colors.white),
                    padding: const EdgeInsets.all(14),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: people.isEmpty
                ? const Center(child: Text('No participants added yet.', style: TextStyle(color: Colors.grey)))
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: people.length,
                    itemBuilder: (context, index) {
                      final person = people[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          leading: CircleAvatar(
                            backgroundColor: const Color(0xFF8B5CF6).withOpacity(0.2),
                            child: Text(
                              person.name[0].toUpperCase(),
                              style: const TextStyle(color: Color(0xFF8B5CF6), fontWeight: FontWeight.bold),
                            ),
                          ),
                          title: Text(person.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          trailing: IconButton(
                            icon: const Icon(Icons.remove_circle_outline, color: Colors.redAccent),
                            onPressed: () {
                              provider.removePerson(person.id);
                            },
                          ),
                        ),
                      ).animate().fadeIn(delay: (50 * index).ms).slideX(begin: -0.1, end: 0);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}
