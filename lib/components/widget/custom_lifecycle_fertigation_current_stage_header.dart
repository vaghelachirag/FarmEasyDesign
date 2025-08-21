import 'package:farmeasy/components/common/app_text_styles.dart';
import 'package:farmeasy/generator/assets.gen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../base/utils/common_widgets.dart';
import 'custom_fertigation_current_stage.dart';
import 'custom_seeding_action_section.dart';

import 'package:farmeasy/base/extensions/buildcontext_ext.dart';
import 'package:farmeasy/base/utils/app_colors.dart';
import 'package:farmeasy/generator/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:timeline_tile_plus/timeline_tile_plus.dart';

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
        buildCircleIcon(Assets.icons.iconNutriationDrop.path, context),
        5.horizontalSpace,
        // Row content: Status Chip and Text (in horizontal layout)
        Expanded(
          child: buildStatusChip("Fertigation", context, date: "Completed on 22/05/2025"),
        ),
      ],
    ) : HarvestLifecycleTimelineWidget();
    // :  currentNutritionTimeLineWidget(context);
  }
}


class PlantGrowthStage {
  final String title;
  final String dateText;
  final String iconPath;
  final bool isCompleted;
  final bool isCurrent;

  PlantGrowthStage({
    required this.title,
    required this.dateText,
    required this.iconPath,
    required this.isCompleted,
    required this.isCurrent,
  });
}

class HarvestLifecycleTimelineWidget extends StatelessWidget {
  HarvestLifecycleTimelineWidget({super.key});

  final List<PlantGrowthStage> stages = [
    PlantGrowthStage(
      title: "Seeding",
      dateText: "Started on 22/05/2025",
      iconPath: Assets.icons.iconSeeds.path,
      isCompleted: true,
      isCurrent: false,
    ),
    PlantGrowthStage(
      title: "Germination",
      dateText: "Started on 22/05/2025",
      iconPath: Assets.icons.iconNutriationLeaf.path,
      isCompleted: true,
      isCurrent: false,
    ),
    PlantGrowthStage(
      title: "Fertigation",
      dateText: "Upcoming on 22/05/2025",
      iconPath: Assets.icons.iconNutriationPlant.path,
      isCompleted: false,
      isCurrent: false,
    ),
    PlantGrowthStage(
      title: "Harvest",
      dateText: "Upcoming on 22/05/2025",
      iconPath: Assets.icons.iconNutriationLeaf.path,
      isCompleted: false,
      isCurrent: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Column(
        children: List.generate(stages.length, (index) {
          final stage = stages[index];
          final isLast = index == stages.length - 1;

          return TimelineTile(
            // Timeline styling
            startChild: _buildTimelineIcon(stage, context),
            endChild: _buildTimelineContent(stage, context),

            // Line styling
            lineXY: 0.1,
            isFirst: index == 0,
            isLast: isLast,

            // Indicator styling
            indicatorStyle: IndicatorStyle(
              width: 40.w,
              height: 40.w,
              indicator: _buildIndicator(stage, context),
              drawGap: true,
            ),

            // Line styling based on completion status
            beforeLineStyle: LineStyle(
              color: AppColors.cycleDividerBg,
              thickness: 3,
            ),

            // After line styling (dashed for upcoming stages)
            afterLineStyle: LineStyle(
              color: AppColors.cycleDividerBg,
              thickness: 3,
              // isDotted: !stage.isCompleted && !isLast,
            ),
          );
        }),
      ),
    );
  }

  Widget _buildIndicator(PlantGrowthStage stage, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.cycleRoundBorderBg)
      ),
      padding: EdgeInsets.all(3.w),
      width: 40.w,
      height: 40.w,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: stage.isCompleted
              ? AppColors.seedingImageBorderActiveColor
              : AppColors.seedingImageBorderDisableColor,
        ),
        child: Center(
          child: Container(
            padding: EdgeInsets.all(8.w),
            child: SvgPicture.asset(
              stage.iconPath,
              width: 16.w,
              height: 16.w,
              colorFilter: const ColorFilter.mode(
                AppColors.white,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTimelineIcon(PlantGrowthStage stage, BuildContext context) {
    return Container(
      width: 40.w,
      height: 40.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.seedingImageBorderActiveColor,
          width: 1,
        ),
      ),
      child: Container(
        width: 32.w,
        height: 32.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: stage.isCompleted
              ? AppColors.selectedProgressBg
              : AppColors.seedingImageBorderDisableColor,
        ),
        child: Center(
          child: SvgPicture.asset(
            stage.iconPath,
            width: 16.w,
            height: 16.w,
            colorFilter: const ColorFilter.mode(
              AppColors.white,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTimelineContent(PlantGrowthStage stage, BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10.w, top: 25.w, bottom: 25.w),
      child: Row(
        children: [
          Text(
            stage.title,
            style: AppTextStyles.robotoBodyLarge.copyWith(
                color: stage.isCompleted ? null : AppColors.labelTextColor
            ),
          ),
          8.horizontalSpace,
          Expanded(
            child: Text(
              stage.dateText,
              style: AppTextStyles.robotoBodyRegular.copyWith(
              ),
            ),
          ),
        ],
      ),
    );
  }
}