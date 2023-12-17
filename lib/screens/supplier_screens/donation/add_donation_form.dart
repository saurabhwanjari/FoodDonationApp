import 'package:donation_app/widgets/app_dropdown_button.dart';
import 'package:donation_app/widgets/app_slider.dart';
import 'package:donation_app/widgets/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:donation_app/models/donation.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:donation_app/widgets/app_button.dart';
import 'package:donation_app/widgets/app_group_button.dart';
import 'package:donation_app/widgets/app_text.dart';
import 'package:donation_app/controllers/supplier_controllers/donate_food_controller.dart';

import '../../../widgets/alert_dialog_box.dart';

class AddDonationForm extends StatelessWidget {
  //
  final Donation? donation;

  //
  var s = ''.obs;
  //
  AddDonationForm({Key? key, this.donation}) : super(key: key);

  //
  final DonateFoodController donateFoodController =
      Get.put(DonateFoodController());

  //
  @override
  Widget build(BuildContext context) {
    //donateFoodController.timeController.text = donation!.mealExpiryTime;
    //
    donateFoodController.eraseData();
    if (donation != null) {
      donateFoodController.initFoodData(donation!);
      print('food');
    }
    return Scaffold(
      //
      appBar: donation == null
          ? AppBar(
              iconTheme: IconThemeData(
                color: Get.theme.colorScheme.primary,
              ),
              title: AppText(
                'Donate Food',
                textColor: Get.theme.colorScheme.primary,
                isBold: true,
                textType: TextType.large,
              ),
              backgroundColor: Get.theme.colorScheme.onPrimary,
              elevation: 0,
            )
          : AppBar(
              iconTheme: IconThemeData(
                color: Get.theme.colorScheme.primary,
              ),
              title: AppText(
                'Edit Food',
                textColor: Get.theme.colorScheme.primary,
                isBold: true,
                textType: TextType.large,
              ),
              backgroundColor: Get.theme.colorScheme.onPrimary,
              elevation: 0,
              //
              actions: [
                IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialogBox(
                              title: 'Attention!',
                              content: 'Are you sure to delete the donation?',
                              yesonPressed: () {
                                donateFoodController.deleteDonation(donation!);
                                Get.back();
                              },
                              noonPressed: () {
                                Get.back();
                              },
                            );
                          });
                    }),
              ],
            ),

      //
      body: Obx(
        () => Stack(
          children: [
            Opacity(
              opacity: donateFoodController.isLoading.value ? 0.25 : 1,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: donateFoodController.donateFoodregistrationKey,
                  //autovalidateMode: AutovalidateMode.always,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //
                      AppText(
                        'Meal Name ',
                        isBold: true,
                      ),

                      //
                      SizedBox(height: 6),

                      //
                      AppTextfield(
                        hintText: 'Enter Meal Name',
                        validate: donateFoodController.validateFoodName,
                        onSaved: donateFoodController.saveFoodName,
                        textEditingController:
                            donateFoodController.mealNameController,
                        prefixIcon: Icon(Icons.restaurant_outlined),
                      ),
                      //
                      SizedBox(height: 24),

                      //
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppText(
                            'Meal Image ',
                            isBold: true,
                          ),
                          InkWell(
                            onTap: () {
                              donateFoodController.captureOnCick();
                            },
                            child: Container(
                              height: 30,
                              width: 30,
                              child: Icon(
                                Icons.camera_alt_outlined,
                                color: Get.theme.colorScheme.primary,
                                size: 22,
                              ),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Get.theme.colorScheme.surface,
                                border: Border.all(
                                  color: Get.theme.colorScheme.primary,
                                  width: 1,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      //
                      const SizedBox(height: 6),

                      //
                      Obx(
                        () => Stack(
                          children: [
                            //
                            Container(
                              width: Get.width,
                              height: 240,
                              child: donateFoodController.imageCaptured.value
                                  ? Image.file(
                                      donateFoodController.image.value!,
                                      fit: BoxFit.cover,
                                    )
                                  : donation != null
                                      ? donation!.foodImage == ''
                                          ? Container(
                                              padding: const EdgeInsets.all(2),
                                              margin: EdgeInsets.all(16),
                                              //
                                              child: Image.asset(
                                                'images/thali3.png',
                                                fit: BoxFit.fill,
                                              ),
                                              //
                                              decoration: BoxDecoration(
                                                //
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                                //
                                                border: Border.all(
                                                  color: Get
                                                      .theme.colorScheme.primary
                                                      .withOpacity(0.8),
                                                  width: 0.1,
                                                ),
                                              ),
                                            )
                                          : Image.network(
                                              donation!.foodImage,
                                              fit: BoxFit.fill,
                                            )
                                      : Image.asset(
                                          'images/thali3.png',
                                          fit: BoxFit.fill,
                                        ),
                              decoration: BoxDecoration(
                                //
                                //color: Get.theme.colorScheme.surface,
                                //
                                borderRadius: BorderRadius.circular(8),
                                //
                                border: Border.all(
                                  color: Get.theme.colorScheme.primary
                                      .withOpacity(0.8),
                                  width: 1,
                                ),
                              ),
                            ),

                            //
                            //
                            // Positioned(
                            //   right: 5,
                            //   bottom: 5,
                            //   child: InkWell(
                            //     onTap: donateFoodController.captureOnCick,
                            //     child: Container(
                            //       padding: const EdgeInsets.all(6),
                            //       child: Icon(
                            //         Icons.camera_alt_outlined,
                            //         color: Get.theme.colorScheme.primary,
                            //         size: 20,
                            //       ),

                            //       //
                            //       decoration: BoxDecoration(
                            //           shape: BoxShape.circle,
                            //           color: Get.theme.colorScheme.surface,
                            //           border: Border.all(
                            //             color: Get.theme.colorScheme.primary,
                            //             width: 1,
                            //           )),
                            //     ),
                            //   ),
                            // ),

                            // delete button for deleting the capturted image
                            donateFoodController.imageCaptured.value
                                ? Positioned(
                                    right: 5,
                                    bottom: 5,
                                    child: InkWell(
                                      onTap: donateFoodController
                                          .deleteCaputedImage,
                                      child: Container(
                                        padding: const EdgeInsets.all(6),
                                        child: Icon(
                                          Icons.delete,
                                          color: Get.theme.colorScheme.error,
                                          size: 20,
                                        ),

                                        //
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color:
                                                Get.theme.colorScheme.surface,
                                            border: Border.all(
                                              color: Get
                                                  .theme.colorScheme.onSurface,
                                              width: 1,
                                            )
                                            // border: Border.all(
                                            //   color: Get.theme.colorScheme.onSurface,
                                            // ),
                                            ),
                                      ),
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                      ),

                      //
                      const SizedBox(height: 32),

                      //
                      AppText(
                        'Meal Type',
                        isBold: true,
                      ),

                      //
                      const SizedBox(height: 4),

                      //
                      AppGroupButtons(
                        items: mealTypes,
                        selectedButtonIndex:
                            donateFoodController.selectedButtonIndex2,
                        onSelected: donateFoodController.onMealTypeChanged,
                        fontSize: 14,
                      ),
                      //
                      const SizedBox(height: 32),

                      //
                      AppText(
                        'Meal Category',
                        isBold: true,
                      ),

                      //
                      const SizedBox(height: 4),

                      //
                      AppGroupButtons(
                        items: mealCategories,
                        selectedButtonIndex:
                            donateFoodController.selectedButtonIndex3,
                        onSelected: donateFoodController.onMealCategoryChanged,
                        fontSize: 14,
                      ),

                      //
                      const SizedBox(height: 32),

                      ////
                      Row(
                        children: [
                          AppText(
                            'Meal Quantity ',
                            isBold: true,
                          ),
                          Text(
                            '(For how many persons)',
                            style: TextStyle(fontSize: 14),
                          )
                        ],
                      ),
                      //
                      const SizedBox(height: 20),

                      //
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [Text('10'), Text('200')],
                        ),
                      ),

                      AppSlider(
                        onChange: donateFoodController.onMealQuantityChanged,
                        value: donateFoodController.mealQuantity.value,
                        divisions: 200,
                        label:
                            '${donateFoodController.mealQuantity.value.toInt()}',
                        //interval: 20,
                        min: 0,
                        max: 200,
                      ),

                      AppText(
                        '  Meal Quantity =  ${donateFoodController.mealQuantity.value.toInt()} Persons',
                        textType: TextType.small,
                      ),

                      //
                      const SizedBox(height: 32),

                      //......................
                      //
                      Row(
                        children: [
                          AppText(
                            'Meal Packaging ',
                            isBold: true,
                          ),
                          Text(
                            '(How will you pack food?)',
                            style: TextStyle(fontSize: 14),
                          )
                        ],
                      ),

                      //
                      const SizedBox(height: 8),

                      //..........
                      // Obx(
                      //   () => AppDropDownButton(
                      //     items: mealPackaging,
                      //     onChanged: donateFoodController.onMenuPackagingChanged,
                      //     selectedValue: donateFoodController.mealPackages.value,
                      //     hintText: 'Select Meal Packaging Type',
                      //     icon: Icons.restaurant,
                      //   ),
                      // ),

                      AppGroupButtons(
                        items: mealPackaging,
                        onSelected: donateFoodController.onMealPackagingChanged,
                        fontSize: 14,
                        selectedButtonIndex:
                            donateFoodController.selectedButtonIndex4,
                      ),

                      const SizedBox(height: 32),

                      //
                      Row(
                        children: [
                          AppText(
                            'Meal Expiry Time ',
                            isBold: true,
                          ),
                          Text(
                            '(In Hours)',
                            style: TextStyle(fontSize: 14),
                          )
                        ],
                      ),
                      //
                      const SizedBox(height: 20),

                      //
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [Text('0 Hours'), Text('10 Hours')],
                        ),
                      ),

                      Obx(
                        () => AppSlider(
                          onChange: donateFoodController.onMealExpiryChanged,
                          value:
                              donateFoodController.mealExpiry.value.toDouble(),
                          divisions: 10,
                          label:
                              '${donateFoodController.mealExpiry.value.toInt()}',
                          //interval: 20,
                          min: 0,
                          max: 10,
                        ),
                      ),

                      // //
                      // Container(
                      //   alignment: Alignment.center,
                      //   height: 60,
                      //   width: MediaQuery.of(context).size.width,
                      //   child: Stack(
                      //     alignment: Alignment.centerRight,
                      //     children: [
                      //       AppTextfield(
                      //         textEditingController:
                      //             donateFoodController.timeController,
                      //         hintText: 'Select Meal Expiry Time',
                      //         prefixIcon: Icon(Icons.cast_for_education),
                      //         // keyBoardType: TextInputType.number,
                      //         // validate: (value) {
                      //         //   appointmentBookingController
                      //         //       .validateTime(value);
                      //         // },
                      //         // onSaved: (value) {
                      //         //   appointmentBookingController
                      //         //       .validateTime(value);
                      //         // },
                      //       ),
                      //       Padding(
                      //         padding: const EdgeInsets.only(right: 5.0),
                      //         child: ClipOval(
                      //           child: Material(
                      //             //color: AppColor.faintBlue, // button color
                      //             child: InkWell(
                      //               // inkwell color
                      //               child: const SizedBox(
                      //                 width: 40,
                      //                 height: 40,
                      //                 child: Icon(
                      //                   Icons.timer_outlined,
                      //                   // color: AppColor.primary,
                      //                 ),
                      //               ),
                      //               onTap: () {
                      //                 donateFoodController.selectTime(context);
                      //               },
                      //             ),
                      //           ),
                      //         ),
                      //       )
                      //     ],
                      //   ),
                      // ),

                      AppText(
                          'Meal Expiry Time =  ${donateFoodController.mealExpiry.value.toInt()} Hours',
                          textType: TextType.small),

                      //
                      const SizedBox(height: 32),

                      Row(
                        children: const [
                          AppText(
                            'Donation Reason ',
                            isBold: true,
                          ),
                          Text(
                            '(Why are you donating food?)',
                            style: TextStyle(fontSize: 14),
                          )
                        ],
                      ),

                      //
                      const SizedBox(height: 4),

                      AppGroupButtons(
                        items: donationReasons,
                        selectedButtonIndex:
                            donateFoodController.selectedButtonIndex1,
                        onSelected:
                            donateFoodController.onDonationReasonChanged,
                        fontSize: 14,
                      ),

                      //
                      //
                      const SizedBox(height: 32),

                      Row(
                        children: const [
                          AppText(
                            'Description ',
                            isBold: true,
                          ),
                          Text(
                            '(Write about your food)',
                            style: TextStyle(fontSize: 14),
                          )
                        ],
                      ),

                      //
                      const SizedBox(height: 8),

                      //
                      AppTextfield(
                        hintText: 'Description about your food',
                        validate: donateFoodController.validateFoodDescription,
                        onSaved: donateFoodController.saveFoodDescription,
                        textEditingController:
                            donateFoodController.descriptionController,
                        prefixIcon: Icon(Icons.description),
                        textCapitalization: TextCapitalization.sentences,
                        maxLines: 3,
                        minLines: 3,
                      ),

                      //
                      const SizedBox(height: 32),

                      //
                      const AppText(
                        'Donation Current Location',
                        isBold: true,
                      ),

                      //
                      const SizedBox(height: 8),

                      //
                      AppTextfield(
                        hintText: 'Enter Donation Address',
                        validate: donateFoodController.validateDonationAddress,
                        onSaved: donateFoodController.saveDonationAddress,
                        textEditingController:
                            donateFoodController.donationAddressController,
                        prefixIcon: Icon(Icons.location_on),
                      ),

                      //
                      const SizedBox(height: 32),

                      //
                      AppDropDownButton(
                          items: donateFoodController.donationCity,
                          onChanged: donateFoodController.onDonationCityChanged,
                          selectedValue:
                              donateFoodController.donationCities.value,
                          hintText: 'Select Donation City',
                          icon: Icons.location_city),

                      //
                      const SizedBox(height: 16),

                      AppText(
                        'Select Donation Location',
                        isLightShade: true,
                        isBold: true,
                      ),

                      const SizedBox(height: 4),

                      AppGroupButtons(
                        items: getLocationsList,
                        onSelected: donateFoodController.onGetLocationChanged,
                        fontSize: 14,
                        selectedButtonIndex:
                            donateFoodController.selectedButtonIndex5,
                      ),

                      //

                      // Container(
                      //   decoration: BoxDecoration(
                      //       border: Border.all(
                      //           color: Get.theme.colorScheme.primary, width: 1),
                      //       borderRadius: BorderRadius.circular(8)),
                      //   height: 52,
                      //   width: double.infinity,
                      //   alignment: Alignment.topLeft,
                      //   padding:
                      //       EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      //   child: Column(
                      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //       crossAxisAlignment: CrossAxisAlignment.stretch,
                      //       children: [
                      //         //AppText('Latitude and Longitude'),
                      //         Obx(() => Text(
                      //             'LatLng     : ${donateFoodController.latitude.value}')),
                      //         Obx(() => Text(
                      //             'Longitude    :  ${donateFoodController.longitude.value}')),
                      //       ]),
                      // ),

                      //
                      const SizedBox(height: 32),

                      //
                      //const SizedBox(height: 4),
                      //
                      AppButton(
                          text: donation != null ? 'Edit Food' : 'Donate Food',
                          textStyle: TextStyle(fontWeight: FontWeight.bold),
                          onPressed: () async {
                            donateFoodController.addNewDonation(
                              isEdit: donation == null ? false : true,
                              oldFoodData: donation,
                            );
                          }),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              child: Center(
                child: donateFoodController.isLoading.value
                    ? SpinKitCircle(
                        color: Get.theme.colorScheme.primary,
                        size: 50,
                      )
                    : Container(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showTime(BuildContext context) async {
    TimeOfDay? t = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (t != null) {
      int h = t.hour;
      int m = t.minute;

      s.value = '$h : $m';
    }
  }
}
