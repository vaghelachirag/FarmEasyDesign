import 'package:farmeasy/base/extensions/buildcontext_ext.dart';
import 'package:farmeasy/base/utils/app_colors.dart';
import 'package:farmeasy/base/utils/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../generator/assets.gen.dart';
import '../../screens/seedingProcess/seedingTrays/addPersonDetail/provider/add_person_detail_screen.dart';

class CustomSeedLotInputField extends HookConsumerWidget {
  final String title;
  final VoidCallback onScanPressed;
  final VoidCallback onRemovePressed;

  const CustomSeedLotInputField({
    super.key,
    required this.title,
    required this.onScanPressed,
    required this.onRemovePressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lotCodes = ref.watch(seedLotListProvider);
    const int maxVisible = 1;
    final visibleChips = lotCodes.take(maxVisible).toList();
    final hiddenCount = lotCodes.length - maxVisible;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        4.verticalSpace,
        Container(
          decoration:
          BoxDecoration(
            border: Border.all(color: AppColors.darkGray),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          child: Row(
            children: [
              Expanded(
                child: Wrap(
                  spacing: 2,
                  runSpacing: 2,
                  children: [
                    ...visibleChips.map(
                          (lot) => Chip(
                        label: labelTextRegular(lot, 10.sp, AppColors.white),
                        backgroundColor: const Color(0xFF5D7E57), // green shade
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        visualDensity: VisualDensity.compact,
                      ),
                    ),
                    if (hiddenCount > 0)
                      ActionChip(
                        label: labelTextRegular("+$hiddenCount more", 10.sp, AppColors.white),
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (_) => Padding(
                              padding: const EdgeInsets.all(16),
                              child: ListView(
                                children: lotCodes
                                    .map((lot) => Chip(
                                  label: Text(lot),
                                  onDeleted: () {
                                    ref.read(seedLotListProvider.notifier).update((state) =>
                                    List.from(state)..remove(lot));
                                  },
                                ))
                                    .toList(),
                              ),
                            ),
                          );
                        },
                        backgroundColor: const Color(0xFF5D7E57),
                        labelStyle: const TextStyle(color: Colors.white),
                        visualDensity: VisualDensity.compact,
                      ),
                  ],
                ),
              ),
              suffixScanNow(context)
            ],
          ),
        ),
        const SizedBox(height: 4),
        Align(
          alignment: Alignment.topRight,
          child:  GestureDetector(
            onTap: onRemovePressed,
            child: Text(
              "Remove a Lot code?",
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey.shade700,
                decoration: TextDecoration.underline,
              ),
            ),
          ) ,
        ),
      ],
    );
  }
}

// Scan Now Suffix
Widget suffixScanNow(BuildContext context){
  return Padding(
    padding: const EdgeInsets.only(right: 0),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(Assets.icons.iconScanNow.path),
        const SizedBox(width: 4),
        Text(
          context.l10n.scanNow,
          style: context.textTheme.labelMedium?.copyWith(
              color: AppColors.scanNowTextBg
          ),
        ),
      ],
    ),
  );
}
