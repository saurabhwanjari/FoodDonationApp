import 'package:donation_app/controllers/supplier_controllers/supplier_data_controller.dart';
import 'package:donation_app/screens/supplier_screens/profile/edit_supplier_profile.dart';
import 'package:donation_app/widgets/app_button.dart';
import 'package:donation_app/widgets/app_divider.dart';
import 'package:donation_app/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SupplierProfile extends StatelessWidget {
  late BuildContext appContext;
  SupplierProfile({Key? key}) : super(key: key);

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
  SupplierDataController supplierDataController =
      Get.find<SupplierDataController>();

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
                    Get.to(() => EditSupplierProfile());
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
                          backgroundImage: NetworkImage(supplierDataController
                              .rxSupplier.value.profilePicture),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    AppText(
                        '${supplierDataController.rxSupplier.value.suppliername}',
                        textAlign: TextAlign.justify,
                        isBold: true,
                        size: 20
                        //textColor: Get.theme.colorScheme.onSurface,
                        ),
                    supplierDataController.supplier.supplierRole ==
                            'Restaurant Owner'
                        ? AppText(
                            '(${supplierDataController.rxSupplier.value.restaurantName})',
                            isBold: true,
                            textColor: Get.theme.colorScheme.primary,
                          )
                        : Container(),
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
                                supplierDataController.rxSupplier.value.address,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    //AppDivider(text: '(Your Address)'),
    
                    SizedBox(height: 16),
    
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
                                supplierDataController
                                    .rxSupplier.value.mobileNumber,
                                //'8765432167',
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    //AppDivider(text: '(Phone Number)'),
                    SizedBox(height: 16),
    
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
                                supplierDataController.rxSupplier.value.cityName,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    //AppDivider(text: '(City Name)'),
                    SizedBox(height: 16),
    
                    //Description
                    Padding(
                      padding: EdgeInsets.only(
                          top: 12, bottom: 8, left: 16, right: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.description_outlined,
                            color: Get.theme.colorScheme.primary,
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText(
                                  '(Description)',
                                  size: 12,
                                  isLightShade: true,
                                ),
                                AppText(
                                  supplierDataController
                                      .rxSupplier.value.description,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    //AppDivider(text: '(Description)'),
                    SizedBox(height: 16),
    
                    //Restaurant Address
                    supplierDataController.supplier.supplierRole ==
                            'Restaurant Owner'
                        ? Padding(
                            padding: EdgeInsets.only(
                                top: 12, bottom: 8, left: 16, right: 16),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.location_city,
                                      color: Get.theme.colorScheme.primary,
                                    ),
                                    SizedBox(width: 16),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        AppText(
                                          '(Restaurant Address)',
                                          size: 12,
                                          isLightShade: true,
                                        ),
                                        AppText(
                                          '${supplierDataController.rxSupplier.value.restaurantAddress}',
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                //AppDivider(text: '(Restaurant Address)'),
                              ],
                            ),
                          )
                        : Container(),
    
                    SizedBox(height: 16),
    
                    //Restaurant Liscense Number
                    supplierDataController.supplier.supplierRole ==
                            'Restaurant Owner'
                        ? Padding(
                            padding: EdgeInsets.only(
                                top: 12, bottom: 8, left: 16, right: 16),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.verified_outlined,
                                      color: Get.theme.colorScheme.primary,
                                    ),
                                    SizedBox(width: 16),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        AppText(
                                          '(Restaurant Liscense Number)',
                                          size: 12,
                                          isLightShade: true,
                                        ),
                                        AppText(
                                          '${supplierDataController.rxSupplier.value.liscenseNumber}',
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                //AppDivider(text: '(Restaurant Liscense Number)'),
                              ],
                            ),
                          )
                        : Container(),
                    SizedBox(height: 16),
    
                    //Edit Profile Button
                    // AppButton(
                    //   text: 'Edit Profile',
                    //   onPressed: () {
                    //     Get.to(() => EditSupplierProfile());
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
