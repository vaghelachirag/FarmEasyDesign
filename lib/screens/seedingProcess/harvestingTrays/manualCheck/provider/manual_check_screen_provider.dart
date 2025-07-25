import 'package:hooks_riverpod/hooks_riverpod.dart';

// Toggle for showing/hiding Bad Tray section
final badTrayProvider = StateProvider<bool>((ref) => false);

// Selected dropdown value for Issue
final selectedIssueProvider = StateProvider<String?>((ref) => "The nutrients were not enough");

// Notes/Remarks text
final notesProvider = StateProvider<String>((ref) => '');