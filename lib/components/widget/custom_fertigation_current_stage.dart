import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomFertigationCurrentStage extends StatelessWidget {
  const CustomFertigationCurrentStage();

  @override
  Widget build(BuildContext context) {
    final stages = [
      {
        "icon": Icons.water_drop,
        "label": "Seeding",
        "date": "22/05/2025",
        "status": "Completed"
      },
      {
        "icon": Icons.spa,
        "label": "Germination",
        "date": "22/05/2025",
        "status": "Completed"
      },
      {
        "icon": Icons.eco,
        "label": "Fertigation",
        "date": "22/05/2025",
        "status": "Completed"
      },
      {
        "icon": Icons.agriculture,
        "label": "Harvest",
        "date": "22/05/2025",
        "status": "Upcoming"
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(stages.length, (index) {
        final stage = stages[index];
        final isUpcoming = stage["status"] == "Upcoming";
        final isLast = index == stages.length - 1;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(color: Color(0xFF23C072), width: 2),
                  ),
                  child: Icon(
                    stage["icon"] as IconData,
                    size: 16,
                    color: Color(0xFF3A7F0D),
                  ),
                ),
                if (!isLast)
                  Container(
                    width: 2,
                    height: 30,
                    color: Color(0xFF23C072),
                  ),
              ],
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: isUpcoming
                        ? Color(0xFFF0F4EC)
                        : Color(0xFFCAC4D0),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(stage["label"] as String),
                ),
                const SizedBox(height: 4),
                Text(
                  "${stage["status"]} on ${stage["date"]}",
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF49454F),
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ],
        );
      }),
    );
  }
}
