import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:farmeasy/base/extensions/buildcontext_ext.dart';
import 'package:farmeasy/base/utils/app_colors.dart';
import 'package:farmeasy/base/utils/common_widgets.dart';
import '../../screens/tab/seeding/addDetail/add_seeding_provider.dart';
import 'custom_input_field.dart';

class CustomAddPeopleSuggestionTextFiled extends ConsumerStatefulWidget {
  const CustomAddPeopleSuggestionTextFiled({super.key});

  @override
  ConsumerState<CustomAddPeopleSuggestionTextFiled> createState() =>
      _CustomAddPeopleSuggestionTextFiledState();
}

class _CustomAddPeopleSuggestionTextFiledState
    extends ConsumerState<CustomAddPeopleSuggestionTextFiled> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      ref.read(peopleSearchTextProvider.notifier).state = _controller.text.trim();
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredPeople = ref.watch(filteredPeopleProvider);
    final searchText = ref.watch(peopleSearchTextProvider);

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          children: [
            CustomTextField(
              controller: _controller,
              title: context.l10n.addPeople,
              hintText: "",
              inputType: TextInputType.name,
              textInputAction: TextInputAction.next,
              validator: (val) => null,
            ),
            8.verticalSpace,
            if (searchText.isNotEmpty)
              Expanded(
                child: ListView.separated(
                  itemCount: filteredPeople.length,
                  separatorBuilder: (_, __) => Divider(
                    color: AppColors.blackColor,
                    thickness: 1,
                    height: 0.5,
                  ),
                  itemBuilder: (context, index) {
                    final person = filteredPeople[index];
                    return listItemContent(person);
                  },
                ),
              )
          ],
        ),
      ),
    );
  }
}

Widget listItemContent(Map<String, String> person) {
  return Container(
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: AppColors.addPeopleSuggestionBg,
      borderRadius: BorderRadius.circular(6),
    ),
    child: Row(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(person['image']!),
          radius: 15.sp,
        ),
        8.horizontalSpace,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            labelTextBold(person['name'], 12.sp, AppColors.addPeopleTextBg),
            labelTextMedium(person['role']!, 10.sp, AppColors.addPeopleTextBg),
          ],
        ),
      ],
    ),
  );
}
