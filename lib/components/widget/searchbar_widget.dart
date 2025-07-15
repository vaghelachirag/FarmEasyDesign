import 'package:farmeasy/base/extensions/buildcontext_ext.dart';
import 'package:farmeasy/base/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchBarWidget extends StatelessWidget {
  final VoidCallback onMenuTap;
  final VoidCallback onSearchTap;

  const SearchBarWidget(BuildContext context, {
    super.key,
    required this.onMenuTap,
    required this.onSearchTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      margin:  EdgeInsets.symmetric(horizontal: 12.sp, vertical: 12.sp),
      padding:  EdgeInsets.symmetric(horizontal: 10.sp),
      decoration: BoxDecoration(
        color: AppColors.searchBarBg, // light background like image
        borderRadius: BorderRadius.circular(20.sp), // full round
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: onMenuTap,
            child: const Icon(Icons.menu, color: Colors.black54),
          ),
          const SizedBox(width: 12),
           Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search or scan for trays',
                border: InputBorder.none,
                hintStyle: context.textTheme.labelSmall,
                isDense: true,
              ),
              style: context.textTheme.labelSmall,
            ),
          ),
          GestureDetector(
            onTap: onSearchTap,
            child: const Icon(Icons.search, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
