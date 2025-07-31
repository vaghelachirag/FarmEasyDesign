import 'package:farmeasy/base/extensions/buildcontext_ext.dart';
import 'package:farmeasy/base/utils/app_colors.dart';
import 'package:farmeasy/screens/tab/cycles/provider/cycles_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../components/widget/top_header_home_page.dart';
import '../../generated/l10n.dart';
import '../../generator/assets.gen.dart';
import '../../screens/seedingProcess/seedingTrays/addPersonDetail/add_person_detail_screen.dart';
import '../../screens/tab/seeding/provider/seeding_provider.dart';
import 'app_constant.dart';
import 'app_decorations.dart';

EdgeInsets authScreenPadding() =>
    EdgeInsets.symmetric(vertical: 10.sp, horizontal: 20.sp);

EdgeInsets screenPadding() =>
    EdgeInsets.symmetric(vertical: 10.sp, horizontal: 15.sp);

BoxDecoration boxDecoration(Color color, Color border) =>
    BoxDecoration(
      color:color,
      borderRadius: BorderRadius.circular(12.r),
      border: Border.all(
        color:  border, // very light green border
        width: 1,
      ),
    );

 void  setStatusBarColor(){
   return  SystemChrome.setSystemUIOverlayStyle(
     const SystemUiOverlayStyle(
       statusBarColor: AppColors.transparent,
       statusBarBrightness: Brightness.light,
       statusBarIconBrightness: Brightness.dark,
     ),
   );
 }


// Label Text Bold
Text labelTextBold(hint, double fontSize, Color labelTextColor) {
  return  Text(
    hint,
    style: TextStyle(
        color: labelTextColor,
        fontSize: ScreenUtil().setSp(fontSize),
        fontFamily: AppConstant.labelFrontBold),
  );
}

Row imageWithTextInRow(BuildContext context,String path,String text,double fontSize){
   return  Row(
     mainAxisSize: MainAxisSize.min,
     children: [
       SvgPicture.asset(path),
       4.verticalSpace,
       Text(path,style: context.textTheme.labelSmall?.copyWith(fontSize: fontSize),)
     ],
   );
}

Widget buttonWithIcon({
  required BuildContext context,
  required String path,
  required String label,
  required VoidCallback onPressed,
}) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      padding:  EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.w),
      backgroundColor: AppColors.manualCheckButtonBg,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: 30.w,
          height: 20.w,
          child: SvgPicture.asset(path),
        ),
        2.horizontalSpace,
        Flexible(
          child: Text(
            label,
              style:
              context.textTheme.labelSmall?.copyWith(fontSize: 11.sp,color: AppColors.infoTextHingBg)
          ),
        ),
      ],
    ),
  );
}

// Label Text Medium
Text labelTextMedium(hint, double fontSize, Color labelTextColor) {
  return  Text(
    hint,
    style: TextStyle(
        color: labelTextColor,
        fontSize: ScreenUtil().setSp(fontSize),
        fontFamily: AppConstant.labelFrontMedium),
  );
}

// Label Text Regular
Text labelTextRegular(hint, double fontSize, Color labelTextColor) {
  return  Text(
    hint,
    style: TextStyle(
        color: labelTextColor,
        fontSize: ScreenUtil().setSp(fontSize),
        fontFamily: AppConstant.labelFrontRegular),
  );
}

// Get Actionbar
AppBar getActionbar(BuildContext context, String title) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    automaticallyImplyLeading: false,
    titleSpacing: 0,
    leading: IconButton(
      icon: const Icon(Icons.arrow_back, color: Colors.black),
      onPressed: () {
        context.navigator.pop();
      },
    ),
    title: Row(
      children: [
        SizedBox(width: 0),
        Text(title,style: context.textTheme.labelMedium?.copyWith(fontSize: 18.sp,color: AppColors.blackColor),)
      ],
    ),
  );
}

