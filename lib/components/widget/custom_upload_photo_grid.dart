import 'package:farmeasy/base/extensions/buildcontext_ext.dart';
import 'package:farmeasy/base/utils/app_colors.dart';
import 'package:farmeasy/generator/assets.gen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../model/model_cycle.dart';

class CustomUploadPhotoGrid extends ConsumerWidget {
   CustomUploadPhotoGrid({super.key});

  List<String?> imagePaths = List.filled(4, null);

  Future<void> _pickImage(int index) async {
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const borderColor = Color(0xFF97C290);
    const iconColor = Color(0xFF82A77C);
    const backgroundColor = Color(0xFFC4E2BF);

    return Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(color: AppColors.infoTextHingBg),
          borderRadius: BorderRadius.circular(12),
        ),
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Upload Photos (minimum 1 Required *)',style: context.textTheme.labelSmall?.copyWith(color: AppColors.infoTextHingBg,fontSize: 12.sp),),
          const SizedBox(height: 8),
          GridView.builder(
            shrinkWrap: true,
            itemCount: 4,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => _pickImage(index),
                child:  SvgPicture.asset(Assets.images.uploadImageBox.path),
              );
            },
          ),
        ],
      )
    );
  }
}