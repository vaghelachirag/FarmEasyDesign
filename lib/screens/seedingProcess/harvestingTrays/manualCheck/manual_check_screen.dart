import 'package:farmeasy/screens/tab/cycles/provider/cycles_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:farmeasy/base/utils/common_widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../base/utils/app_colors.dart';
import '../../../../components/widget/custom_add_people_suggestion_text_filed.dart';
import '../../../../components/widget/custom_checkbox_with_text.dart';
import '../../../../components/widget/custom_input_field.dart';
import '../../../../components/widget/custom_step_progress_manual_check.dart';
import '../../../../components/widget/custom_upload_photo_grid.dart';
import '../../../../components/widget/step_progress_widget.dart';
import '../../../../generated/l10n.dart';
import '../../seedingTrays/addPersonDetail/provider/add_person_detail_screen.dart';




class ManualCheckScreen extends HookConsumerWidget {
  static const route = "/ManualCheckScreen";


  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final formKey = useMemoized(() => GlobalKey<FormState>());
    final numberOfFullTrays = useTextEditingController();
    final numberOfHalfTrays = useTextEditingController();
    final passwordController = useTextEditingController();
    final isPassHide = useState(true);
    final rememberMe = useState(false);

    final searchText = ref.watch(peopleSearchTextProvider);


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
                      CustomCheckboxWithText(title: "Mark this as Bad Trays", isChecked: true,)
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

}