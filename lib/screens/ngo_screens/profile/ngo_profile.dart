import 'package:donation_app/controllers/ngo_controllers/ngo_data_controller.dart';
import 'package:donation_app/screens/ngo_screens/profile/edit_ngo_profile.dart';
import 'package:donation_app/widgets/app_button.dart';
import 'package:donation_app/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/ngo_head.dart';
import '../../../widgets/app_divider.dart';

class NGOProfile extends StatelessWidget {
  late BuildContext appContext;
  NGOProfile({Key? key}) : super(key: key);

  
  //Alert Exit Confirm Function
  Future<bool> exitConfirm() async {
    Future<bool> value = Future.value(false);

    AlertDialog alertDialog = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 0,
      title: AppText(
        'Are your sure to exit?',
        isBold: true,
        textAlign: TextAlign.center,
        size: 20,
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //Yes
            Container(
              width: 100,
              margin: EdgeInsets.symmetric(horizontal: 2, vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border:
                    Border.all(color: Get.theme.colorScheme.primary, width: 1),
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.pop(appContext);
                  value = Future.value(true);
                },
                child: AppText(
                  "Yes",
                  textType: TextType.normal,
                  isBold: true,
                  textColor: Get.theme.colorScheme.primary,
                ),
              ),
            ),

            //No
            Container(
              width: 100,
              margin: EdgeInsets.symmetric(horizontal: 2, vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border:
                    Border.all(color: Get.theme.colorScheme.primary, width: 1),
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.pop(appContext);
                  value = Future.value(false);
                },
                child: AppText(
                  "No",
                  textType: TextType.normal,
                  isBold: true,
                  textColor: Get.theme.colorScheme.primary,
                ),
              ),
            ),
          ],
        )
      ],
    );

    await showDialog(
        context: appContext, builder: (BuildContext context) => alertDialog);

    return value;
  }

  //
  NGODataController ngoDataController = Get.find<NGODataController>();

  @override
  Widget build(BuildContext context) {
    appContext = context;

    return WillPopScope(
      onWillPop: exitConfirm,
      child: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: Get.theme.colorScheme.primary,
              size: 34,
            ),
            title: Container(
              padding: EdgeInsets.only(top: 8),
              child: AppText(
                'Profile',
                textType: TextType.large,
                isBold: true,
                textColor: Get.theme.colorScheme.primary,
              ),
            ),
            elevation: 0,
            backgroundColor: Get.theme.colorScheme.background,
            actions: [
              IconButton(
                  onPressed: () {
                    Get.to(() => EditNGOProfile());
                  },
                  icon: Icon(
                    Icons.edit_outlined,
                    size: 24,
                  ))
            ],
          ),
          body: Padding(
            padding: EdgeInsets.all(20),
            child: Obx(
              () => SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        // height: 100,
                        // width: 100,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            //borderRadius: BorderRadius.circular(10),
    
                            border: Border.all(
                              color: Get.theme.colorScheme.primary,
                            )),
                        child: CircleAvatar(
                          radius: 80,
                          backgroundImage: NetworkImage(
                              ngoDataController.rxNGOHead.value.profilePicture),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    AppText('${ngoDataController.rxNGOHead.value.name}',
                        textAlign: TextAlign.justify, isBold: true, size: 20
                        //textColor: Get.theme.colorScheme.onSurface,
                        ),
                    AppText(
                      '(${ngoDataController.rxNGOHead.value.organizationName})',
                      isBold: true,
                      textColor: Get.theme.colorScheme.primary,
                    ),
                    SizedBox(height: 16),
                    Divider(
                      color: Get.theme.colorScheme.primary,
                      thickness: 1.5,
                    ),
    
                    //
                    SizedBox(height: 8),
    
                    //Address
                    Padding(
                      padding: EdgeInsets.only(
                          top: 12, bottom: 8, left: 16, right: 16),
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
                                '(Your Address)',
                                size: 12,
                                isLightShade: true,
                              ),
                              AppText(
                                //'Pune Road, near FS school, Nagpur'
                                ngoDataController.rxNGOHead.value.address,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    // AppDivider(text: '(Your Address)'),
    
                    SizedBox(height: 8),
    
                    //Phone Number
                    Padding(
                      padding: EdgeInsets.only(
                          top: 12, bottom: 8, left: 16, right: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.phone,
                            color: Get.theme.colorScheme.primary,
                          ),
                          SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText(
                                '(Phone Number)',
                                size: 12,
                                isLightShade: true,
                              ),
                              AppText(
                                //field to be modified later
                                ngoDataController.rxNGOHead.value.mobileNumber,
                                //'8765432167',
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    //AppDivider(text: '(Phone Number)'),
    
                    SizedBox(height: 8),
    
                    //City Name
                    Padding(
                      padding: EdgeInsets.only(
                          top: 12, bottom: 8, left: 16, right: 16),
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
                                ngoDataController.rxNGOHead.value.cityName,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    //AppDivider(text: '(City Name)'),
    
                    SizedBox(height: 8),
    
                    //People in Organization
                    Padding(
                      padding: EdgeInsets.only(
                          top: 12, bottom: 8, left: 16, right: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.people_outline,
                            color: Get.theme.colorScheme.primary,
                          ),
                          SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText(
                                '(People in Organization)',
                                size: 12,
                                isLightShade: true,
                              ),
                              AppText(
                                '${ngoDataController.rxNGOHead.value.peopleInOrganization}',
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    //AppDivider(text: '(People in Organization)'),
    
                    SizedBox(height: 8),
    
                    //Campaigns Done
                    Padding(
                      padding: EdgeInsets.only(
                          top: 12, bottom: 8, left: 16, right: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.campaign,
                            color: Get.theme.colorScheme.primary,
                          ),
                          SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText(
                                '(Campaigns Done)',
                                size: 12,
                                isLightShade: true,
                              ),
                              AppText(
                                '${ngoDataController.rxNGOHead.value.campaignsDone}',
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    //AppDivider(text: '(Campaigns Done)'),
                    SizedBox(height: 8),
    
                    //Events Done
                    Padding(
                      padding: EdgeInsets.only(
                          top: 12, bottom: 8, left: 16, right: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.event_available,
                            color: Get.theme.colorScheme.primary,
                          ),
                          SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText(
                                '(Events Done)',
                                size: 12,
                                isLightShade: true,
                              ),
                              AppText(
                                '${ngoDataController.rxNGOHead.value.eventsDone}',
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    //AppDivider(text: '(Events Done)'),
                    SizedBox(height: 16),
    
                    //Edit Profile Button
                    // AppButton(
                    //   text: 'Edit Profile',
                    //   onPressed: () {
                    //     Get.to(() => EditNGOProfile());
                    //   },
                    //   textStyle: TextStyle(
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    // )
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
