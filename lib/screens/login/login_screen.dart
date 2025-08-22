import 'package:farmeasy/base/extensions/buildcontext_ext.dart';
import 'package:farmeasy/base/utils/app_colors.dart';
import 'package:farmeasy/components/common/app_text_styles.dart';
import 'package:farmeasy/components/widget/custom_checkbox.dart';
import 'package:farmeasy/screens/login/provider/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../base/utils/common_widgets.dart';
import '../../base/utils/constants.dart';
import '../../base/utils/utils.dart';
import '../../components/widget/custom_elevated_button.dart';
import '../../components/widget/custom_input_field.dart';
import '../../components/widget/custom_login_with_google.dart';
import '../../generated/l10n.dart';
import '../../generator/assets.gen.dart';
import '../../network/authRepositoryProvider.dart';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Utils.hideKeyboard(context);

    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final rememberMe = useState(false);

    final isLoading = useState(false);

    emailController.text = "newUser@mail.com";
    passwordController.text = "12345678";

    Future<void> handleLogin() async {
      if (!formKey.currentState!.validate()) return;

      isLoading.value = true;
      final success = await ref.read(authRepositoryProvider).login(emailController.text.trim(), passwordController.text.trim(),);
      isLoading.value = false;

      if (success && context.mounted) {
        context.navigator.pushReplacementNamed(homeTab);
      } else if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(S.of(context).pleaseentercorrectemail)),
        );
      }
    }

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: authScreenPadding(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 20.h),
                    child: Assets.images.splashLogo.image(height: 60.h),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20.sp),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      )
                    ],
                  ),
                  child: Form(
                    key: formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          S.of(context).login,
                          style: AppTextStyles.robotoBodyLarge.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                          ),
                        ),
                        20.verticalSpace,
                        CustomTextField(
                          controller: emailController,
                          title: context.l10n.email,
                          hintText: context.l10n.enteryouremail,
                          inputType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return context.l10n.pleaseenteremail;
                            }
                            return null;
                          },
                        ),
                        5.verticalSpace,
                        _passwordTextField(passwordController, context, ref),
                        _rememberMeAndForgot(context, rememberMe),
                        20.verticalSpace,
                        isLoading.value ? const CircularProgressIndicator() : CustomElevatedButton(
                          btnName: S.of(context).logIn,
                          onPressed: handleLogin,
                        ),
                        16.verticalSpace,
                        _dividerWithOr(context),
                        16.verticalSpace,
                        CustomGoogleButton(
                          onTap: () {
                            // Google sign-in logic
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _passwordTextField(TextEditingController passwordController, BuildContext context, WidgetRef ref) {
    final isPassHidden = ref.watch(isPassHideProvider);
    final isPassHideNotifier = ref.watch(isPassHideProvider.notifier);

    return CustomTextField(
      controller: passwordController,
      title: context.l10n.password,
      hintText: context.l10n.enterpassword,
      textInputAction: TextInputAction.done,
      inputType: TextInputType.visiblePassword,
      obscureText: isPassHidden,
      suffix: GestureDetector(
        onTap: () => isPassHideNotifier.state = !isPassHidden,
        child: isPassHidden
            ? Assets.icons.closeEyes.image(width: 24)
            : Assets.icons.closeEyes.image(width: 24),
      ),
      validator: (pass) {
        if (pass!.isEmpty) {
          return context.l10n.pleaseenterpassword;
        }
        return null;
      },
    );
  }

  Widget _rememberMeAndForgot(BuildContext context, ValueNotifier<bool> rememberMe) {
    return Align(
      alignment: Alignment.topCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Transform.scale(
            scale: 0.9,
            child: CustomCheckbox(
              value: rememberMe.value,
              onChanged: (value) => rememberMe.value = value ?? false,
            ),
          ),
          Text(
            S.of(context).rememberMe,
            style: context.textTheme.bodySmall,
          ),
          const Spacer(),
          TextButton(
            onPressed: () {},
            child: Text(
              S.of(context).forgotPassword,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dividerWithOr(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider(thickness: 1)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Text(S.of(context).or, style: TextStyle(fontSize: 14.sp)),
        ),
        const Expanded(child: Divider(thickness: 1)),
      ],
    );
  }
}
