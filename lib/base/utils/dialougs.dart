import 'package:farmeasy/base/extensions/buildcontext_ext.dart';
import 'package:farmeasy/base/utils/app_colors.dart';
import 'package:farmeasy/base/utils/app_decorations.dart';
import 'package:farmeasy/base/utils/common_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../generator/assets.gen.dart';
import 'custom_add_detail_button.dart';

void showTraySuccessDialog(BuildContext context,bool isWithImage) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "Tray Success Dialog",
    barrierColor: Colors.black54, // semi-transparent background
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, anim1, anim2) {
      return Scaffold(
        backgroundColor: Colors.transparent, // transparent full-screen background
        body: Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 24),
            padding: const EdgeInsets.all(0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Close button
                isWithImage == true ?
                Container() :
                Padding(padding: EdgeInsets.only(top: 10.w,right: 10.w),child:   Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.close, size: 24),
                  ),
                ) ,),
                // Main Info Card
                Container(
                  padding: EdgeInsets.all(16.w),
                  child:    Column(
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: AppDecorations.moveToGerminationDialogueDecoration(),
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            isWithImage == true ?
                            SvgPicture.asset(
                              Assets.images.harvestingSucess.path,
                              height: 120.h,
                            ): Container(),
                            Text('Adding 8 Trays :',style: context.textTheme.labelLarge?.copyWith(fontSize: 14.sp)),
                            8.verticalSpace,
                            trayTextWidget("Tray Details:","8 Arugula Tray | 9 Gms ",context),
                            8.verticalSpace,
                            trayTextWidget("Tray Position: ","Zone 3 | Section 4 | Level 3 ",context),
                            8.verticalSpace,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                trayTextWidget("Status: ","Seeding",context),
                                Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: AppColors.updateTodayBg,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text("Update Today",style: context.textTheme.labelSmall?.copyWith(fontSize: 11.sp,color: AppColors.blackColor),)
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      20.verticalSpace,
                      // Confirm Button
                      SizedBox(
                          width: double.infinity,
                          child:
                          CustomAddDetailButton(
                            iconPath: Assets.icons.iconConfirmAndProcessed.path,
                            btnName: "Confirm & Proceed",
                            onPressed: () {
                            },
                          ))],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}

void showHarvestingSuccessDialog(BuildContext context) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "Tray Success Dialog",
    barrierColor: Colors.black54, // semi-transparent background
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, anim1, anim2) {
      return Scaffold(
        backgroundColor: Colors.transparent, // transparent full-screen background
        body: Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 24),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Close button
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.close, size: 24),
                  ),
                ),
                const SizedBox(height: 8),
                // Main Info Card
                Container(
                  width: double.infinity,
                  decoration: AppDecorations.moveToGerminationDialogueDecoration(),
                  padding: const EdgeInsets.all(0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset(Assets.images.harvestingSucess.path),
                      Text('Adding 8 Trays :',style: context.textTheme.labelLarge?.copyWith(fontSize: 14.sp)),
                      8.verticalSpace,
                      trayTextWidget("Tray Details:","8 Arugula Tray | 9 Gms ",context),
                      8.verticalSpace,
                      trayTextWidget("Tray Position: ","Zone 3 | Section 4 | Level 3 ",context),
                      8.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          trayTextWidget("Status: ","Seeding",context),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.updateTodayBg,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: labelTextRegular("Update Today", 12.sp, AppColors.blackColor),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                20.verticalSpace,
                // Confirm Button
                SizedBox(
                    width: double.infinity,
                    child:
                    CustomAddDetailButton(
                      iconPath: Assets.icons.iconConfirmAndProcessed.path,
                      btnName: "Confirm & Proceed",
                      onPressed: () {
                      },
                    ))
              ],
            ),
          ),
        ),
      );
    },
  );
}

Widget trayTextWidget(String title,String hint, BuildContext context){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title,style: context.textTheme.labelLarge?.copyWith(fontSize: 14.sp)),
      Text(hint,style: context.textTheme.labelSmall?.copyWith(fontSize: 12.sp,color: AppColors.labelTextColor)),
      5.verticalSpace,
    ],
  );
}