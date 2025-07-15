import 'package:farmeasy/base/extensions/buildcontext_ext.dart';
import 'package:farmeasy/base/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CustomTabCycle extends StatefulWidget {
  @override
  _CustomTabCycleState createState() => _CustomTabCycleState();
}

class _CustomTabCycleState extends State<CustomTabCycle> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        final isSmallScreen = constraints.maxWidth < 600;
        final tabHeight = isSmallScreen ? 40.0 : 50.0;
        final fontSize = isSmallScreen ? 14.0 : 16.0;

        return Container(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            children: [
              _buildTab(context.l10n.ongoing, 0, tabHeight, fontSize),
              _buildTab(context.l10n.history, 1, tabHeight, fontSize),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTab(String label, int index, double height, double fontSize) {
    final isSelected = selectedIndex == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedIndex = index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          height: height,
          decoration: BoxDecoration(
            color: isSelected ? AppColors.customCycleTabSelectedColor : AppColors.customCycleTabUnSelectedColor,
            borderRadius: BorderRadius.circular(20),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w600,
              color: isSelected ? AppColors.white : AppColors.customCycleTabUnSelectedTextColor,
            ),
          ),
        ),
      ),
    );
  }
}
