import 'package:farmeasy/base/extensions/buildcontext_ext.dart';
import 'package:farmeasy/components/common/custom_unit_dropdown.dart';
import 'package:farmeasy/components/widget/custom_add_people_suggestion_text_filed.dart';
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
import '../../../../base/utils/constants.dart';
import '../../../../base/utils/custom_add_detail_button.dart';
import '../../../../base/utils/scan_more_custom_button.dart';
import '../../../../base/utils/utils.dart';
import '../../../../components/widget/custom_input_field.dart';
import '../../../../components/widget/custom_leet_code_chipset.dart';
import '../../../../components/widget/step_progress_widget.dart';
import '../../../../components/widget/widget_custom_qr_processed.dart';
import '../../../../generated/l10n.dart';
import '../../../../generator/assets.gen.dart';
import '../../../tab/bottombarNavigator/provider/bottomBar_provider.dart';
import '../../../tab/cycles/provider/cycles_provider.dart';
import '../../../tab/seeding/provider/seeding_provider.dart';
import 'provider/add_person_detail_screen.dart';

class AddPersonDetailScreen extends HookConsumerWidget {
  AddPersonDetailScreen({super.key});

  static const route = "/AddPersonDetailScreen";
  late CycleStage cycleStatus;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Utils.hideKeyboard(context);
    getArgument(context);


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

    final searchText = ref.watch(peopleSearchTextProvider);
    final lotCodes = ref.watch(seedLotListProvider);

    return SafeArea(
      child: Scaffold(
        appBar: getActionbar(context,S.of(context).seedingTrays),
        body:  mainWidgetForSeedingContainer(_mainWidgetForAddPerson(numberOfFullTrays,numberOfHalfTrays,context,ref,searchText))
      ),
    );
  }

Widget _mainWidgetForAddPerson(TextEditingController numberOfFullTrays, TextEditingController numberOfHalfTrays, BuildContext context, WidgetRef ref, String searchText){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20.h),
        StepProgressIndicator(currentStepName: cycleStatus),
        10.verticalSpace,
        // Info card
        Container(
          decoration: boxDecoration(AppColors.scanQrMainBg,AppColors.scanQrMainBg),
          padding: EdgeInsets.all(20.sp),
          child: SingleChildScrollView(
            child: Column(
              children: [
                addAndMoreButton(),
                20.verticalSpace,
                _numberOfFullTrays(numberOfFullTrays, context),
                20.verticalSpace,
                _numberOfHalfTrays(numberOfHalfTrays, context),
                20.verticalSpace,
                _seedLotCode(numberOfHalfTrays, context),
                5.verticalSpace,
                _seedsName(numberOfHalfTrays, context),
                20.verticalSpace,
                _seedWeightTray(numberOfHalfTrays, context),
                20.verticalSpace,
                _coreWeightTray(numberOfHalfTrays, context),
                20.verticalSpace,
                _customSeeLotInputFiled(ref),
                10.verticalSpace,
                _addPeopleSuggestionWidget(searchText),
                _seedingDate(numberOfHalfTrays, context),
                20.verticalSpace,
                _customProcessButton()
              ],
            ),
          ) ,
        ),
        // Add more widgets if needed (e.g., tray list, start button, etc.)
      ],
    );
}

  Widget _customProcessButton(){
    return  CustomProceedButton(onPressed: (){},title: "Processed",iconPath:   Assets.icons.iconQrProcessed.path);
  }

  Widget _customSeeLotInputFiled(WidgetRef ref){
    return CustomSeedLotInputField(
      title: "Seed Lot Code",
      onScanPressed: () {
        // Open QR scanner or add manually
      },
      onRemovePressed: () {
        // Logic to remove a lot code
        ref.read(seedLotListProvider.notifier).state = [];
      },
    );
  }
  void getArgument(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    cycleStatus = args[cycleStageArgumentName];
  }
}

// Add People Suggestion Widget
Widget _addPeopleSuggestionWidget(String searchText){
  return SizedBox(
    height: searchText.isEmpty ? 80 : 200,
    child:   CustomAddPeopleSuggestionTextFiled(),
  );
}

// Widget Remove Lot Code
Widget removeLotCodeWidget(BuildContext context){
  return Align(
    alignment: Alignment.topRight,
    child: labelTextRegular(S.of(context).removeALotCode, 10.sp, AppColors.removeLotCodeBg),
  );
}

