import 'package:hooks_riverpod/hooks_riverpod.dart';


// Mock People Data
final allPeopleProvider = Provider<List<Map<String, String>>>((ref) => [
  {'name': 'Naved O', 'role': 'Farm Worker', 'image': 'https://randomuser.me/api/portraits/men/1.jpg'},
  {'name': 'Navin A', 'role': 'Farm Worker', 'image': 'https://randomuser.me/api/portraits/men/2.jpg'},
  {'name': 'Navya K', 'role': 'Farm Worker', 'image': 'https://randomuser.me/api/portraits/women/3.jpg'},
  {'name': 'John D', 'role': 'Manager', 'image': 'https://randomuser.me/api/portraits/men/4.jpg'},
]);

// Holds search input text
final peopleSearchTextProvider = StateProvider<String>((ref) => '');

// Filters based on search
final filteredPeopleProvider = Provider<List<Map<String, String>>>((ref) {
  final allPeople = ref.watch(allPeopleProvider);
  final searchText = ref.watch(peopleSearchTextProvider).toLowerCase();

  if (searchText.isEmpty) return [];

  return allPeople.where((person) {
    return person['name']!.toLowerCase().contains(searchText);
  }).toList();
});
