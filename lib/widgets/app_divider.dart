import 'package:donation_app/widgets/app_text.dart';
import 'package:flutter/material.dart';

class AppDivider extends StatelessWidget {
  final String text;
  const AppDivider({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 55, right: 8),
      child: Column(
        children: [
          Divider(
            height: 0.5,
            thickness: 1,
          ),
          SizedBox(height: 2),
          Align(
            alignment: Alignment.centerLeft,
            child: AppText(
              text,
              textType: TextType.small,
              isLightShade: true,
            ),
          ),
        ],
      ),
    );
  }
}
