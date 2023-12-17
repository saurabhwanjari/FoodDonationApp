import 'package:flutter/material.dart';
import 'package:donation_app/widgets/app_text.dart';

class TestPage extends StatelessWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppText('Test Page'),
      ),
    );
  }
}