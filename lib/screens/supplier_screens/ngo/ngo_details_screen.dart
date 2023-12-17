import 'package:donation_app/widgets/app_divider.dart';
import 'package:donation_app/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

import '../../../models/ngo_head.dart';

class NGODetailsScreen extends StatelessWidget {
  final NGOHead ngoHead;
  NGODetailsScreen({required this.ngoHead, Key? key}) : super(key: key);

  //NGODataController ngoDataController = Get.find<NGODataController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appbar
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Get.theme.colorScheme.primary,
          size: 34,
        ),
        title: Container(
          padding: EdgeInsets.only(top: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //shows name of organization on the appbar
              AppText(
                '${ngoHead.organizationName}',
                textType: TextType.large,
                isBold: true,
                textColor: Get.theme.colorScheme.primary,
              ),
            ],
          ),
        ),
        elevation: 0,
        backgroundColor: Get.theme.colorScheme.background,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 30.0, right: 8, left: 8),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                //crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Get.theme.colorScheme.primary,
                          width: 1,
                        )),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                          //'images/profile2.jpg'
                          ngoHead.profilePicture),
                      radius: 70,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: AppText(
                      //'Prerna Foundation',
                      ngoHead.organizationName,
                      isBold: true,
                      textType: TextType.large,
                      //textColor: Get.theme.colorScheme.primary,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppText(
                  //'NGO for educating &  helping women in Nagpur region urban & ruler.',
                  ngoHead.description,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 24),
              Container(
                width: Get.width * 0.85,
                height: 2,
                color: Get.theme.colorScheme.primary,
              ),
              //
              SizedBox(height: 20),

              //
              Padding(
                padding: const EdgeInsets.only(left: 24, right: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //
                    Column(
                      children: [
                        //
                        Icon(
                          Icons.people_outline,
                          color: Get.theme.colorScheme.primary,
                        ),
                        SizedBox(height: 8),
                        AppText('People'),
                        AppText(
                          //'(20)',
                          '(${ngoHead.peopleInOrganization})',
                          isBold: true,
                        )
                      ],
                    ),

                    //
                    Column(
                      children: [
                        //
                        Icon(
                          Icons.campaign,
                          color: Get.theme.colorScheme.primary,
                        ),
                        SizedBox(height: 8),
                        AppText('Campaigns'),
                        AppText(
                          //'(20)',
                          '(${ngoHead.campaignsDone})',
                          isBold: true,
                        )
                      ],
                    ),

                    //
                    Column(
                      children: [
                        //
                        Icon(
                          Icons.event_available,
                          color: Get.theme.colorScheme.primary,
                        ),
                        SizedBox(height: 8),
                        AppText('Events'),
                        AppText(
                          //'(20)',
                          '(${ngoHead.eventsDone})',
                          isBold: true,
                        )
                      ],
                    ),
                  ],
                ),
              ),

              //
              SizedBox(height: 20),

              //
              Container(
                width: Get.width * 0.85,
                height: 2,
                color: Get.theme.colorScheme.primary,
              ),

              //
              SizedBox(height: 20),

              //
              Padding(
                padding:
                    EdgeInsets.only(top: 12, bottom: 8, left: 16, right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.location_on,
                      color: Get.theme.colorScheme.primary,
                    ),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          '(NGO Address)',
                          size: 12,
                          isLightShade: true,
                        ),
                        AppText(
                          //'Pune Road, near FS school, Nagpur'
                          ngoHead.address,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              //AppDivider(text: '(NGO Address)'),
              SizedBox(height: 20),
              InkWell(
                onTap: () async {
                  try {
                    UrlLauncher.launch('tel://${ngoHead.mobileNumber}');
                  } catch (error) {
                    print(error);
                  }
                },
                child: Padding(
                  padding:
                      EdgeInsets.only(top: 12, bottom: 8, left: 16, right: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.phone,
                        color: Get.theme.colorScheme.primary,
                      ),
                      SizedBox(width: 16),

                      //field to be modified later after adding mobile number
                      //AppText('788906549')
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            '(NGO Phone Number)',
                            size: 12,
                            isLightShade: true,
                          ),
                          AppText(ngoHead.mobileNumber),
                          // InkWell(
                          //   onTap: () async {
                          //   try {
                          //     final Uri url =
                          //         Uri.parse('tel://${ngoHead.mobileNumber}');
                          //     UrlLauncher.launchUrl(url);
                          //   } catch (error) {
                          //     print(error);
                          //   }
                          // })
                        ],
                      )
                    ],
                  ),
                ),
              ),
              //AppDivider(text: '(NGO Phone Number)'),
              SizedBox(height: 20),
              Padding(
                padding:
                    EdgeInsets.only(top: 12, bottom: 8, left: 16, right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.location_city,
                      color: Get.theme.colorScheme.primary,
                    ),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          '(City Name)',
                          size: 12,
                          isLightShade: true,
                        ),
                        AppText(
                          //'Nagpur'
                          ngoHead.cityName,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              //AppDivider(text: '(City Name)'),
            ],
          ),
        ),
      ),
    );
  }
}
