import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../generated/l10n.dart';
import 'custom_input_drop_down.dart';

final selectedIssueProvider = StateProvider<String?>((ref) => null);

class CustomInputDropDownSelection extends ConsumerWidget {
  final List<String> issues;

  const CustomInputDropDownSelection({super.key, required this.issues});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIssue = ref.watch(selectedIssueProvider);

    return CustomDropdownField(
      title: S.of(context).issue,
      hintText: S.of(context).selectIssue,
      items: issues,
      selectedValue: selectedIssue,
      onChanged: (value) {
        ref.read(selectedIssueProvider.notifier).state = value;
      },
    );
  }
}
