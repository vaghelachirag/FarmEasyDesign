import 'package:farmeasy/base/extensions/buildcontext_ext.dart';
import 'package:farmeasy/components/shimmer_widget.dart';
import 'package:flutter/material.dart';

class LoadingList extends StatelessWidget {
  final double? height;
  const LoadingList({super.key, this.height});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: 10,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: ShimmerWidget(
            height: height ?? (context.height / 13),
            width: context.width,
            borderRadius: 8.0,
          ),
        );
      },
    );
  }
}
