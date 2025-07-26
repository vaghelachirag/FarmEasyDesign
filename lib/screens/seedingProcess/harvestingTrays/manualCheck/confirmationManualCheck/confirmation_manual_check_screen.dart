
import 'package:farmeasy/base/utils/constants.dart';
import 'package:farmeasy/base/utils/custom_add_detail_button.dart';
import 'package:farmeasy/components/widget/custom_mark_as_bad_button.dart';
import 'package:farmeasy/generator/assets.gen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../base/utils/app_decorations.dart';
import '../../../../../base/utils/common_widgets.dart';
import '../../../../../base/utils/dialougs.dart';
import '../../../../../components/widget/common_widget_manual_check_card.dart';
import '../../../../../components/widget/custom_step_progress_manual_check.dart';

class ConfirmationManualCheckScreen extends HookConsumerWidget {
  static const route = "/ConfirmationManualCheckScreen";

  late bool isBadTrayCheck;
   ConfirmationManualCheckScreen({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {

    getArgument(context);

    return SafeArea(child: Scaffold(
      appBar: getActionbar("Manual Check"),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              10.verticalSpace,
              CustomStepProgressManualCheck(),
              10.verticalSpace,
              Container(
                width: double.infinity,
                decoration: AppDecorations.moveToGerminationDialogueDecoration(),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonWidgetManualCheckCard(title: isBadTrayCheck ?  "Mark as a Bad Tray !" : "Manual Check"),
                    10.verticalSpace,
                    trayTextWidget("Tray Details:","8 Arugula Tray | 9 Gms ",context),
                    8.verticalSpace,
                    trayTextWidget("Tray Position: ","Zone 3 | Section 4 | Level 3 ",context),
                    _isBadTrayText(context)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: setBottomButton()
    ));
  }

  Widget _isBadTrayText(BuildContext context){
    return Visibility(visible: isBadTrayCheck, child:  trayTextWidget("Issue: ","Tray Broken ",context));
  }

  Widget setBottomButton(){
  return Padding(
      padding: const EdgeInsets.all(16.0) ,child: isBadTrayCheck ?  CustomMarkAsBadButton(btnName: "Mark as Bad Tray", iconPath: Assets.icons.iconMarkIssue.path, onPressed: (){}) : CustomAddDetailButton(btnName: "Confirm & Save", iconPath: Assets.icons.iconConfirmSave.path, onPressed: (){})

  );
  }

  void getArgument(BuildContext context) {
      final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      isBadTrayCheck = args[isBadTray];
    }
}