// Circle Seeding circle Time Line Image
Widget circularSeedingProcessTimeLine(bool isCompleted,IconData icon){
   return    Container(
     padding: const EdgeInsets.all(4),
     decoration: BoxDecoration(
       shape: BoxShape.circle,
       border: Border.all(
         color: isCompleted ? AppColors.seedingImageBorderActiveColor : AppColors.seedingImageBorderDisableColor,
         width: 2,
       ),
     ),
     child: Icon(
       icon,
       size: 16,
       color: isCompleted ? AppColors.seedingImageBorderActiveColor :  AppColors.seedingImageBorderDisableColor,
     ),
   );
}


Widget buildCircleIcon(String path, BuildContext context) {
  return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.seedingImageBorderActiveColor,
          width: 1,
        ),
      ),
      child:
      Container(
        padding: EdgeInsets.all(2.sp),
        child:CircleAvatar(
          radius: 14,
          backgroundColor: AppColors.white,
          child:  SvgPicture.asset(path),
        ),
      )
  );
}

Widget buildStatusChip(String label, BuildContext context) {
  return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 6.w),
      decoration: AppDecorations.nutriationChipDecoration(),
      child:
      Row(
        children: [
          SvgPicture.asset(Assets.icons.iconSeeds.path,width: 20.w,height: 20.w),
          5.horizontalSpace,
          Text(label,style: context.textTheme.labelMedium?.copyWith(
              fontSize: 12.sp,color: AppColors.infoTextHingBg
          ))
        ],
      )
  );
}

Widget buildCompletedDate(String date,BuildContext context){
   return  Flexible(
       child:
       Text(date,style: context.textTheme.labelMedium?.copyWith(fontSize: 11.sp,color: AppColors.infoTextHingBg),)
   );
}

Container totalRunningCycleWidget(BuildContext context){
  final width = MediaQuery.of(context).size.width;
  final isMobile = width < 600;
 return Container(
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
                    Text(
                      '8',
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
        ],
      )
  );
}


// Add More button for Scan
Widget addAndMoreButton(){
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      // Left circular scan icon
      Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        padding: EdgeInsets.all(10.r),
        child: SvgPicture.asset(Assets.icons.iconAddDetail.path,color: AppColors.darkGray,),
      ),
      // Right icons
      Row(
        children: [
          SvgPicture.asset(Assets.icons.iconMore.path),
        ],
      ),
    ],
  );
}

Widget customCheckbox(bool isChecked, ValueChanged onCheckedChangeListener, bool isBadTray){
   return  Checkbox(
     value: isBadTray,
     onChanged: onCheckedChangeListener,
     shape: RoundedRectangleBorder(
       borderRadius: BorderRadius.circular(4),
     ),
     side:  BorderSide(color: AppColors.checkboxBorderSideBg), // custom border color
     checkColor: AppColors.white,
     activeColor: AppColors.checkboxBorderSideBg, // when checked
   );
}


// Info window Design
Widget infoWindow(BuildContext context, CycleStage cycleStatus) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Info Icon
      SvgPicture.asset(
        Assets.icons.iconInfoBlub.path,
        width: 20.w,
        height: 20.w,
      ),
      SizedBox(width: 8.w),
      // Text Column
      Expanded(
        child: Builder(
          builder: (context) {
            switch (cycleStatus) {
              case CycleStage.seeding:
                return  _loadSeedingInfoWindow(context);
              case CycleStage.germination:
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    labelTextMedium(
                      "Scan the level QR where you want to Place the trays",
                      12.sp,
                      AppColors.blackColor,
                    )
                  ],
                );
              case CycleStage.moveToFertigation:
                return  _loadMoveToFertigationWindow(context, "Scan the level QR where you want to Place the trays");
              case CycleStage.harvesting:
                return _loadMoveToFertigationWindow(context, "Scan the level QR from where you want to Harvest the trays");
              case CycleStage.fertigation:
                // TODO: Handle this case.
                return _loadMoveToFertigationWindow(context, "Scan the level QR from where you want to Harvest the trays");
            }
          },
        ),
      )
      ,
    ],
  );
}

