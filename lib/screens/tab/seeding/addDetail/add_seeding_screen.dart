import 'package:farmeasy/base/extensions/buildcontext_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../../base/utils/app_colors.dart';
import '../../../../base/utils/app_decorations.dart';
import '../../../../base/utils/common_widgets.dart';
import '../../../../base/utils/custom_add_detail_button.dart';
import '../../../../base/utils/scan_more_custom_button.dart';
import '../../../../components/widget/custom_input_field.dart';
import '../../../../components/widget/step_progress_widget.dart';
import '../../../../generated/l10n.dart';
import '../../../../generator/assets.gen.dart';
import '../../bottombarNavigator/provider/bottomBar_provider.dart';
import '../provider/seeding_provider.dart';

class AddSeedingScreenPage extends HookConsumerWidget {
  const AddSeedingScreenPage({super.key});

  static const route = "/AddSeedingPage";



  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final currentIndex = ref.watch(bottomNavIndexProvider);

    final showScanner = ref.watch(scanToggleProvider);
    final toggleScanner = ref.read(scanToggleProvider.notifier);

    final scanState = ref.watch(scanStateProvider);
    final scanStateNotifier = ref.read(scanStateProvider.notifier);

    final formKey = useMemoized(() => GlobalKey<FormState>());
    final numberOfFullTrays = useTextEditingController();
    final numberOfHalfTrays = useTextEditingController();
    final passwordController = useTextEditingController();
    final isPassHide = useState(true);
    final rememberMe = useState(false);

    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                StepProgressIndicator(currentStep: 0),
                10.verticalSpace,
                // Info card
                Container(
                  decoration: boxDecoration(AppColors.scanQrMainBg,AppColors.scanQrMainBg),
                  padding: EdgeInsets.all(20.sp),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
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
                        ),
                        20.verticalSpace,
                        _numberOfFullTrays(numberOfFullTrays, context),
                        20.verticalSpace,
                        _numberOfHalfTrays(numberOfHalfTrays, context),
                        20.verticalSpace,
                        _seedLotCode(numberOfHalfTrays, context),
                        20.verticalSpace,
                        _seedsName(numberOfHalfTrays, context),
                        20.verticalSpace,
                        CoirWeightInput()
                      ],
                    ),
                  ) ,
                ),
                // Add more widgets if needed (e.g., tray list, start button, etc.)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CoirWeightInput extends StatefulWidget {
  @override
  _CoirWeightInputState createState() => _CoirWeightInputState();
}

class _CoirWeightInputState extends State<CoirWeightInput> {
  int weight = 9;
  String selectedUnit = 'gms';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color(0xFFCDE6C4), // light green background
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Coir Weight",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 6),
          Row(
            children: [
              // Number display
              Expanded(
                child: TextFormField(
                  initialValue: weight.toString(),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      weight = int.tryParse(value) ?? weight;
                    });
                  },
                ),
              ),
              SizedBox(width: 8),

              // Dropdown
              DropdownButton<String>(
                value: selectedUnit,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedUnit = newValue!;
                  });
                },
                items: ['gms', 'kgs', 'lbs'].map((String unit) {
                  return DropdownMenuItem<String>(
                    value: unit,
                    child: Text(unit),
                  );
                }).toList(),
                style: TextStyle(color: Colors.white),
                dropdownColor: Colors.green.shade700,
                iconEnabledColor: Colors.white,
                underline: SizedBox(),
              ),
              SizedBox(width: 8),

              // + Button
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    weight++;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade700,
                  padding: EdgeInsets.all(10),
                ),
                child: Text('+'),
              ),
              SizedBox(width: 4),

              // - Button
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (weight > 0) weight--;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade700,
                  padding: EdgeInsets.all(10),
                ),
                child: Text('-'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


Widget _numberOfFullTrays(
    TextEditingController emailController,
    BuildContext context,
    ) {
  return CustomTextField(
    controller: emailController,
    title: "Number of Full Trays",
    hintText: "",
    inputType: TextInputType.number,
    textInputAction: TextInputAction.next,
    validator: (val) {
      if (val!.isEmpty) {
        return context.l10n.pleaseenteremail;
      }
      // else if (!val.isValidEmail) return context.l10n.pleaseentercorrectemail;
      return null;
    },
  );
}

Widget _numberOfHalfTrays(
    TextEditingController emailController,
    BuildContext context,
    ) {
  return CustomTextField(
    controller: emailController,
    title: "Number of Half Trays",
    hintText: "",
    inputType: TextInputType.number,
    textInputAction: TextInputAction.next,
    validator: (val) {
      if (val!.isEmpty) {
        return context.l10n.pleaseenteremail;
      }
      // else if (!val.isValidEmail) return context.l10n.pleaseentercorrectemail;
      return null;
    },
  );
}


Widget _seedsName(
    TextEditingController emailController,
    BuildContext context,
    ) {
  return CustomTextField(
    controller: emailController,
    title: "Seeds Name",
    hintText: "",
    inputType: TextInputType.number,
    textInputAction: TextInputAction.next,
    validator: (val) {
      if (val!.isEmpty) {
        return context.l10n.pleaseenteremail;
      }
      // else if (!val.isValidEmail) return context.l10n.pleaseentercorrectemail;
      return null;
    },
  );
}

Widget _seedLotCode(
    TextEditingController emailController,
    BuildContext context,
    ) {
  return CustomTextField(
    controller: emailController,
    title: "Seed Lot Code",
    hintText: "",
    suffix: suffixScanNow(context),
    inputType: TextInputType.number,
    textInputAction: TextInputAction.next,
    validator: (val) {
      if (val!.isEmpty) {
        return context.l10n.pleaseenteremail;
      }
      // else if (!val.isValidEmail) return context.l10n.pleaseentercorrectemail;
      return null;
    },
  );
}

// Scan Now Suffix
Widget suffixScanNow(BuildContext context){
  return Padding(
    padding: const EdgeInsets.only(right: 8),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(Assets.icons.iconScanNow.path),
        const SizedBox(width: 4),
        Text(
          'Scan now',
          style: context.textTheme.labelMedium?.copyWith(
            color: AppColors.scanNowTextBg
          ),
        ),
      ],
    ),
  );
}

