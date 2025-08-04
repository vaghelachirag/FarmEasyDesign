import 'package:farmeasy/generator/assets.gen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../base/utils/common_widgets.dart';
import 'custom_fertigation_current_stage.dart';
import 'custom_seeding_action_section.dart';

class CustomLifecycleFertigationCurrentStageHeader extends StatelessWidget {
  final bool isExpanded;
  const CustomLifecycleFertigationCurrentStageHeader({super.key, required this.isExpanded});

  @override
  Widget build(BuildContext context) {
    return isExpanded ?  Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Timeline Icon & Line
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildCircleIcon(Assets.icons.iconNutriationDrop.path, context),
          ],
        ),
        4.horizontalSpace,
        // Row content: Status Chip and Text (in horizontal layout)
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  buildStatusChip("Fertigation", context),
                  4.horizontalSpace,
                  buildCompletedDate("Completed on 22/05/2025", context),
                ],
              ),
            ],
          ),
        )
      ],
    )
        :  currentNutritionTimeLineWidget(context);
  }
}
