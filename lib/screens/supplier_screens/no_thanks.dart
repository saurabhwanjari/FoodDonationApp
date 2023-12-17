import 'package:flutter/material.dart';

import '../../widgets/app_text.dart';

class NoThanks extends StatelessWidget {
  NoThanks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(child: AppText('Sorry, you have selected NO Thanks')));
  }
}
