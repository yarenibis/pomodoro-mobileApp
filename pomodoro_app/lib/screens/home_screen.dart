import 'package:flutter/material.dart';
import '../db/database_helper.dart';
import '../models/habit.dart';
import '../screens/add_habit_screen.dart';
import '../widgets/week_calendar.dart';
import '../widgets/habit_horizontal_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final db = DatabaseHelper.instance;
  List<Habit> habits = [];

  String todayKey() => DateTime.now().toIso8601String().split('T')[0];

  @override
  void initState() {
    super.initState();
    loadHabits();
  }

  Future<void> loadHabits() async {
    final habitRows = await db.getHabits();
    List<Habit> loaded = [];

    for (var h in habitRows) {
      final logs = await db.getLogs(h['id']);
      loaded.add(Habit(
        id: h['id'],
        title: h['title'],
        emoji: h['emoji'],
        color: h['color'],
        logs: logs,
      ));
    }

    setState(() => habits = loaded);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Today'),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddHabitScreen(),
            ),
          );
          if (result == true) loadHabits();
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          const SizedBox(height: 12),

          /// 🔝 TAKVİM
          const WeekCalendar(),

          const SizedBox(height: 12),

          /// 📋 HABIT LIST
          Expanded(
            child: habits.isEmpty
                ? const Center(
                    child: Text(
                      'Henüz alışkanlık eklenmedi',
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    itemCount: habits.length,
                    itemBuilder: (context, index) {
                      final habit = habits[index];
                      return HabitHorizontalCard(
                        habit: habit,
                        onToggle: () async {
                          await db.toggleLog(habit.id, todayKey());
                          loadHabits();
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
