import 'package:farmeasy/base/extensions/buildcontext_ext.dart';
import 'package:farmeasy/base/utils/app_constant.dart';
import 'package:farmeasy/components/widget/top_header_home_page.dart';
import 'package:farmeasy/generator/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class TrayStatusCard extends StatelessWidget {
  final int available;
  final int total;
  final String date;
  final String title;
  final BuildContext context;

  const TrayStatusCard({
    super.key,
    required this.available,
    required this.total,
    required this.date,
    this.title = "Available Trays",
    required this.context
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Container(
      margin:const EdgeInsets.only(left: 12,right: 12),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppConstant.cardCornerRadius),
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            color: Colors.black.withOpacity(0.05),
          ),
        ],
      ),
      child: Row(
        children: [
          // Left column with icon and text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Leading icon on top
                TopHeaderHomePage(title: 'Available Trays', date: '12/07/2025',assetPath:  Assets.icons.mesageIcon.path),
                const SizedBox(height: 8),
                // Tray count + last updated on same row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          "$available",
                          style: context.theme.textTheme.labelMedium?.copyWith(
                            fontSize: width * 0.07
                          )
                        ),
                        Text(
                          " /$total",
                          style: context.theme.textTheme.labelSmall?.copyWith(
                              fontSize: width * 0.035
                          )
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Tray image on right
          SvgPicture.asset(
            Assets.images.dataMaintanceIcon.path, // replace with correct image from assets.gen.dart
            width: width * 0.25,
            fit: BoxFit.contain,
          )
        ],
      ),
    );
  }
}