// Add Detail button
Widget addDetailButton(BuildContext context, StateController<ScanState> scanStateNotifier){
  return  Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SizedBox(
          width: 120.h,
          child:  ScanMoreCustomButton(btnName: context.l10n.scanMore, onPressed: (){
            scanStateNotifier.state = ScanState.scanning;
          })
      ),
      10.horizontalSpace,
      SizedBox(
        width: 120.h,
        child: CustomAddDetailButton(btnName: context.l10n.addDetail, onPressed: () {  },),
      ),
    ],);
}

// Info window Design
Widget infoWindow(BuildContext context) {
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
            labelTextMedium(
              context.l10n.scanTheSeedLotCodesToStartSeedingOfTrays,
              13.sp,
              AppColors.blackColor,
            ),
            SizedBox(height: 8.h),
            labelTextMedium(
              context.l10n.youCanScanMultipleSeedLotCodesAtOnce,
              11.sp,
              AppColors.infoTextHingBg,
            ),
            SizedBox(height: 4.h),
            Align(
              alignment: Alignment.centerRight,
              child: labelTextBold(
                S.of(context).seeHowToDoIt,
                12.sp,
                AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
Widget mobileScanner(ScanState scanState, StateController<ScanState> scanStateNotifier){
  return
    Center(
      child:  Container(
          margin: EdgeInsets.all(15),
          child:  ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: MobileScanner(
              controller: MobileScannerController(
                detectionSpeed: DetectionSpeed.normal,
                facing: CameraFacing.back,
              ),
              onDetect: (BarcodeCapture barcode) {
                scanStateNotifier.state = ScanState.success;
              },
            ),
          )
      ),
    )
  ;
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
              },
            ),
          ],
        ),
      ),
    ),
  );
}


Widget tapScanColumn(BuildContext context){
  return  Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        S.of(context).tapToScan,
        style: context.textTheme.labelMedium?.copyWith(
          color: AppColors.white,
        ),
      ),
      SizedBox(height: 20.h),
      SvgPicture.asset(
        Assets.icons.iconHand.path,
        placeholderBuilder: (context) =>
        const CircularProgressIndicator(),
        fit: BoxFit.contain,
        width: 35.sp,
        height: 35.sp,
      ),
    ],
  );
}

Widget scanSuccessWidget(BuildContext context){
  return  Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SvgPicture.asset(
        width: 100.h,
        height: 100.h,
        Assets.images.scanSucess.path,
        placeholderBuilder: (context) =>
        const CircularProgressIndicator(),
        fit: BoxFit.contain,
      ),

      // Bottom Buttons
    ],
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