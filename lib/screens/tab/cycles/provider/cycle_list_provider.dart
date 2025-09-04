import 'package:dio/dio.dart';
import 'package:farmeasy/base/extensions/buildcontext_ext.dart';
import 'package:farmeasy/base/providers/base_provider.dart';
import 'package:farmeasy/base/utils/common_functions.dart';
import 'package:farmeasy/base/utils/global_context.dart';
import 'package:farmeasy/network/api_manager.dart';
import 'package:farmeasy/network/api_utils.dart';
import 'package:farmeasy/screens/tab/cycles/model/res_get_cycle.dart';
import 'package:farmeasy/screens/tab/cycles/provider/cycle_list_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final cycleListProvider =
    AutoDisposeNotifierProvider<CycleListNotifier, CycleListState>(
      CycleListNotifier.new,
    );

class CycleListNotifier extends BaseNotifier<CycleListState> {
  @override
  CycleListState build() {
    return CycleListState();
  }

  late ApiManager apiProvider;

  void init() {
    state = state.copyWith(
      cycleList: [],
    );
    apiProvider = ref.read(apiManagerProvider);
  }

  Future<void> apiCall() async {
    if (await checkInternet()) {
      await _getCyclesApiCall();
    } else {
      showApiErrorDialog( NavigationService.currentContext.l10n.noInternetConnected);
    }
  }

  Future<void> _getCyclesApiCall() async {

    await processApi(
      process: () async {
        await apiProvider.callGet(path: ApiPath.getCycleUrl)
            .then((response) async {
              if (response.statusCode == 200) {
                ResGetCycle model = ResGetCycle.fromJson(response.data);
                state = state.copyWith(
                  cycleList: model.data,
                  resTraining: model,
                );
              }
            })
            .onError((DioException error, stackTrace) {
              try {
                  showApiErrorDialog(error.message ?? '');
              } catch (ex) {
                showApiErrorDialog(
                  NavigationService.currentContext.l10n.somethingWentWrong,
                );
              }
            });
      },
      loadingHandler: (isLoading) {
        state = state.copyWith(isApiCall: isLoading);
      },
    );
  }
}