Widget _loadSeedingInfoWindow(BuildContext context){
   return Expanded(
     child: Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [
         labelTextMedium(S.of(context).scanTheLevelQrWhereYouWantToPlaceThe, 13.sp, AppColors.blackColor),
         SizedBox(height: 8.h), labelTextMedium(context.l10n.youCanScanMultipleSeedLotCodesAtOnce, 11.sp, AppColors.infoTextHingBg),
         SizedBox(height: 4.h),
         Align(alignment: Alignment.centerRight, child: labelTextBold(S.of(context).seeHowToDoIt, 12.sp, AppColors.seeHowToDoItTextBg),),],),);
}

Widget trayInfoContainer(BuildContext context,Color trayInfoBg,Color trayInfoBorder){
  return Container(
    padding: EdgeInsets.all(10.sp),
    decoration: AppDecorations.seedingMainBg(trayInfoBg,trayInfoBorder),
    child:  Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text("Tray Information",style: context.textTheme.labelLarge?.copyWith(fontSize: 12.sp,color: AppColors.blackColor),),
        Text("Tray Information",style: context.textTheme.labelLarge?.copyWith(fontSize: 14.sp)),
        12.verticalSpace,
        // Tray Details
        Text( "Tray Details:",style: context.textTheme.labelLarge?.copyWith(fontSize: 14.sp)),
        Text("8 Arugula Tray | 9 Gms",style: context.textTheme.labelSmall?.copyWith(fontSize: 12.sp,color: AppColors.labelTextColor)),
        12.verticalSpace,
        // Tray Position + Date Badge
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text( "Tray Position:",style: context.textTheme.labelLarge?.copyWith(fontSize: 14.sp)),
                  Text("Zone 5 | Section 4 |",style: context.textTheme.labelSmall?.copyWith(fontSize: 12.sp,color: AppColors.labelTextColor)),
                  Text("Level 3",style: context.textTheme.labelSmall?.copyWith(fontSize: 12.sp,color: AppColors.labelTextColor)),
                ],
              ),
            ),
            8.verticalSpace,
            buildDateBadge("Moved on 25/05/2025",context),
          ],
        ),
        8.verticalSpace,
        // Current Status + Date Badge
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Current Status:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text("Germination"),
                ],
              ),
            ),
            const SizedBox(width: 8),
            buildDateBadge("Since 25/05/2025",context),
          ],
        ),
      ],
    ),
  );
}

Widget buildDateBadge(String text,BuildContext context) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: AppDecorations.trayInfoPopupBg(),
    child:
    Text(text,style: context.textTheme.labelSmall?.copyWith(fontSize: 10.sp,color: AppColors.blackColor)),
  );
}

Widget _loadMoveToFertigationWindow(BuildContext context,String title){
   return Column(
     crossAxisAlignment: CrossAxisAlignment.start,
     children: [
       labelTextMedium(
         title,
         12.sp,
         AppColors.blackColor,
       )
     ],
   );
}

Widget showActionRequiredDialog(BuildContext context) {
   return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Action Required',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(Icons.info_outline, color: Colors.grey),
                ],
              ),
              const SizedBox(height: 12),

              // Subtitle
              Text(
                'You are trying to add trays beyond the available tray space on the scanned level.',
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),

              const SizedBox(height: 16),

              // Info box
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFFFFF3C1), // light yellow
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.lightbulb_outline, color: Colors.amber),
                    const SizedBox(width: 8),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                          children: [
                            TextSpan(text: 'This Level has only '),
                            TextSpan(
                              text: '5 available',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(text: ' Tray space. You can Confirm this position for first '),
                            TextSpan(
                              text: '5',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(text: ' scanned Trays and scan a new level QR for remaining '),
                            TextSpan(
                              text: '3 Trays.',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Action buttons (optional)
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('OK', style: TextStyle(color: Colors.blue)),
                ),
              ),
            ],
          ),
        ),
      );
}


