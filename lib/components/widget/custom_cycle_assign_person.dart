import 'package:farmeasy/base/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../screens/tab/cycles/provider/cycles_provider.dart';

class CustomCycleAssignPerson extends ConsumerWidget {
  final int maxVisible;
  final VoidCallback onAssignTap;

  const CustomCycleAssignPerson({
    super.key,
    this.maxVisible = 3,
    required this.onAssignTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final assignedUsers = ref.watch(assignedUsersProvider);
    final visibleUsers = assignedUsers.take(maxVisible).toList();
    final extraCount = assignedUsers.length - maxVisible;

    return Row(
      children: [
        const Text(
          'Assigned to:',
          style: TextStyle(
            fontSize: 14,
            color: Colors.black87,
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: (maxVisible + (extraCount > 0 ? 1 : 0)) * 28,
          height: 28,
          child: Stack(
            children: [
              for (int i = 0; i < visibleUsers.length; i++)
                Positioned(
                  left: i * 20.0,
                  child: CircleAvatar(
                    radius: 14,
                    backgroundImage: AssetImage(visibleUsers[i].avatarPath),
                  ),
                ),
              if (extraCount > 0)
                Positioned(
                  left: visibleUsers.length * 20.0,
                  child: CircleAvatar(
                    radius: 14,
                    backgroundColor: Colors.grey.shade400,
                    child: Text(
                      '+$extraCount',
                      style: const TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ),
                ),
            ],
          ),
        ),
        const Spacer(),
        GestureDetector(
          onTap: onAssignTap,
          child: Text(
            'Assign People',
            style: TextStyle(
              fontSize: 14.sp,

              color: AppColors.buttonBackgroundColor,
              fontWeight: FontWeight.w600,
              decoration: TextDecoration.underline, decorationColor: Colors.blue
            ),
          ),
        ),
      ],
    );
  }
}
