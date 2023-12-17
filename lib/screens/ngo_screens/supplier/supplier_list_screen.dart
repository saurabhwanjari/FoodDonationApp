import 'package:donation_app/constants/app_colors.dart';
import 'package:donation_app/controllers/ngo_controllers/ngo_data_controller.dart';
import 'package:donation_app/controllers/supplier_controllers/supplier_data_controller.dart';
import 'package:donation_app/models/ngo_head.dart';
import 'package:donation_app/screens/ngo_screens/supplier/supplier_details_screen.dart';
import 'package:donation_app/screens/supplier_screens/ngo/ngo_details_screen.dart';
import 'package:donation_app/services/firestore_services_ngo.dart';
import 'package:donation_app/services/firestore_services_supplier.dart';
import 'package:donation_app/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../models/supplier.dart';

class SupplierListScreen extends StatelessWidget {

  late BuildContext appContext;
  SupplierListScreen({Key? key}) : super(key: key);

  
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

  @override
  Widget build(BuildContext context) {
    appContext = context;
    
    return WillPopScope(
      onWillPop: exitConfirm,
      child: Scaffold(
        appBar: AppBar(
          title: AppText(
            'List of Suppliers',
            size: 20,
            isBold: true,
            textColor: Get.theme.colorScheme.primary,
          ),
          backgroundColor: Get.theme.colorScheme.background,
          elevation: 0,
        ),
        body: StreamBuilder(
            stream: FirestoreServicesSupplier.firebaseFirestore
                .collection(FirestoreServicesSupplier.supplierUsersCollection)
                .where('supplierRole', isEqualTo: 'Restaurant Owner')
                .orderBy('suppliername', descending: false)
                .snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                //if no donation is available
                return NoSupplier();
              }
              if (snapshot.data.docs.length == 0) {
                //print('showing donation');
                return NoSupplier();
              }
              //if no supplier is registered in the app
              // if (!snapshot.hasData) {
              //return NoSupplier();
    
              //if suppliers are available then show the list of Supplier
              return ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  Supplier supplier =
                      Supplier.fromDoucmentSnapshot(snapshot.data.docs[index]);
    
                  //
                  return
                      // child: Card(
                      //   elevation: 0.4,
                      //     shape: RoundedRectangleBorder(
                      //       //borderRadius: BorderRadius.circular(5),
                      //       side: BorderSide(
                      //         color: Get.theme.colorScheme.onSecondary,
                      //         width: 0.4,
                      //       ),
                      //     ),
                      //     margin: EdgeInsets.all(8),
                      //     //color: AppColors.cardColor,
                      //     child: Container(
                      //       //padding: EdgeInsets.only(top: 10, left: 1),
                      //       height: 80,
                      Padding(
                    padding: const EdgeInsets.only(top: 4, bottom: 4),
                    child: ListTile(
                      leading:
                          //maxRadius: 50,
                          Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Get.theme.colorScheme.primary,
                            )),
                        child: CircleAvatar(
                          maxRadius: 25,
                          backgroundImage: NetworkImage(
                            supplier.profilePicture,
                          ),
                        ),
                      ),
                      title: AppText(
                        supplier.suppliername,
                        //isBold: true,
                        //textColor: Get.theme.colorScheme.primary,
                      ),
                      // SizedBox(height: 4),
                      // AppText(
                      //   supplier.description,
                      //   textType: TextType.small,
                      //   isLightShade: true,
                      // ),
                      // const SizedBox(
                      //   height: 8,
                      // )
                      subtitle: Row(
                        children: [
                          AppText(
                            supplier.restaurantName,
                            isBold: true,
                            //textColor: Get.theme.colorScheme.primary,
                          ),
                          SizedBox(width: 8),
                          Icon(
                            Icons.restaurant,
                            size: 16,
                            color: Get.theme.colorScheme.primary,
                          ),
                        ],
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: Get.theme.colorScheme.primary,
                        ),
                        onPressed: () {
                          //Goto Particular NGO Details Screen
                          Get.to(() => SupplierDetailsScreen(supplier: supplier));
                        },
                      ),
    
                      // subtitle: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       //
                      //       Column(
                      //         children: [
                      //           Icon(
                      //             Icons.restaurant,
                      //             size: 20,
                      //             color: Get.theme.colorScheme.primary,
                      //           ),
                      //           SizedBox(
                      //             height: 6,
                      //           ),
                      //           AppText(
                      //             supplier.mealType,
                      //             textType: TextType.small,
                      //           ),
                      //         ],
                      //       ),
    
                      //       Column(
                      //         children: [
                      //           Image.asset(
                      //             'images/f1.jpg',
                      //             height: 20,
                      //             width: 20,
                      //           ),
                      //           SizedBox(
                      //             height: 6,
                      //           ),
                      //           AppText(
                      //             supplier.deliverFoodToNgo,
                      //             textType: TextType.small,
                      //           ),
                      //           SizedBox(
                      //             height: 14,
                      //           ),
                      //         ],
                      //       ),
    
                      //       //
                      //       Column(
                      //         children: [
                      //           Icon(
                      //             Icons.location_on,
                      //             size: 18,
                      //             color: Get.theme.colorScheme.primary,
                      //           ),
                      //           SizedBox(
                      //             height: 6,
                      //           ),
                      //           AppText(
                      //             supplier.restaurantCity,
                      //             textType: TextType.small,
                      //           ),
                      //           SizedBox(height: 4),
                      //           InkWell(
                      //             child: Row(
                      //               mainAxisAlignment:
                      //                   MainAxisAlignment.end,
                      //               //crossAxisAlignment: CrossAxisAlignment.end,
                      //               children: [
                      //                 AppText(
                      //                   'More',
                      //                   textType: TextType.small,
                      //                   isBold: true,
                      //                   textColor:
                      //                       Get.theme.colorScheme.primary,
                      //                 ),
                      //                 SizedBox(width: 4),
                      //                 Icon(
                      //                   Icons.arrow_forward,
                      //                   size: 18,
                      //                   color:
                      //                       Get.theme.colorScheme.primary,
                      //                 )
                      //               ],
                      //             ),
                      //             onTap: () {
                      //               //Goto Particular NGO Details Screen
                      //               Get.to(() => SupplierDetailsScreen(
                      //                   supplier: supplier));
                      //             },
                      //           )
                      //         ],
                      //       ),
                      //     ]),
    
                      // )),
                    ),
                  );
                  // return Card(
                  //   elevation: 0.4,
                  //   margin: EdgeInsets.all(8),
                  //   child: ListTile(
                  //       leading:
                  //           //maxRadius: 50,
                  //           Container(
                  //         decoration: BoxDecoration(
                  //             shape: BoxShape.circle,
                  //             border: Border.all(
                  //               color: Get.theme.colorScheme.primary,
                  //             )),
                  //         child: CircleAvatar(
                  //           maxRadius: 30,
                  //           backgroundImage: NetworkImage(
                  //             supplier.profilePicture,
                  //           ),
                  //         ),
                  //       ),
                  //       title: AppText(
                  //         supplier.suppliername,
                  //         //isBold: true,
                  //         //textColor: Get.theme.colorScheme.primary,
                  //       ),
                  //       subtitle: AppText(
                  //         supplier.restaurantName,
                  //         isBold: true,
                  //         //textColor: Get.theme.colorScheme.primary,
                  //       ),
                  //       trailing: Icon(Icons.arrow_forward_ios_outlined)),
                  // );
                },
              );
            }),
      ),
    );
  }
}

class NoSupplier extends StatelessWidget {
  const NoSupplier({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //no ngo image
        Image.asset(
          'images/people.png',
          color: Get.theme.colorScheme.primary,
          height: 100,
          width: 100,
        ),

        //
        SizedBox(height: 16),

        //no supplier registered
        AppText(
          'No Supplier is registered here!',
          textAlign: TextAlign.center,
        ),
      ],
    ));
  }
}
