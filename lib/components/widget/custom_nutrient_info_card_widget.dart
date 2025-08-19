import 'package:farmeasy/base/extensions/buildcontext_ext.dart';
import 'package:farmeasy/base/utils/app_colors.dart';
import 'package:farmeasy/base/utils/app_decorations.dart';
import 'package:farmeasy/base/utils/common_widgets.dart';
import 'package:farmeasy/components/common/app_text_styles.dart';
import 'package:farmeasy/generator/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomNutrientInfoCardWidget extends StatefulWidget {
  const CustomNutrientInfoCardWidget({super.key});

  @override
  State<CustomNutrientInfoCardWidget> createState() =>
      _CustomNutrientInfoCardWidgetState();
}

class _CustomNutrientInfoCardWidgetState
    extends State<CustomNutrientInfoCardWidget> {
  bool isExpanded = false;
  int selectedHeaderIndex = 0;

  final List<String> headers = ['Date', 'Moisture', 'Temperature', 'Acidity'];

  final List<Map<String, String>> historyData = [
    {"date": "2/6/25", "moisture": "30", "temp": "30 °C", "acidity": "PH 6.0"},
    {"date": "1/6/25", "moisture": "30", "temp": "28 °C", "acidity": "PH 6.0"},
    {"date": "31/5/25", "moisture": "22", "temp": "30 °C", "acidity": "PH 3.0"},
    {"date": "30/5/25", "moisture": "30", "temp": "30 °C", "acidity": "PH 6.0"},
    {"date": "29/5/25", "moisture": "30", "temp": "30 °C", "acidity": "PH 6.0"},
    {"date": "28/5/25", "moisture": "30", "temp": "30 °C", "acidity": "PH 6.0"},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: AppDecorations.nutritionBoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icons Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildIconInfo(Assets.icons.iconMoisture.path, "Moisture", "30"),
              _buildIconInfo(
                  Assets.icons.iconTemperature.path, "Temperature", "30 °C"),
              _buildIconInfo(
                  Assets.icons.iconAcidity.path, "Acidity", "PH 6.0"),
              _buildIconInfo(
                  Assets.icons.iconNutrients.path, "Nutrients", "High"),
            ],
          ),
          12.verticalSpace,
          // Expanded history section above toggle
          if (isExpanded) ...[
            _buildHistoryHeader(),
            8.verticalSpace,
            _buildHistoryRows(),
            8.verticalSpace,
          ],

          // Toggle button at bottom
          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  labelTextRegular(
                    isExpanded ? "Hide History" : "View History",
                    10.sp,
                    AppColors.blackColor,
                  ),
                  4.horizontalSpace,
                  Icon(
                    isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: Colors.black54,
                    size: 18.sp,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Icon + label + value widget
  Widget _buildIconInfo(String path, String label, String value) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.white,
          radius: 20,
          child: SvgPicture.asset(path),
        ),
        5.verticalSpace,
        Text(
          label,
          style: AppTextStyles.robotoBodyRegular.copyWith(
            fontSize: 10.sp,
            color: AppColors.blackColor,
          ),
        ),
        2.verticalSpace,
        Text(
          value,
          style: AppTextStyles.robotoBodyLarge.copyWith(
            fontSize: 12.sp,
            color: AppColors.blackColor,
          ),
        ),
      ],
    );
  }

  /// Segmented yellow header with white selected tab
  Widget _buildHistoryHeader() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.selectedMoistureHeaderBg,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: List.generate(headers.length, (index) {
          final bool isSelected = index == selectedHeaderIndex;
          return Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                setState(() {
                  selectedHeaderIndex = index;
                });
              },
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 2.h),
                decoration: null,
                child: Text(
                  headers[index],
                  style: context.textTheme.titleMedium?.copyWith(fontSize: 10.sp,color: AppColors.blackColor),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  /// History rows without extra background
  Widget _buildHistoryRows() {
    return Column(
      children: historyData.map((item) {
        final bool highlightRow = item["moisture"] == "22"; // example highlight
        return Container(
          color: highlightRow
              ? AppColors.selectedMoistureBg
              : Colors.transparent,
          padding: EdgeInsets.symmetric(vertical: 2.h),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Center(
                  child: Text(
                    item["date"] ?? "",
                    style: context.textTheme.titleMedium?.copyWith(
                      fontSize: 11.sp,
                      color: AppColors.infoTextHingBg,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Center(
                  child: Text(
                    item["moisture"] ?? "",
                    style: context.textTheme.titleMedium?.copyWith(
                      fontSize: 11.sp,
                      color: AppColors.infoTextHingBg,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Center(
                  child: Text(
                    item["temp"] ?? "",
                    style: context.textTheme.titleMedium?.copyWith(
                      fontSize: 11.sp,
                      color: AppColors.infoTextHingBg,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Center(
                  child: Text(
                    item["acidity"] ?? "",
                    style: context.textTheme.titleMedium?.copyWith(
                      fontSize: 11.sp,
                      color: AppColors.infoTextHingBg,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
