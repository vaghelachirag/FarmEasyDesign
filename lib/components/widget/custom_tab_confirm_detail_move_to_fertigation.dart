import 'package:farmeasy/base/utils/app_colors.dart';
import 'package:farmeasy/components/common/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTabConfirmDetailMoveToFertigation extends StatefulWidget {
  const CustomTabConfirmDetailMoveToFertigation({super.key});

  @override
  _CustomTabConfirmDetailMoveToFertigationState createState() => _CustomTabConfirmDetailMoveToFertigationState();
}

class _CustomTabConfirmDetailMoveToFertigationState extends State<CustomTabConfirmDetailMoveToFertigation> {
  final List<String> tabs = ['Overview', 'Analysis', 'Notes', 'Lifecycle'];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(tabs.length, (index) {
        final isSelected = selectedIndex == index;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.w),
              decoration: BoxDecoration(
                color: isSelected ? Color(0xFF3B364E) : Color(0xFFF4F4ED),
                borderRadius: BorderRadius.circular(8.w),
              ),
              child:
              Text(tabs[index],style: AppTextStyles.robotoBodyLarge.copyWith(fontSize: 12.sp,fontWeight: FontWeight.w500,color:  isSelected ? AppColors.white  : AppColors.blackColor),)
            ),
          ),
        );
      }),
            ));
  }
}
