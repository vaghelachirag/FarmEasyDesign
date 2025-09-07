// seed_lot_provider.dart
import 'package:farmeasy/screens/seedInfo/seedLotRepository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../base/services/preferences/preferences.dart';
import '../../model/seeds/getSeedLotInfoResponse/getSeedLotInfoResponse.dart';
import '../../network/authRepositoryProvider.dart';
import '../seedingProcess/seedingTrays/addPersonDetail/provider/add_person_detail_screen_provider.dart';
import 'seed_lot_model.dart';

final seedLotRepositoryProvider = Provider((ref) => SeedLotRepository());
/*

final seedLotProvider =
AsyncNotifierProvider.family<SeedLotNotifier, SeedLot, String>(
  SeedLotNotifier.new,
);
*/

class SeedLotNotifier extends FamilyAsyncNotifier<SeedLot, String> {
  @override
  Future<SeedLot> build(String id) async {
    final repo = ref.read(seedLotRepositoryProvider);
    return repo.fetchSeedLot(id);
  }
}


// Provider for fetching individual seed lot by ID
final seedLotProvider = FutureProvider.family.autoDispose<GetSeedLotInfoResponse?, String>((ref, lotId) async {
  final prefs = PreferenceService.instance;
  final token = await prefs.accessToken;
  final repo = ref.read(authRepositoryProvider);
  final seedLotInfo = await repo.fetchSeedLotById(lotId,token);
  if (seedLotInfo != null) {
    ref.read(seedLotInfoProvider.notifier).state = seedLotInfo;
  }
  return seedLotInfo;
});