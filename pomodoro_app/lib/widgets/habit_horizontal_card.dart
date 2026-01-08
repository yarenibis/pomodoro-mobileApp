import 'package:flutter/material.dart';
import '../models/habit.dart';

class HabitHorizontalCard extends StatelessWidget {
  final Habit habit;
  final VoidCallback onToggle;

  const HabitHorizontalCard({
    super.key,
    required this.habit,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7FB),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          /// EMOJI
          Text(
            habit.emoji,
            style: const TextStyle(fontSize: 30),
          ),
          const SizedBox(width: 14),

          /// TITLE + STREAK
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  habit.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '🔥 ${habit.streak} gün streak',
                  style: TextStyle(
                    fontSize: 13,
                    color: habit.streakBroken
                        ? Colors.red
                        : Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          ),

          /// CHECKBOX
          Checkbox(
            value: habit.doneToday,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            onChanged: (_) => onToggle(),
          ),
        ],
      ),
    );
  }
}