Widget _numberOfFullTrays(TextEditingController emailController, BuildContext context) {
  return CustomTextField(
    controller: emailController,
    title: S.of(context).numberOfFullTrays,
    hintText: "",
    inputType: TextInputType.number,
    textInputAction: TextInputAction.next,
    validator: (val) {
      if (val!.isEmpty) {
        return context.l10n.pleaseenteremail;
      }
      return null;
    },
  );
}

Widget _numberOfHalfTrays(TextEditingController emailController, BuildContext context,) {
  return CustomTextField(
    controller: emailController,
    title: S.of(context).numberOfHalfTrays,
    hintText: "",
    inputType: TextInputType.number,
    textInputAction: TextInputAction.next,
    validator: (val) {
      if (val!.isEmpty) {
        return context.l10n.pleaseenteremail;
      }
      return null;
    },
  );
}

Widget _seedsName(TextEditingController emailController, BuildContext context,) {
  return CustomTextField(
    controller: emailController,
    title: S.of(context).seedsName,
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

Widget _seedLotCode(TextEditingController emailController, BuildContext context,) {
  return CustomTextField(
    controller: emailController,
    title: S.of(context).seedLotCode,
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

Widget _seedingDate(TextEditingController emailController, BuildContext context,) {
  return CustomTextField(
    controller: emailController,
    title: S.of(context).seedingDate,
    hintText: "",
    suffix: suffixDateIcon(context),
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

Widget _seedWeightTray(
    TextEditingController emailController,
    BuildContext context,
    ) {
  return CustomTextField(
    controller: emailController,
    title: S.of(context).seedweighttray,
    hintText: "",
    suffix: suffixCoreWeight(context),
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

Widget _coreWeightTray(TextEditingController emailController, BuildContext context,) {
  return CustomTextField(
    controller: emailController,
    title: S.of(context).coreWeight,
    hintText: "",
    suffix: suffixCoreWeight(context),
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


Widget suffixCoreWeight(BuildContext context){
  String selectedUnit = S.of(context).gms;
  return  Container(
    padding: const EdgeInsets.only(right: 6),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Unit Dropdown
         gmsWeightWidget(selectedUnit,context),
        6.horizontalSpace,
        // Combined + / - buttons
        addAndMinusButtonWidget()
      ],
    ),
  );
}

Widget addAndMinusButtonWidget(){
  return  Container(
    height: 35,
    decoration: BoxDecoration(
      color: AppColors.addWeightTextFieldBg,
      borderRadius: BorderRadius.circular(4),
    ),
    child: Row(
      children: [
        _actionButton('+'),
        _actionButton('–'),
      ],
    ),
  );
}

Widget gmsWeightWidget(String selectedUnit, BuildContext context){
  return Container(
    height: 35,
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
    decoration: AppDecorations.addWeightDecoration(),
    child: CustomUnitDropdown(
      selectedUnit: selectedUnit,
      onChanged: (value) {

      },
    ),
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
          S.of(context).scanNow,
          style: context.textTheme.labelMedium?.copyWith(
            color: AppColors.scanNowTextBg
          ),
        ),
      ],
    ),
  );
}

// Scan Now Suffix
Widget suffixDateIcon(BuildContext context){
  return Padding(
    padding: const EdgeInsets.only(right: 8),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(Assets.icons.iconCalendar.path),
      ],
    ),
  );
}

Widget _actionButton(String symbol) {
  return InkWell(
    child: Container(
      width: 30,
      alignment: Alignment.center,
      child: labelTextRegular(symbol, 18.sp, AppColors.white)
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
        child: CustomAddDetailButton(
          iconPath: Assets.icons.iconAddDetail.path,
          btnName: context.l10n.addDetail, onPressed: () {  },),
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
                ScanState.confirmDetail => null,
                ScanState.moveToFertigation => null,
                ScanState.scanNextQR => null,
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

Widget listItemContent(Map<String, String> person, WidgetRef ref) {
  final selectedPeople = ref.watch(selectedPeopleProvider);

  bool isSelected = selectedPeople.any((p) => p['id'] == person['id']);

  return GestureDetector(
    onTap: () {
      final notifier = ref.read(selectedPeopleProvider.notifier);
      if (isSelected) {
        notifier.state = [...notifier.state]..removeWhere((p) => p['id'] == person['id']);
      } else {
        notifier.state = [...notifier.state, person];
      }
    },
    child: Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.green.shade200 : AppColors.addPeopleSuggestionBg,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(person['image']!),
            radius: 15.sp,
          ),
          8.horizontalSpace,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              labelTextBold(person['name']!, 12.sp, AppColors.addPeopleTextBg),
              labelTextMedium(person['role']!, 10.sp, AppColors.addPeopleTextBg),
            ],
          ),
        ],
      ),
    ),
  );
}
