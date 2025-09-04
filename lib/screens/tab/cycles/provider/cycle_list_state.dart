import 'package:farmeasy/screens/tab/cycles/model/res_get_cycle.dart';

class CycleListState {
  final bool isApiCall;
  final List<CycleData> cycleList;
  final ResGetCycle? resTraining;

  CycleListState({
    this.isApiCall = false,
    this.cycleList = const [],
    this.resTraining,
  });

  CycleListState copyWith({
    bool? isApiCall,
    List<CycleData>? cycleList,
    ResGetCycle? resTraining,
  }) {
    return CycleListState(
      isApiCall: isApiCall ?? this.isApiCall,
      cycleList: cycleList ?? this.cycleList,
      resTraining: resTraining ?? this.resTraining,
    );
  }
}
