import 'package:farmeasy/base/extensions/buildcontext_ext.dart';
import 'package:farmeasy/base/utils/app_colors.dart';
import 'package:farmeasy/base/utils/constants.dart';
import 'package:farmeasy/base/utils/dashline.dart';
import 'package:farmeasy/components/widget/custom_start_seeding_btn.dart';
import 'package:farmeasy/components/widget/cycle_status_card.dart';
import 'package:farmeasy/components/widget/searchbar_widget.dart';
import 'package:farmeasy/components/widget/time_range_selection.dart';
import 'package:farmeasy/components/widget/traystatuscard.dart';
import 'package:farmeasy/generator/assets.gen.dart';
import 'package:farmeasy/screens/tab/bottombarNavigator/provider/bottomBar_provider.dart';
import 'package:farmeasy/screens/tab/cycles/provider/cycles_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../components/common/app_text_styles.dart';
import '../../../generated/l10n.dart';



class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final currentIndex = ref.watch(bottomNavIndexProvider);

    return SafeArea(child:
    Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.navigator.pushNamed(
            seedingTraysScreen,
            arguments: {cycleStageArgumentName: CycleStage.seeding},
          );
        },
        backgroundColor: AppColors.customCycleTabSelectedColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchBarWidget(
              context,
              onMenuTap: () {
                // open drawer or perform menu action
              },
              onSearchTap: () {
                // trigger search
              },
            ),
            _trayStatusWidget(context),
            5.verticalSpace,
            _actionRequiredSection(context),
            10.verticalSpace,
          ],
        ),
      ),
    ));
  }
}
Widget _actionRequiredSection(BuildContext context){
  return     ActionRequiredSection(
    requirements: [
      SeedingRequirement(
        item: 'Arugula',
        quantity: '50 gms',
        dueDate: '22/09/2025',
        onStartSeeding: () => print('Seeding started for Arugula'),
      ),
      SeedingRequirement(
        item: 'Arugula',
        quantity: '50 gms',
        dueDate: '22/09/2025',
        onStartSeeding: () => print('Seeding started'),
      ),
      SeedingRequirement(
        item: 'Arugula',
        quantity: '50 gms',
        dueDate: '22/09/2025',
        onStartSeeding: () => print('Seeding started'),
      ),
    ],
  );
}

Widget _trayStatusWidget(BuildContext context){
  return  Wrap(
    spacing: 10,
    runSpacing: 16,
    children:  [
      TrayStatusCard(
          available: 18,
          total: 134,
          date: '12/07/2025',
          context: context
      ),
      CycleStatusCard(
        totalCycles: 12,
        date: '12/07/2025',
        stageData: {
          "Seeding": 3,
          "Germination": 2,
          "Fertigation": 4,
          "Harvesting": 3,
        },
      ),
      TotalYieldSection(
        cropName: "Arugula",
        updatedDate: "12/07/2025",
        yieldInGms: 1280,
        yieldChange: -7.33,
        onDropdownTap: () => print("Change crop tapped"),
      )
    ],
  );
}

class TotalYieldSection extends StatelessWidget {
  final String cropName;
  final String updatedDate;
  final int yieldInGms;
  final double yieldChange;
  final VoidCallback onDropdownTap;

  const TotalYieldSection({
    super.key,
    required this.cropName,
    required this.updatedDate,
    required this.yieldInGms,
    required this.yieldChange,
    required this.onDropdownTap,
  });

