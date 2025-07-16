import 'package:farmeasy/base/extensions/buildcontext_ext.dart';
import 'package:farmeasy/base/utils/app_colors.dart';
import 'package:farmeasy/components/widget/custom_checkbox.dart';
import 'package:farmeasy/screens/login/provider/login_provider.dart';
import 'package:farmeasy/screens/tab/dashboard/dashboard_page.dart';
import 'package:farmeasy/screens/tab/homeTab/home_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../base/utils/common_widgets.dart';
import '../../components/widget/custom_elevated_button.dart';
import '../../components/widget/custom_input_field.dart';
import '../../components/widget/custom_login_with_google.dart';
import '../../generated/l10n.dart';
import '../../generator/assets.gen.dart';

class LoginScreen extends HookConsumerWidget {
  static const route = "/LoginScreen";

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final email = ref.watch(emailProvider);
    final password = ref.watch(passwordProvider);
    final isLoginEnabled = ref.watch(rememberMeProvider);
    final isLoading = ref.watch(isLoadingProvider);

    final isPassHide = ref.watch(isPassHideProvider.notifier);
    final isPassHidden = ref.watch(isPassHideProvider); // For toggle value

    final rememberMe = ref.watch(rememberMeProvider.notifier);
    final isRememberMe = ref.watch(rememberMeProvider);

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor, // light green background
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: authScreenPadding(),
            child: _buildLoginForm(context,ref),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginForm(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final isPassHide = useState(true);
    final rememberMe = useState(false);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // 🟢 Logo Image on top
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: EdgeInsets.only(bottom: 20.h),
            child: Assets.images.splashLogo.image(
              height: 60.h,
            ),
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
                offset: Offset(0, 4),
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
                  style: context.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                20.verticalSpace,
                _emailTextField(emailController, context),
                5.verticalSpace,
                _passwordTextField(passwordController, context, ref),
                _rememberMeAndForgot(context, rememberMe),
                20.verticalSpace,
                CustomElevatedButton(
                  btnName: S.of(context).logIn,
                  onPressed: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    context.navigator.pushReplacementNamed(HomeTab.route);
                    // Add login validation here
                  },
                ),
                16.verticalSpace,
                _dividerWithOr(),
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
    );
  }


  Widget _emailTextField(
      TextEditingController emailController,
      BuildContext context,
      ) {
    return CustomTextField(
      controller: emailController,
      title: context.l10n.email,
      hintText: context.l10n.enteryouremail,
      inputType: TextInputType.emailAddress,
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

  Widget _passwordTextField(
      TextEditingController passwordController,
      BuildContext context,
      WidgetRef ref,
      ) {
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
    return
      Align(
        alignment: Alignment.topCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start, // Ensures left-aligned children
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          Transform.scale(
          scale: 0.9,
          child:
          CustomCheckbox(
            value: rememberMe.value,
            onChanged: (value) => rememberMe.value = value ?? false,
          ),),
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

  Widget _dividerWithOr() {
    return Row(
      children: [
        const Expanded(child: Divider(thickness: 1)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Text("Or", style: TextStyle(fontSize: 14.sp)),
        ),
        const Expanded(child: Divider(thickness: 1)),
      ],
    );
  }
}
