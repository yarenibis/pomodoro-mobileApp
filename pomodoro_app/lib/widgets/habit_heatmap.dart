import 'package:flutter/material.dart';

class HabitHeatmap extends StatelessWidget {
  final List<String> logs; // yyyy-MM-dd
  final int weeks;

  const HabitHeatmap({
    super.key,
    required this.logs,
    this.weeks = 8,
  });

  static const double cellSize = 14;
  static const double spacing = 4;

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final startDate = today.subtract(Duration(days: weeks * 7 - 1));

    final days = List.generate(
      weeks * 7,
      (i) => startDate.add(Duration(days: i)),
    );

    return SizedBox(
      height: (cellSize * 7) + (spacing * 6),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: weeks, // 🔥 HAFTALAR YATAY
          mainAxisSpacing: spacing,
          crossAxisSpacing: spacing,
          childAspectRatio: 1,
        ),
        itemCount: days.length,
        itemBuilder: (context, index) {
          final day = days[index];
          final key = day.toIso8601String().split('T')[0];
          final done = logs.contains(key);

          return Container(
            width: cellSize,
            height: cellSize,
            decoration: BoxDecoration(
              color: done
                  ? Colors.green.shade600
                  : Colors.grey.shade300,
              borderRadius: BorderRadius.circular(4),
            ),
          );
        },
      ),
    );
  }
}
