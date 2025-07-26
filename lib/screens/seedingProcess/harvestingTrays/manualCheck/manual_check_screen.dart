import 'package:farmeasy/base/extensions/buildcontext_ext.dart';
import 'package:farmeasy/screens/seedingProcess/harvestingTrays/manualCheck/confirmationManualCheck/confirmation_manual_check_screen.dart';
import 'package:farmeasy/screens/seedingProcess/harvestingTrays/manualCheck/provider/manual_check_screen_provider.dart';
import 'package:farmeasy/screens/tab/cycles/provider/cycles_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:farmeasy/base/utils/common_widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../base/utils/app_colors.dart';
import '../../../../base/utils/constants.dart';
import '../../../../base/utils/custom_add_detail_button.dart';
import '../../../../components/widget/custom_add_people_suggestion_text_filed.dart';
import '../../../../components/widget/custom_checkbox_with_text.dart';
import '../../../../components/widget/custom_input_drop_down.dart';
import '../../../../components/widget/custom_input_field.dart';
import '../../../../components/widget/custom_notes_input_field.dart';
import '../../../../components/widget/custom_step_progress_manual_check.dart';
import '../../../../components/widget/custom_upload_photo_grid.dart';
import '../../../../components/widget/step_progress_widget.dart';
import '../../../../generated/l10n.dart';
import '../../../../generator/assets.gen.dart';
import '../../../tab/seeding/provider/seeding_provider.dart';
import '../../seedingTrays/addPersonDetail/provider/add_person_detail_screen.dart';




class ManualCheckScreen extends HookConsumerWidget {
  static const route = "/ManualCheckScreen";

  const ManualCheckScreen({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final formKey = useMemoized(() => GlobalKey<FormState>());
    final numberOfFullTrays = useTextEditingController();
    final numberOfHalfTrays = useTextEditingController();
    final passwordController = useTextEditingController();
    final isPassHide = useState(true);
    final rememberMe = useState(false);

    final searchText = ref.watch(peopleSearchTextProvider);


  // Note Controller
    final isBadTray = ref.watch(badTrayProvider);
    final selectedIssue = ref.watch(selectedIssueProvider);
    final notesController = useTextEditingController(
      text: ref.read(notesProvider),
    );

    final issues = [
      "The nutrients were not enough",
      "Overwatered",
      "Fungus growth",
      "Poor seed quality",
    ];


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
                decoration: boxDecoration(
                    AppColors.scanQrMainBg, AppColors.scanQrMainBg),
                padding: EdgeInsets.all(20.sp),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      addAndMoreButton(),
                      10.verticalSpace,
                      _numberOfFullTrays(numberOfFullTrays, context),
                      10.verticalSpace,
                      _addPeopleSuggestionWidget(searchText),
                      _seedsName(numberOfHalfTrays, context),
                      10.verticalSpace,
                      CustomUploadPhotoGrid(),
                      10.verticalSpace,
                      CustomCheckboxWithText(title: "Mark this as Bad Trays", isChecked: true, onCheckedChangeListener: (value) {
                        ref.read(badTrayProvider.notifier).state = value ?? false;
                      }, isBadTray: isBadTray),
                      if(ref.read(badTrayProvider.notifier).state)
                      noteRemarkWidget(numberOfHalfTrays,context,selectedIssue,notesController,issues,ref),
                      50.verticalSpace,
                      confirmSaveButton(context,ref,isBadTray)
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }

  // Add Detail button
  Widget confirmSaveButton(BuildContext context, WidgetRef ref, bool isBadTrayChecked){
    return SizedBox(
      width: double.infinity,
      child: CustomAddDetailButton(btnName: "Proceed", onPressed: () {
        context.navigator.pushNamed(
          ConfirmationManualCheckScreen.route,
          arguments: {isBadTray: isBadTrayChecked},
        );
      },iconPath: Assets.icons.iconConfirmAndProcessed.path),
    );
  }

  Widget noteRemarkWidget(TextEditingController numberOfHalfTrays, BuildContext context, String? selectedIssue, TextEditingController notesController, List<String> issues, WidgetRef ref){
    final issueController = useTextEditingController();
    final notesController = useTextEditingController();
    return Column(
      children: [
        SizedBox(height: 8),
    CustomDropdownField(
    title: "Issue",
    hintText: "Select an issue",
    items: issues,
    selectedValue: selectedIssue,
    onChanged: (value) {
    ref.read(selectedIssueProvider.notifier).state = value;
    },
    ),
     10.verticalSpace,
        _issueNotes(numberOfHalfTrays,context)
      ],
    );
  }

  // Add People Suggestion Widget
  Widget _addPeopleSuggestionWidget(String searchText){
    return    SizedBox(
      height: searchText.isEmpty ? 80 : 200,
      child:   CustomAddPeopleSuggestionTextFiled(),
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
          return "pleaseenteremail";
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
          return "pleaseenteremail";
        }
        // else if (!val.isValidEmail) return context.l10n.pleaseentercorrectemail;
        return null;
      },
    );
  }

  Widget _issueNotes(TextEditingController emailController, BuildContext context,) {
    return CustomNotesInputField(
      controller: emailController,
      title: "Notes/Remarks",
      hintText: "",
      inputType: TextInputType.number,
      textInputAction: TextInputAction.next,
      validator: (val) {
        if (val!.isEmpty) {
          return "pleaseenteremail";
        }
        // else if (!val.isValidEmail) return context.l10n.pleaseentercorrectemail;
        return null;
      },
    );
  }

}