Widget scanQrExpand(BuildContext context, bool showScanner, StateController<bool> toggleScanner, ScanState scanState, StateController<ScanState> scanStateNotifier, CycleStage cycleStatus) {
  return Center(
    child: GestureDetector(
      onTap: ()  {
        scanStateNotifier.state = ScanState.scanning;
      },
      child: SizedBox(
        height: 240.h,
        width: 240.w,
        child:
        Stack(
          children: [
            // Corner Decorations (outside padding)
            Positioned(
              top: 0,
              left: 0,
              child: SvgPicture.asset(Assets.images.leftSideCornerScan.path),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: SvgPicture.asset(Assets.images.iconRightTopCorner.path),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: SvgPicture.asset(Assets.images.iconLeftBottomCorner.path),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: SvgPicture.asset(Assets.images.iconRightBottomCorner.path),
            ),
            // Main Content with padding
            Container(
              child: switch(scanState){
                ScanState.idle =>  idealScanContainer(context,scanState,scanStateNotifier),
                ScanState.scanning => mobileScanner(scanState,scanStateNotifier),
                ScanState.success => idealScanContainer(context,scanState,scanStateNotifier),
                ScanState.confirmDetail => idealScanContainer(context,scanState,scanStateNotifier),
              },
            ),
            //  idealScanContainer(context)
          ],
        ),
      ),
    ),
  );
}

Widget updateTodayButton(BuildContext context, title,Color color){
  return  Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Text(title,style: context.textTheme.labelSmall?.copyWith(fontSize: 10.sp,color: color))
  );
}

Widget idealScanContainer(BuildContext context, ScanState scanState, StateController<ScanState> scanStateNotifier){
  return Container(
    margin: EdgeInsets.all(15),
    decoration: AppDecorations.scanQrcodeBg(),
    child:   Padding(
      padding: EdgeInsets.all(20.r), // Add internal spacing
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Background Icon
            Opacity(
              opacity: 0.1,
              child: Icon(
                Icons.qr_code,
                size: 160.r,
              ),
            ),
            Container(
              child: switch(scanState){
                ScanState.idle =>  tapScanColumn(context),
                ScanState.scanning => null,
                ScanState.success => scanSuccessWidget(context),
                ScanState.confirmDetail => scanSuccessWidget(context)
              },
            ),
          ],
        ),
      ),
    ),
  );
}

Widget buildTopBar() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      // Left circular scan icon
      Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        padding: EdgeInsets.all(10.r),
        child: Icon(Icons.qr_code_scanner, size: 20.r),
      ),
      // Right icons
      Row(
        children: [
          SvgPicture.asset(Assets.icons.iconFlash.path),
          10.horizontalSpace,
          SvgPicture.asset(Assets.icons.iconMore.path),
        ],
      ),
    ],
  );
}

Widget infoWidowForScan(BuildContext context, CycleStage cycleStatus, WidgetRef ref){
  final scanState = ref.watch(scanStateProvider);
  return Visibility(
      visible: scanState == ScanState.idle,
      child:   Container(
    width: double.infinity,
    decoration: boxDecoration(AppColors.white,AppColors.white),
    padding: EdgeInsets.all(3.r),
    child:    Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.r),
      decoration: AppDecorations.infoWindowBg(),
      child: infoWindow(context,cycleStatus),
    ),
  ));
}


Widget commonInfoWidgetWithText(BuildContext context, String title, String hint){
   return   Container(
     width: double.infinity,
     padding: EdgeInsets.all(16.r),
     decoration: AppDecorations.infoWindowBg(),
     child: infoWindowWithText(context,title,hint),
   );
}

Widget customProgressBar(Color background, Color active,double progress){
   return   SizedBox(
     width: 300, // Adjust width as needed
     height: 4,  // Thin progress bar
     child: ClipRRect(
       borderRadius: BorderRadius.circular(4), // Rounded corners
       child: LinearProgressIndicator(
         value: progress, // 75% filled
         backgroundColor: background,
         valueColor: AlwaysStoppedAnimation<Color>(active), // Yellowish color
       ),
     ),
   );
}
// Info window Design
Widget infoWindowWithText(BuildContext context, String title,String hint) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Info Icon
      SvgPicture.asset(
        Assets.icons.iconInfoBlub.path,
        width: 20.w,
        height: 20.w,
      ),
      SizedBox(width: 8.w),
      // Text Column
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            labelTextMedium(title, 13.sp, AppColors.blackColor),
            SizedBox(height: 8.h), labelTextMedium(hint, 11.sp, AppColors.infoTextHingBg),
            SizedBox(height: 4.h),
          ],
        )
      ),
    ],
  );
}