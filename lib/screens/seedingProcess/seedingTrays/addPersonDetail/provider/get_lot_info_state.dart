import 'package:farmeasy/screens/tab/cycles/model/res_get_cycle.dart';

import '../../../../../model/seeds/getSeedLotInfoResponse/getSeedLotInfoResponse.dart';

class GetLotInfoState {
  final bool isApiCall;
  final List<GetSeedLotSeed> cycleList;
  final ResGetCycle? resTraining;

  GetLotInfoState({
    this.isApiCall = false,
    this.cycleList = const [],
    this.resTraining,
  });

  GetLotInfoState copyWith({
    bool? isApiCall,
    List<GetSeedLotSeed>? cycleList,
    ResGetCycle? resTraining,
  }) {
    return GetLotInfoState(
      isApiCall: isApiCall ?? this.isApiCall,
      cycleList: cycleList ?? this.cycleList,
      resTraining: resTraining ?? this.resTraining,
    );
  }
}
