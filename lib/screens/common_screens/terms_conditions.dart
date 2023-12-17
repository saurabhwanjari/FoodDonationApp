import 'package:donation_app/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/app_text.dart';

class TermsConditions extends StatelessWidget {
  const TermsConditions({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Get.theme.colorScheme.primary,
          size: 34,
        ),
        title: Container(
          padding: EdgeInsets.only(top: 8),
          child: AppText(
            'Terms & Conditions',
            textType: TextType.large,
            isBold: true,
            textColor: Get.theme.colorScheme.primary,
          ),
        ),
        elevation: 0,
        backgroundColor: Get.theme.colorScheme.background,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: <Widget>[
                  Image.asset(
                    'images/t&c.png',
                    height: 95,
                    width: 100,
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  const Text(
                    'Terms and conditons \n to be followed',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    //  TextStyle(fontWeight: FontWeight.bold,
                  ),
                ],
              ),

              //
              SizedBox(height: 24),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    border: Border.all(
                  width: 1.5,
                  color: Get.theme.colorScheme.primary,
                  style: BorderStyle.solid,
                )),
                child: AppText(
                  '1. To use the Donation channel service and the features made available through the Application, you are required to complete phone verification and registration process to create an account application.If you don’t want to be bound by this Agreement, please do not access or use the Application.'
                  '\n2. A Termination clause will inform users that any accounts on mobile app, or users access to app, can be terminated in case of abuses or at your sole discretion.'
                  '\n3. It is the user'
                  '\'s responsibility to make sure that all information provided by you is current, accurate, and complete, and that you will maintain the accuracy and completeness of this information going forward.'
                  '\n4. Children under 16 years of age are not eligible to use our Services and we ask that individuals under the age of sixteen (16) do not submit any personal information to us or use the Services. Although visitors of all ages may navigate through the Websites or use our Application, we do not knowingly collect or request personal information from those under the age of sixteen (16) without parental consent. If, following a notification from a parent, guardian or discovery by other means, a child under sixteen has been improperly registered on our site by using false information; we will cancel the child'
                  '\'s account and delete the child'
                  '\'s personal information from our records. Other age restrictions may be set forth in Application Terms of Use from time to time ',
                  textAlign: TextAlign.justify,
                  size: 14,
                ),
              ),

              //
              SizedBox(height: 24),
              //
              AppButton(
                  text: 'OK',
                  onPressed: () {
                    Get.back();
                  },
                  textStyle: TextStyle(fontWeight: FontWeight.bold))
            ],
          ),
        ),
      ),
    );
  }
}