  @override
  Widget build(BuildContext context) {
    final isNegative = yieldChange < 0;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 0.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            color: Colors.black.withOpacity(0.05),
          ),
        ],
      ),
      child:
      Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Top Row
                    Row(
                      children: [
                        SvgPicture.asset(
                          Assets.icons.syncIcon.path,
                          width: 18.sp,
                        ),
                        6.verticalSpace,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              S.of(context).totalYield,
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                             S.of(context).updatedOn +updatedDate,
                              style: TextStyle(
                                fontSize: 10.sp,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: onDropdownTap,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE8F1E6),
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  cropName,
                                  style: context.textTheme.titleSmall?.copyWith(fontSize: 10.sp,color: AppColors.infoTextHingBg),
                                ),
                               10.horizontalSpace,
                               SvgPicture.asset(Assets.icons.iconDropdown.path,color: AppColors.infoTextHingBg)
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    12.verticalSpace,
                    Row(
                      children: [
                        Text(
                          "$yieldInGms",
                          style: AppTextStyles.poppinsTitleLarge,
                        ),
                        SizedBox(width: 10.w),
                        Text(
                          S.of(context).gms,
                          style:  AppTextStyles.robotoBodyRegular.copyWith(fontSize: 10.sp),
                        ),
                        SizedBox(width: 12.w),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: isNegative ? AppColors.totalGmsBg : AppColors.totalGmsBg,
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Row(
                            children: [
                              SvgPicture.asset(Assets.icons.iconDropdown.path,color: AppColors.totalGmsTextBg,),
                              5.horizontalSpace,
                              Text(
                                "${yieldChange.abs().toStringAsFixed(2)} %",
                                style: AppTextStyles.robotoBodyRegular.copyWith(
                                  fontSize: 10.sp,
                                  color: AppColors.totalGmsTextBg
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            10.horizontalSpace,
              Stack(
                alignment: Alignment.topRight,
                children: [
                  SvgPicture.asset(
                    Assets.images.onlineStore.path,
                    width: 50.w,
                    height: 50.w,
                    fit: BoxFit.contain,
                  ),
                  Positioned(
                    top: -4,
                    right: -4,
                    child: Container(
                      width: 16.w,
                      height: 16.w,
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.check, size: 10, color: Colors.white),
                    ),
                  ),
                ],
              )
            ],
          ),
          10.verticalSpace,
          /// Dashed Line
          DashedLine(
            height: 1,
            dashWidth: 6,
            dashSpacing: 4,
            color: Colors.grey.shade400,
          ),
          10.verticalSpace,
          TimeRangeSelector(
            selected: S.of(context).day,
            onSelect: (value) {
            },
          ),
          10.verticalSpace,
          SvgPicture.asset(Assets.images.dashboardChart.path)
        ],
      ),
    );
  }
}
class AvailableTraysCard extends StatelessWidget {
  const AvailableTraysCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280.w,
      child: Card(
        child: ListTile(
          title:  Text(S.of(context).availableTrays),
          subtitle:  Text('${S.of(context).lastUpdatedOn}12/07/2025',style: AppTextStyles.robotoBodyRegular.copyWith(fontSize: 8.sp),),
          trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: const [
              Text('18 / 134', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Icon(Icons.agriculture_outlined),
            ],
          ),
        ),
      ),
    );
  }
}

class ActionRequiredSection extends StatelessWidget {
  final List<SeedingRequirement> requirements;

  const ActionRequiredSection({super.key, required this.requirements});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 3.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: Offset(0, 2),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Header Row
          actionRequiredHeader(context),
          8.verticalSpace,
          seedRequirementHeader(context,requirements),
          12.verticalSpace,
          /// List of Seeding Cards
          ...requirements.map((req) => _buildSeedingCard(req,context)),
          8.horizontalSpace,
          /// Start Seeding Button
          SizedBox(
            width: double.infinity,
            height: 30.h,
            child:StartSeedingButton(
              onPressed: () {

              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSeedingCard(SeedingRequirement req, BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Quantity + Date
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${req.quantity} ${req.item}',
                  style: AppTextStyles.robotoBodyLarge.copyWith(fontSize: 12.sp,color: AppColors.blackColor),
                ),
                Text(
                  'Due on ${req.dueDate}',
                  style: AppTextStyles.robotoBodyRegular.copyWith(fontSize: 10.sp,color: AppColors.infoTextHingBg),
                ),
              ],
            ),
          ],
        ) ,
    );
  }
}

Widget actionRequiredHeader(BuildContext context){
  return   Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        S.of(context).actionRequired,
        style: AppTextStyles.robotoBodyRegular.copyWith(fontSize: 14.sp),
      ),
      10.horizontalSpace,
      Tooltip(
        message: S.of(context).youNeedToTakeActionOnPendingSeedingTasks,
        child: Icon(
          Icons.arrow_forward,
          size: 16.sp,
          color: AppColors.blackColor,
        ),)
    ],
  );
}

Widget seedRequirementHeader(BuildContext context, List<SeedingRequirement> requirements){
  return   Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(child:
      Text(
        "You have ${requirements.length} new seeding requirements due in next 3 days.",
        style: AppTextStyles.robotoBodyRegular,
      )),
      8.horizontalSpace,
      Tooltip(
        message: S.of(context).youNeedToTakeActionOnPendingSeedingTasks,
        child:  SvgPicture.asset(
  Assets.icons.iconInfo.path,
  color: Colors.grey,
  )),
    ],
  );
}


class SeedingRequirement {
  final String item;
  final String quantity;
  final String dueDate;
  final VoidCallback onStartSeeding;

  SeedingRequirement({
    required this.item,
    required this.quantity,
    required this.dueDate,
    required this.onStartSeeding,
  });
}
