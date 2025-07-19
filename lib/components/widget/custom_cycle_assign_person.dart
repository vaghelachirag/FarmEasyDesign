import 'package:farmeasy/base/extensions/buildcontext_ext.dart';
import 'package:farmeasy/base/utils/app_colors.dart';
import 'package:farmeasy/generator/fonts.gen.dart';
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
          Text(
          'Assigned to:',
          style:  context.textTheme.labelSmall?.copyWith(),
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
                    backgroundColor: AppColors.totalAssignPersonBg,
                    child:
                    Text(
                      '+$extraCount',
                      style: context.textTheme.labelSmall?.copyWith(),
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
              fontSize: 11.sp,
              fontFamily: FontFamily.roboto,
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
