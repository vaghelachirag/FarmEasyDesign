import 'package:farmeasy/base/extensions/buildcontext_ext.dart';
import 'package:farmeasy/base/utils/app_colors.dart';
import 'package:farmeasy/base/utils/app_decorations.dart';
import 'package:farmeasy/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../base/utils/custom_add_detail_button.dart';
import '../../base/utils/dialougs.dart';
import 'common_enter_ppm_button.dart';

class CommonWidgetTotalPpm extends StatelessWidget {
  const CommonWidgetTotalPpm({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.totalPPMBg,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top row with title and gauge
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(Assets.icons.iconTotalPpmTree),
                        Text(
                          "Total PPM",
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      "NA",
                      style: TextStyle(
                        fontSize: 32.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
              SvgPicture.asset(
               Assets.images.imageTotalPpm, // replace with your actual asset path
              )
            ],
          ),
          12.verticalSpace,
          // Info box
          Container(
            padding: EdgeInsets.all(12.w),
            decoration:  AppDecorations.infoWindowBg(),
            child:
            Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      Assets.icons.iconInfoBlub,
                      width: 20.w,
                      height: 20.w,
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        "No Nutrient PPM Data Available\nStart by entering the PPM values for each nutrient manually to begin tracking",
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
                12.verticalSpace,
                SizedBox(width: double.infinity,child: CommonEnterPpmButton(btnName: "Enter PPM Manually", iconPath: Assets.icons.iconAddDetail, onPressed: (){
                  showDialog(
                    context: context,
                    builder: (context) => ShowEnterPpmDialog(),
                  );
                }),),
               // CommonEnterPpmButton()
              ],
            ),
          )
        ],
      ),
    );
  }
}
