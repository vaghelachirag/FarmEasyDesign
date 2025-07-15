import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TopHeaderHomePage extends StatelessWidget {
  final String title;
  final String date;
  final String assetPath;

  const TopHeaderHomePage({
    super.key,
    required this.title,
    required this.date,
    required this.assetPath
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery
        .of(context)
        .size
        .width;
    return Row(
      children: [
        SvgPicture.asset(
          assetPath,
          width: width * 0.08,
          fit: BoxFit.contain,
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: width * 0.035,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            Text(
              'Last Updated on $date',
              style: TextStyle(
                fontSize: width * 0.028,
                color: Colors.grey[600],
              ),
            )
          ],
        )
      ],
    );
  }
}
