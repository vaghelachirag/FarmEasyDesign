// State provider to hold optional HarvestDetail
import 'package:hooks_riverpod/hooks_riverpod.dart';

// true = show card, false = hide card
final isHarvestDueProvider = StateProvider<bool>((ref) => false);