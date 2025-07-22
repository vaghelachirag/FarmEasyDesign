import 'package:farmeasy/base/extensions/buildcontext_ext.dart';
import 'package:farmeasy/base/utils/app_colors.dart';
import 'package:farmeasy/base/utils/app_decorations.dart';
import 'package:farmeasy/base/utils/common_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../generator/assets.gen.dart';
import 'custom_add_detail_button.dart';

void showTraySuccessDialog(BuildContext context) {
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
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Adding 8 Trays :',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
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