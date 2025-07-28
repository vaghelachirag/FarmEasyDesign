import 'package:farmeasy/base/extensions/buildcontext_ext.dart';
import 'package:farmeasy/base/utils/app_colors.dart';
import 'package:farmeasy/base/utils/app_decorations.dart';
import 'package:farmeasy/base/utils/dashline.dart';
import 'package:farmeasy/components/widget/custom_start_seeding_btn.dart';
import 'package:farmeasy/components/widget/cycle_status_card.dart';
import 'package:farmeasy/components/widget/searchbar_widget.dart';
import 'package:farmeasy/components/widget/time_range_selection.dart';
import 'package:farmeasy/components/widget/traystatuscard.dart';
import 'package:farmeasy/generator/assets.gen.dart';
import 'package:farmeasy/screens/tab/bottombarNavigator/provider/bottomBar_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';



class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  static const route = "/DashboardPage";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final currentIndex = ref.watch(bottomNavIndexProvider);

    return SafeArea(child:
    Scaffold(
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
            5.verticalSpace,
            Wrap(
              spacing: 16,
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
            ),
            const SizedBox(height: 16),
            ActionRequiredSection(
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
            ),
          ],
        ),
      ),
    ));
  }
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
      margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
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
              /// Left: Icon + Label + Date + Yield
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
                        SizedBox(width: 6.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Total Yield",
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "Updated on $updatedDate",
                              style: TextStyle(
                                fontSize: 10.sp,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),

                        /// Dropdown
                        GestureDetector(
                          onTap: onDropdownTap,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE8F1E6),
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  cropName,
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Colors.black87,
                                  ),
                                ),
                                Icon(
                                  Icons.keyboard_arrow_down,
                                  size: 18.sp,
                                  color: Colors.black54,
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 12.h),

                    /// Yield Row
                    Row(
                      children: [
                        Text(
                          "$yieldInGms",
                          style: TextStyle(
                            fontSize: 36.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          "gms",
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.black54,
                          ),
                        ),
                        SizedBox(width: 12.w),

                        /// Yield Change %
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: isNegative ? const Color(0xFFFDEAEA) : const Color(0xFFE5F5EF),
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                isNegative ? Icons.arrow_drop_down : Icons.arrow_drop_up,
                                size: 16.sp,
                                color: isNegative ? Colors.red : Colors.green,
                              ),
                              Text(
                                "${yieldChange.abs().toStringAsFixed(2)} %",
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: isNegative ? Colors.red : Colors.green,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    /// Dashed Line

                  ],
                ),
              ),

              SizedBox(width: 10.w),

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
            selected: 'Day',
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
      width: 280,
      child: Card(
        child: ListTile(
          title: const Text('Available Trays'),
          subtitle: const Text('Last updated on 12/07/2025'),
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
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
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
          SizedBox(height: 8.h),
          seedRequirementHeader(context,requirements),
          SizedBox(height: 12.h),
          /// List of Seeding Cards
          ...requirements.map((req) => _buildSeedingCard(req,context)),
        ],
      ),
    );
  }

  Widget _buildSeedingCard(SeedingRequirement req, BuildContext context) {
    return Container(
        decoration: AppDecorations.seedingMainBg(AppColors.startSeedsMainBg,AppColors.startSeedsBorderBg),
      margin: EdgeInsets.only(bottom: 12.h),
      child:
      Container(
        margin: EdgeInsets.all(2.h),
        padding: EdgeInsets.all(12.w),
        decoration: AppDecorations.seedingBg(),
        child:
        Container(
          decoration: BoxDecoration(
            border: Border.all(color:AppColors.white),
            borderRadius: BorderRadius.circular(12.r),
          ),
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
                  style: context.textTheme.labelLarge?.copyWith(
                      fontSize: 16.sp
                  ),
                ),
                Text(
                  'Due on ${req.dueDate}',
                  style: context.textTheme.labelSmall?.copyWith(
                      fontSize: 12.sp
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            /// Start Seeding Button
            SizedBox(
              width: double.infinity,
              child:StartSeedingButton(
                onPressed: () {
                  print("Seeding started");
                },
              ),
            )
          ],
        )) ,
      )
     ,
    );
  }
}

Widget actionRequiredHeader(BuildContext context){
  return   Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        'Action Required',
        style: context.textTheme.labelLarge,
      ),
      SizedBox(width: 10.w),
      Tooltip(
        message: 'You need to take action on pending seeding tasks.',
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
        style: context.textTheme.labelSmall,
      )),
      SizedBox(width: 8.w),
      Tooltip(
        message: 'You need to take action on pending seeding tasks.',
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
