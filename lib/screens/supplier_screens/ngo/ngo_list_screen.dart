import 'package:donation_app/constants/app_colors.dart';
import 'package:donation_app/controllers/ngo_controllers/ngo_data_controller.dart';
import 'package:donation_app/models/ngo_head.dart';
import 'package:donation_app/screens/supplier_screens/ngo/ngo_details_screen.dart';
import 'package:donation_app/services/firestore_services_ngo.dart';
import 'package:donation_app/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class NGOListScreen extends StatelessWidget {
  late BuildContext appContext;
  NGOListScreen({Key? key}) : super(key: key);

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
  //NGODataController ngoDataController = Get.put(NGODataController(ngoHead: ngoHead));
  @override
  Widget build(BuildContext context) {
    appContext = context;

    return WillPopScope(
      onWillPop: exitConfirm,
      child: Scaffold(
        appBar: AppBar(
          title: AppText(
            'List of NGO\'s',
            size: 20,
            isBold: true,
            textColor: Get.theme.colorScheme.primary,
          ),
          backgroundColor: Get.theme.colorScheme.background,
          elevation: 0,
        ),
        body: StreamBuilder(
            stream: FirestoreServicesNGO.firebaseFirestore
                .collection(FirestoreServicesNGO.ngoUsersCollection)
                .orderBy('organizationName', descending: false)
                .snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              //if no ngo is registered in the app
              if (!snapshot.hasData) {
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
                    SizedBox(height: 32),

                    //no ngo registered
                    AppText(
                      'No NGO is registered here!',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ));
              }

              //if ngo's are available then show the list of NGO
              return ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  NGOHead ngoHead =
                      NGOHead.fromDoucmentSnapshot(snapshot.data.docs[index]);

                  //
                  return InkWell(
                    child: Card(
                      elevation: 0.4,
                      shape: RoundedRectangleBorder(
                        //borderRadius: BorderRadius.circular(5),
                        side: BorderSide(
                          color: Get.theme.colorScheme.onSecondary,
                          width: 0.4,
                        ),
                      ),
                      margin:
                          EdgeInsets.only(left: 6, right: 6, top: 8, bottom: 8),
                      //color: AppColors.cardColor,

                      // padding: EdgeInsets.only(top: 10, left: 1),
                      // height: 155,
                      child: ListTile(
                        leading:
                            //maxRadius: 50,
                            Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Get.theme.colorScheme.primary,
                                width: 1,
                              )),
                          child: CircleAvatar(
                            maxRadius: 30,
                            backgroundImage: NetworkImage(
                              ngoHead.profilePicture,
                            ),
                          ),
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(height: 2),
                            AppText(
                              ngoHead.organizationName,
                              isBold: true,
                              isLightShade: true,
                              //textColor: Get.theme.colorScheme.primary,
                            ),
                            SizedBox(height: 4),
                            AppText(
                              ngoHead.description,
                              textType: TextType.small,
                              isLightShade: true,
                            ),
                            const SizedBox(
                              height: 8,
                            )
                          ],
                        ),
                        subtitle: Column(
                          children: [
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  //
                                  Column(
                                    children: [
                                      Icon(
                                        Icons.people_outline,
                                        size: 20,
                                        color: Get.theme.colorScheme.primary,
                                      ),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      AppText(
                                        '${ngoHead.peopleInOrganization} People',
                                        textType: TextType.small,
                                      ),
                                    ],
                                  ),

                                  Column(
                                    children: [
                                      Icon(
                                        Icons.event_available,
                                        size: 20,
                                        color: Colors.blue,
                                      ),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      AppText(
                                        ngoHead.eventsDone,
                                        textType: TextType.small,
                                      ),
                                    ],
                                  ),

                                  //
                                  Column(
                                    children: [
                                      Icon(Icons.location_on,
                                          size: 20, color: Colors.lightGreen),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      AppText(
                                        ngoHead.cityName,
                                        textType: TextType.small,
                                      ),
                                    ],
                                  ),
                                ]),
                            SizedBox(height: 6),
                            InkWell(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                //crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  AppText(
                                    'More',
                                    textType: TextType.small,
                                    isBold: true,
                                    textColor: Get.theme.colorScheme.primary,
                                  ),
                                  SizedBox(width: 4),
                                  Icon(
                                    Icons.arrow_forward,
                                    size: 18,
                                    color: Get.theme.colorScheme.primary,
                                  )
                                ],
                              ),
                              onTap: () {
                                //Goto Particular NGO Details Screen
                                Get.to(
                                    () => NGODetailsScreen(ngoHead: ngoHead));
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
      ),
    );
  }
}

//
//..........................................................
//NGO List Card UI Done
// body: Padding(
//   padding: const EdgeInsets.only(top: 100, bottom: 16),
//   child: InkWell(
//     child: Card(
//         color: Colors.white,
//         child: Container(
//           padding: EdgeInsets.only(top: 10, left: 1),
//           height: 120,
//           child: ListTile(
//             leading:
//                 //maxRadius: 50,
//                 CircleAvatar(
//               maxRadius: 30,
//               backgroundImage: AssetImage(
//                 'images/profile2.jpg',
//               ),
//             ),
//             title: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 AppText(
//                   'Prerna Foundation',
//                   isBold: true,
//                 ),
//                 AppText(
//                   'NGO for educating &  helping women in Nagpur region urban & ruler.',
//                   textType: TextType.small,
//                   isLightShade: true,
//                 ),
//                 SizedBox(
//                   height: 8,
//                 )
//               ],
//             ),
//             subtitle: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   //
//                   Column(
//                     children: [
//                       Icon(Icons.people_outline, size: 18),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       AppText(
//                         //'${donation.mealQuantity.toInt()}',
//                         '30',
//                         textType: TextType.small,
//                       ),
//                     ],
//                   ),

//                   //
//                   SizedBox(width: 50),

//                   Column(
//                     children: [
//                       Image.asset(
//                         'images/f1.jpg',
//                         height: 20,
//                         width: 20,
//                       ),
//                       SizedBox(height: 10),
//                       AppText(
//                         'Veg',
//                         textType: TextType.small,
//                       ),
//                     ],
//                   ),

//                   //
//                   SizedBox(width: 50),
//                   //
//                   Column(
//                     children: [
//                       Image.asset(
//                         'images/delivery.png',
//                         height: 20,
//                         width: 20,
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       AppText(
//                         'Yes',
//                         textType: TextType.small,
//                       ),
//                       SizedBox(
//                         height: 14,
//                       ),
//                     ],
//                   ),
//                 ]),
//           ),
//         )),
//     onTap: () {
//       //Goto Particular NGO Details Screen
//     },
//   ),
// ),

//.............................................................................
