import 'package:farmeasy/model/seeds/getSeedLotListResponse/get_seed_lot_response.dart';
import 'package:farmeasy/model/seeds/get_seeds_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../../base/services/preferences/preferences.dart';
import '../../../../../model/seeds/getSeedListRespnse/get_seed_list_response.dart';
import '../../../../../network/authRepositoryProvider.dart';




final allPeopleProvider = Provider<List<Map<String, String>>>((ref) => [
  {'name': 'Naved O', 'role': 'Farm Worker', 'image': 'https://randomuser.me/api/portraits/men/1.jpg'},
  {'name': 'Navin A', 'role': 'Farm Worker', 'image': 'https://randomuser.me/api/portraits/men/2.jpg'},
  {'name': 'Navya K', 'role': 'Farm Worker', 'image': 'https://randomuser.me/api/portraits/women/3.jpg'},
  {'name': 'John D', 'role': 'Manager', 'image': 'https://randomuser.me/api/portraits/men/4.jpg'},
]);

final peopleSearchTextProvider = StateProvider<String>((ref) => '');

final filteredPeopleProvider = Provider<List<Map<String, String>>>((ref) {
  final allPeople = ref.watch(allPeopleProvider);
  final searchText = ref.watch(peopleSearchTextProvider).toLowerCase();

  if (searchText.isEmpty) return [];

  return allPeople.where((person) {
    return person['name']!.toLowerCase().contains(searchText);
  }).toList();
});

final selectedPeopleProvider = StateProvider<List<Map<String, String>>>((ref) => []);


final seedLotListProvider = StateProvider<List<GetSeedLotData>>((ref) => []);


final scannedSeedLotsProvider = StateProvider<List<GetSeedLotData>>((ref) => []);


/*
final fetchSeedsProvider = FutureProvider.autoDispose<List<GetSeedListResponse>>((ref) async {
  final prefs = PreferenceService.instance;
  final token = await prefs.accessToken;
  final repo = ref.read(authRepositoryProvider);
  final seeds = await repo.fetchSeeds(token);
  ref.read(seedLotListProvider.notifier).state = seeds;
  return seeds;
});
*/


final fetchSeedsLotProvider = FutureProvider.autoDispose<List<GetSeedLotData>>((ref) async {
  final prefs = PreferenceService.instance;
  final token = await prefs.accessToken;
  final repo = ref.read(authRepositoryProvider);
  final seeds = await repo.fetchSeedsLot(token);
  ref.read(seedLotListProvider.notifier).state = seeds;
  return seeds;
});

GetSeedLotData? findSeedById(List<GetSeedLotData> seeds, String seedLotId) {
  try {
    return seeds.firstWhere((seed) => seed.id == seedLotId);
  } catch (e) {
    return null;
  }
}