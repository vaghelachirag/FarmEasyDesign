import 'package:farmeasy/base/services/preferences/preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final preferenceServiceProvider = Provider((ref) => PreferenceService.instance);
