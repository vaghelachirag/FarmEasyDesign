import 'package:farmeasy/base/extensions/buildcontext_ext.dart';
import 'package:farmeasy/base/utils/app_colors.dart';
import 'package:farmeasy/base/utils/app_decorations.dart';
import 'package:farmeasy/base/utils/common_widgets.dart';
import 'package:farmeasy/components/common/app_text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../gen/assets.gen.dart';
import '../../generated/l10n.dart';
import 'custom_add_detail_button.dart';

void showTraySuccessDialog(BuildContext context,bool isWithImage,bool isSelected) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: S.of(context).traySuccessDialog,
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
                      isSelected ? loadAddingTrayContainer(context,false) :
                      loadAddingTrayWithoutSelection(context,false),
                      20.verticalSpace,
                      // Confirm Button
                      SizedBox(
                          width: double.infinity,
                          child:
                          CustomAddDetailButton(
                            iconPath: Assets.icons.iconConfirmAndProcessed,
                            btnName: S.of(context).confirmProceed,
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
    barrierLabel: S.of(context).traySuccessDialog,
    barrierColor: Colors.black54, // semi-transparent background
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, anim1, anim2) {
      return Scaffold(
        backgroundColor: Colors.transparent, // transparent full-screen background
        body: Center(
          child: Container(
            margin:  EdgeInsets.symmetric(horizontal: 24.w),
            padding:  EdgeInsets.all(16.sp),
            decoration: BoxDecoration(
              color: AppColors.white,
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
                8.verticalSpace,
                // Main Info Card
                Container(
                  width: double.infinity,
                  decoration: AppDecorations.moveToGerminationDialogueDecoration(),
                  padding: const EdgeInsets.all(0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset(Assets.images.harvestingSucess),
                      Text('Adding 8 Trays :',style: context.textTheme.labelLarge?.copyWith(fontSize: 14.sp)),
                      8.verticalSpace,
                      trayTextWidget(S.of(context).trayDetails,"8 Arugula Tray | 9 Gms ",context),
                      8.verticalSpace,
                      trayTextWidget(S.of(context).trayPosition,"Zone 3 | Section 4 | Level 3 ",context),
                      8.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          trayTextWidget(S.of(context).status,S.of(context).seeding,context),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.updateTodayBg,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: labelTextRegular(S.of(context).updateToday, 12.sp, AppColors.blackColor),
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
                      iconPath: Assets.icons.iconConfirmAndProcessed,
                      btnName: S.of(context).confirmProceed,
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
      Text(title,style: AppTextStyles.robotoBodyLarge.copyWith(fontSize: 14.sp)),
      Text(hint,style: AppTextStyles.robotoBodyRegular.copyWith(fontSize: 12.sp,color: AppColors.labelTextColor)),
      5.verticalSpace,
    ],
  );
}


class ShowEnterPpmDialog extends StatelessWidget {
  final List<TextEditingController> controllers =
  List.generate(6, (_) => TextEditingController());

  ShowEnterPpmDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return  Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          // Limit max height so large data scrolls
          maxHeight: MediaQuery.of(context).size.height * 0.85,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              closeButton(context),
              Padding(padding: EdgeInsets.only(left:  16.w,right: 16.w),child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    children: [
                      SvgPicture.asset(Assets.icons.iconTotalPpmTree),
                      10.horizontalSpace,
                       Expanded(
                        child: Text(
                          S.of(context).enterNutrientPpmValues,
                          style: AppTextStyles.robotoBodyLarge.copyWith(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  20.verticalSpace,
                  // Fields
                  loadBuildNutrientSection(controllers,context),
                  // Save Button
                  SizedBox(
                      width: double.infinity,
                      child: CustomAddDetailButton(btnName: S.of(context).saveDetails, iconPath: "", onPressed: (){
                      })),
                  20.verticalSpace
                ],
              ),)
            ],
          ),
        ),
      ),
    );
  }
}

Widget loadBuildNutrientSection(List<TextEditingController> controllers, BuildContext context){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      for (int i = 0; i < controllers.length; i++) ...[
        _buildNutrientSection(i,controllers,context),
        5.verticalSpace,
        Text(
          "25ml/5gal",
          style: context.textTheme.labelMedium?.copyWith(fontSize: 10.sp,color: AppColors.blackColor),
        ),
        20.verticalSpace,
      ]
    ],
  );
}

Widget closeButton(BuildContext context){
  return Align(
    alignment: Alignment.topRight,
    child:   IconButton(
      icon: const Icon(Icons.close),
      color: AppColors.blackColor,
      onPressed: () => Navigator.of(context).pop(),
    ),
  );
}

Widget _buildNutrientSection(int index, List<TextEditingController> controllers, BuildContext context) {
  return TextField(
    controller: controllers[index],
    decoration: InputDecoration(
      label: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: enterTotalPpfDecoration(),
        child:  Text(
          S.of(context).potassiumSilicate,
          style:  context.textTheme.labelSmall?.copyWith(fontSize: 14.sp,color: AppColors.infoTextHingBg),
        ),
      ),
      hintText: "e.g. 120",
      hintStyle: context.textTheme.labelSmall?.copyWith(
          fontSize: 12.sp,
          color: AppColors.customCycleTabUnSelectedTextColor
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      floatingLabelBehavior: FloatingLabelBehavior.always,
    ),
    keyboardType: TextInputType.number,
  );
}

BoxDecoration enterTotalPpfDecoration(){
  return BoxDecoration(
    color: AppColors.enterPpfTextAreaLabelBg,
    borderRadius: BorderRadius.circular(4),
  );
}