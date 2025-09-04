import 'package:farmeasy/base/extensions/buildcontext_ext.dart';
import 'package:farmeasy/base/services/preferences/preferences.dart';
import 'package:farmeasy/base/utils/dialougs.dart';
import 'package:farmeasy/base/utils/global_context.dart';
import 'package:farmeasy/base/utils/loader_helper.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

abstract class BaseNotifier<T> extends AutoDisposeNotifier<T> {
  String? apiError; // Used only to show error dialog if any api error comes
  bool? errorDialogShow = false;

  final PreferenceService preference = PreferenceService.instance;
  final LoaderHelper loaderHelper = LoaderHelper.instance;

  bool _validationOnUserInput = false;
  bool get isUserInputValidation => _validationOnUserInput;

  void enableUserInputValidation({bool? isEnable}) {
    _validationOnUserInput = isEnable ?? true;
  }

  void onInit() {
    apiError = null;
  }

  Future<E> processApi<E>({
    required Future<E> Function() process,
    required Function(bool isLoading) loadingHandler,
  }) async {
    errorDialogShow = false;
    loadingHandler.call(true);
    try {
      final result = await process.call();
      return result;
    } catch (e) {
      if (await preference.isLogin == "true") {
        showApiErrorDialog(
          NavigationService.currentContext.l10n.somethingWentWrong,
        );
      }
      rethrow;
    } finally {
      loadingHandler.call(false);
    }
  }

  void showApiErrorDialog(String error) {
    if (errorDialogShow == false && error != apiError) {
      errorDialogShow = true;
      apiError = error;
      showInfoDialog(
        context: NavigationService.currentContext,
        content: error,
        okayButtonText: 'close',
        onOkayTap: () {
          NavigationService.currentContext.navigator.pop();
        },
      );
    }
  }

  void clearAllDataOnLogout() {
    apiError == null;
    errorDialogShow = false;
    // ref.watch(loginProvider.notifier).clearUserLoginData();
    // Provider.of<NavbarProvider>(context, listen: false).resetData();
    // Provider.of<HomeProvider>(context, listen: false).clearHomeData();
    // Provider.of<ClaimsProvider>(context, listen: false).clearAllData();
    // Provider.of<TruDriveProvider>(context, listen: false).clearAllData();
  }
}
