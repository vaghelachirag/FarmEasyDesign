import 'package:farmeasy/base/extensions/buildcontext_ext.dart';
import 'package:farmeasy/components/widget/top_header_home_page.dart';
import 'package:farmeasy/generator/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../base/utils/app_constant.dart';
import '../../base/utils/dashline.dart';

class CycleStatusCard extends StatelessWidget {
  final int totalCycles;
  final String date;
  final String title;
  final Map<String, int> stageData;

  const CycleStatusCard({
    super.key,
    required this.totalCycles,
    required this.date,
    required this.stageData,
    this.title = "Total Running Cycles",
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 600;

    return Container(
      margin: const EdgeInsets.only(left: 12,right: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppConstant.cardCornerRadius),
        boxShadow: [
          BoxShadow(
            blurRadius: 6,
            color: Colors.black.withOpacity(0.06),
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child:
      Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TopHeaderHomePage(
                          title: 'Total Running Cycles',
                          date: '12/07/2025',
                          assetPath: Assets.icons.syncIcon.path,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    /// Total number
                    Text(
                      '$totalCycles',
                      style: TextStyle(
                        fontSize: isMobile ? 32 : 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              /// Right image
              SizedBox(
                width: isMobile ? 80.w : 100.w, // Responsive control
                child: SvgPicture.asset(
                  Assets.images.blockChaiIcon.path,
                  fit: BoxFit.contain,
                ),
              )
            ],
          ),
          /// Dashed Line
          DashedLine(
            height: 1,
            dashWidth: 6,
            dashSpacing: 4,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 12),
          /// Cycle status
          Row(
            children: const [
              Expanded(child: CycleStatusItem(title: 'Seeding', cycleCount: 3)),
              Expanded(child: CycleStatusItem(title: 'Germination', cycleCount: 2)),
              Expanded(child: CycleStatusItem(title: 'Fertigation', cycleCount: 4)),
              Expanded(child: CycleStatusItem(title: 'Harvesting', cycleCount: 3)),
            ],
          ),
        ],
      )

    );
  }
}

class CycleStatusItem extends StatelessWidget {
  final String title;
  final int cycleCount;

  const CycleStatusItem({
    super.key,
    required this.title,
    required this.cycleCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80, // adjust as needed
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title row
          Text(
            title,
            style: context.theme.textTheme.bodySmall,
            maxLines: 1,
          ),

          // Cycles row
          Row(
            children: [
              Text(
                '$cycleCount',
                style: context.theme.textTheme.labelLarge?.copyWith(
                  fontSize: 14.sp
                ),
              ),
              const SizedBox(width: 4),
              Text(
                'Cycles',
                style: context.theme.textTheme.labelSmall,
              ),
              const SizedBox(width: 4),
              SvgPicture.asset(
                Assets.icons.iconInfo.path,
                width: 12,
                height: 12,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

