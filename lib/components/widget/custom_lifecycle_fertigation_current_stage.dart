import 'package:farmeasy/base/extensions/buildcontext_ext.dart';
import 'package:farmeasy/base/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../base/utils/app_decorations.dart';
import '../../screens/tab/cycles/provider/cycles_provider.dart';
import 'custom_fertigation_current_stage.dart';
import 'custom_lifecycle_fertigation_current_stage_header.dart';


class CustomLifecycleFertigationCurrentStage extends ConsumerWidget {
  const CustomLifecycleFertigationCurrentStage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isExpanded = ref.watch(stageExpandProvider);

    return Container(
      decoration: AppDecorations.seedingMainBg(AppColors.trayInfoPopupBg,AppColors.trayInfoCycleBorderBg),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Current Stage",style: context.textTheme.labelSmall?.copyWith(fontSize: 14.sp,color: AppColors.infoTextHingBg)),
          10.verticalSpace,
          CustomLifecycleFertigationCurrentStageHeader(isExpanded: isExpanded),
          Align(
              alignment: Alignment.bottomRight,
              child:
              GestureDetector(
                onTap: (){
                  ref.read(stageExpandProvider.notifier).state = !isExpanded;
                },
               child:   Row(
                 crossAxisAlignment: CrossAxisAlignment.center,
                 mainAxisAlignment: MainAxisAlignment.end,
                 children: [
                   Text(!isExpanded ? "Hide Lifecycle" : "View Lifecycle",style: context.textTheme.labelSmall?.copyWith(fontSize: 14.sp,color: AppColors.infoTextHingBg),),
                   2.horizontalSpace,
                   Icon(
                     isExpanded ? Icons.expand_less : Icons.expand_more,
                     color: Color(0xFF49454F),
                   )
                 ],
               ),
              )
          ),
        ],
      ),
    );
  }
}
