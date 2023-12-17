import 'package:donation_app/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

import '../../../models/supplier.dart';
import '../../../widgets/app_divider.dart';

class SupplierDetailsScreen extends StatelessWidget {
  //
  final Supplier supplier;
  SupplierDetailsScreen({required this.supplier, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: AppText('NGO Details')),
      // appBar: AppBar(
      //   title: AppText(
      //     // ngoDataController.ngoHead.organizationName,
      //     'Supplier Details',
      //     textType: TextType.large,
      //     textColor: Get.theme.colorScheme.primary,
      //     isBold: true,
      //   ),
      //   backgroundColor: Get.theme.colorScheme.background,
      //   elevation: 0,
      //   toolbarHeight: 60,
      // ),
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
                '${supplier.restaurantName}',
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
          padding: const EdgeInsets.only(top: 10.0, right: 8, left: 8),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                //crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Get.theme.colorScheme.primary,
                        )),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                        //'images/profile2.jpg'
                        supplier.profilePicture,
                      ),
                      radius: 70,
                    ),
                  ),
                  AppText(
                    //'Restaurant Grand',
                    supplier.restaurantName,
                    isBold: true,
                    textType: TextType.large,
                    textColor: Get.theme.colorScheme.primary,
                  ),
                ],
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: AppText(
                  //'A good restaurant for both veg and non-veg and helps the people who are hungry by donating the food.',
                  supplier.description,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 24),
              Container(
                width: Get.width * 0.90,
                height: 2,
                color: Get.theme.colorScheme.primary,
              ),
              //
              SizedBox(height: 20),

              //
              Padding(
                padding: const EdgeInsets.only(left: 24, right: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    //

                    Column(
                      children: [
                        //
                        Image.asset(
                          'images/f1.jpg',
                          height: 28,
                          width: 28,
                        ),
                        SizedBox(height: 8),
                        AppText('Meal Type'),
                        AppText(
                          '(${supplier.mealType})',
                          isBold: true,
                        )
                      ],
                    ),

                    //
                    Column(
                      children: [
                        //
                        Icon(
                          Icons.location_city,
                          color: Colors.blue,
                        ),
                        SizedBox(height: 8),
                        AppText('Restaurant City'),
                        AppText(
                          //'(Yes)',
                          '(${supplier.restaurantCity})',
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
                width: Get.width * 0.90,
                height: 2,
                color: Get.theme.colorScheme.primary,
              ),

              //
              SizedBox(height: 20),

              //
              Padding(
                padding:
                    EdgeInsets.only(top: 12, bottom: 8, left: 32, right: 16),
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
                          '(Food Supplier Address)',
                          size: 12,
                          isLightShade: true,
                        ),
                        AppText(
                          //'Pune Road, near FS school, Nagpur'
                          supplier.address,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              //AppDivider(text: '(Food Supplier Address)'),
              SizedBox(height: 8),

              //Phone Number
              InkWell(
                onTap: () async {
                  try {
                    UrlLauncher.launch('tel://${supplier.mobileNumber}');
                  } catch (error) {
                    print(error);
                  }
                },
                child: Padding(
                  padding:
                      EdgeInsets.only(top: 12, bottom: 8, left: 32, right: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.phone,
                        color: Get.theme.colorScheme.primary,
                      ),
                      SizedBox(width: 16),
                      //field to be modidfied later after adding mobile number
                      //AppText('788906549')
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            '(Food Supplier Phone Number)',
                            size: 12,
                            isLightShade: true,
                          ),
                          AppText(supplier.mobileNumber),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              //AppDivider(text: '(Food Supplier Phone Number)'),

              SizedBox(height: 8),

              //Liscense Number
              Padding(
                padding:
                    EdgeInsets.only(top: 12, bottom: 8, left: 32, right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.verified_outlined,
                      color: Get.theme.colorScheme.primary,
                    ),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          '(Restaurant Liscense Number)',
                          size: 12,
                          isLightShade: true,
                        ),
                        AppText(
                          //'89764532178907'
                          supplier.liscenseNumber,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              //AppDivider(text: '(Restaurant Liscense Number)'),
              SizedBox(height: 8),
              Padding(
                padding:
                    EdgeInsets.only(top: 12, bottom: 8, left: 32, right: 16),
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
                          supplier.cityName,
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
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
