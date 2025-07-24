import 'package:farmeasy/base/extensions/buildcontext_ext.dart';
import 'package:farmeasy/base/utils/app_colors.dart';
import 'package:farmeasy/base/utils/app_decorations.dart';
import 'package:farmeasy/base/utils/common_widgets.dart';
import 'package:farmeasy/generator/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomNutrientInfoCardWidget extends StatefulWidget {
  const CustomNutrientInfoCardWidget({super.key});

  @override
  State<CustomNutrientInfoCardWidget> createState() => _CustomNutrientInfoCardWidgetState();
}

class _CustomNutrientInfoCardWidgetState extends State<CustomNutrientInfoCardWidget> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: EdgeInsets.all(10.w),
      decoration: AppDecorations.nutritionBoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildIconInfo(Assets.icons.iconMoisture.path, "Moisture", "30"),
              _buildIconInfo(Assets.icons.iconTemperature.path, "Temperature", "30 °C"),
              _buildIconInfo(Assets.icons.iconAcidity.path, "Acidity", "PH 6.0"),
              _buildIconInfo(Assets.icons.iconNutrients.path, "Nutrients", "High"),
            ],
          ),
          12.verticalSpace,
          InkWell(
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                labelTextRegular( isExpanded ? "Hide History" : "View History", 10.sp, AppColors.blackColor),
                4.verticalSpace,
                Icon(
                  isExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: Colors.black54,
                ),
              ],
            ),
          ),

          if (isExpanded) ...[
            const SizedBox(height: 12),
            const Text(
              "• 24/07/2025 - Moisture 28, PH 6.1\n"
                  "• 23/07/2025 - Moisture 27, PH 6.3",
              style: TextStyle(fontSize: 13, color: Colors.black87),
            ),
          ]
        ],
      ),
    );
  }

  Widget _buildIconInfo(String path, String label, String value) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.white,
          radius: 20,
          child: SvgPicture.asset(path)
        ),
        5.verticalSpace,
        Text(label,style: context.textTheme.labelSmall?.copyWith(fontSize: 10.sp,color: AppColors.blackColor),),
        2.verticalSpace,
        Text(value,style: context.textTheme.labelLarge?.copyWith(fontSize: 12.sp,color: AppColors.blackColor),),
      ],
    );
  }
}
