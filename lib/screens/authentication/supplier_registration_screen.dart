//
import 'package:donation_app/screens/current_location.dart';
import 'package:donation_app/services/get_location_services.dart';
import 'package:donation_app/widgets/app_dropdown_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_button/group_button.dart';
import 'package:donation_app/constants/app_colors.dart';
import 'package:donation_app/controllers/authentication/supplier_registration_controller.dart';
import 'package:donation_app/services/image_upload.dart';
import 'package:donation_app/widgets/app_button.dart';
import 'package:donation_app/widgets/app_group_button.dart';

import 'package:donation_app/widgets/app_text.dart';
import 'package:donation_app/widgets/app_textfield.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:donation_app/controllers/authentication/supplier_location_controller.dart';

class SupplierRegistrationScreen extends StatelessWidget {
  //
  //var selectedIndex = 0.obs;
  //
  SupplierRegistrationController supplierRegistrationController =
      Get.put(SupplierRegistrationController());

  LocationController locationController = Get.put(LocationController());
  //
  SupplierRegistrationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Stack(
          children: [
            //
            Opacity(
              opacity:
                  supplierRegistrationController.isLoading.value ? 0.25 : 1,
              //opacity: 0.25,
              child: Container(
                padding: const EdgeInsets.only(
                    left: 32, right: 32, top: 40, bottom: 32),
                child: SingleChildScrollView(
                  child: Form(
                    key: supplierRegistrationController.registrationKey,
                    //autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //
                        AppText(
                          'Food-Supplier Registration',
                          textType: TextType.large,
                          textColor: Get.theme.colorScheme.primary,
                          isBold: true,
                        ),
                  
                        //
                        SizedBox(height: 24),
                        //
                        Container(
                          alignment: Alignment.center,
                          child: Stack(
                            children: [
                              //
                              Obx(
                                () => supplierRegistrationController
                                        .imageCaptured.value
                                    ? Container(
                                        child: CircleAvatar(
                                          radius: 70,
                                          backgroundImage: FileImage(
                                              supplierRegistrationController
                                                  .image.value!),
                                        ),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Get.theme.colorScheme.surface,
                                            border: Border.all(
                                              color:
                                                  Get.theme.colorScheme.primary,
                                              width: 1,
                                            )),
                                      )
                                    : Container(
                                        child: CircleAvatar(
                                          radius: 70,
                                          backgroundColor:
                                              Get.theme.colorScheme.surface,
                                          backgroundImage:
                                              AssetImage('images/user2.png'),
                                        ),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Get.theme.colorScheme.surface,
                                            border: Border.all(
                                              color:
                                                  Get.theme.colorScheme.primary,
                                              width: 1,
                                            )),
                                      ),
                              ),
                  
                              //
                              Positioned(
                                right: 5,
                                bottom: 5,
                                child: InkWell(
                                  onTap: supplierRegistrationController
                                      .captureOnClick,
                                  child: Container(
                                    padding: const EdgeInsets.all(6),
                                    child: Icon(
                                      Icons.camera_alt_outlined,
                                      color: Get.theme.colorScheme.primary,
                                      size: 20,
                                    ),
                  
                                    //
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Get.theme.colorScheme.surface,
                                        border: Border.all(
                                          color: Get.theme.colorScheme.primary,
                                          width: 1,
                                        )),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                  
                        SizedBox(height: 24),
                  
                        //
                        AppText(
                          'Your Information',
                          isBold: true,
                        ),
                  
                        //
                        SizedBox(height: 8),
                  
                        //
                        AppTextfield(
                          hintText: 'Enter Your Name',
                          prefixIcon: Icon(Icons.person_outline),
                          textEditingController:
                              supplierRegistrationController.nameController,
                          validate: supplierRegistrationController.validateName,
                          onSaved: supplierRegistrationController.saveName,
                        ),
                  
                        SizedBox(height: 24),
                  
                        //
                        AppTextfield(
                          hintText: 'Enter Your Address',
                          prefixIcon: Icon(Icons.location_on),
                          textEditingController:
                              supplierRegistrationController.addressController,
                          validate:
                              supplierRegistrationController.validateAddress,
                          onSaved: supplierRegistrationController.saveAddress,
                        ),
                  
                        SizedBox(height: 24),
                  
                        //
                        AppDropDownButton(
                          items: supplierRegistrationController.city,
                          onChanged: supplierRegistrationController.onCityChanged,
                          selectedValue:
                              supplierRegistrationController.cities.value,
                          hintText: 'Select Your City',
                          icon: Icons.location_city,
                        ),
                  
                        SizedBox(height: 24),
                  
                        //
                        AppText(
                          'Who are you?',
                          isBold: true,
                          isLightShade: true,
                        ),
                  
                        SizedBox(height: 4),
                  
                        //
                        Container(
                          alignment: Alignment.topLeft,
                          child: AppGroupButtons(
                            selectedButtonIndex: supplierRegistrationController
                                .selectedIndexForSupplierRoleList,
                            fontSize: 14,
                            items:
                                supplierRegistrationController.supplierRoleList,
                            onSelected: supplierRegistrationController
                                .onSupplierRoleSelected,
                          ),
                        ),
                        //
                        Obx(
                          () => supplierRegistrationController.selectedIndex == 0
                              ? Container()
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 24),
                                    //
                                    AppText(
                                      'Restaurant\'s Information',
                                      isBold: true,
                                    ),
                                    //
                                    SizedBox(height: 8),
                  
                                    //
                                    AppTextfield(
                                      hintText: 'Enter Restaurant Name',
                                      prefixIcon: Icon(Icons.restaurant),
                                      textEditingController:
                                          supplierRegistrationController
                                              .restaurantNameController,
                                      validate: supplierRegistrationController
                                          .validateRestaurantName,
                                      onSaved: supplierRegistrationController
                                          .saveRestaurantName,
                                    ),
                  
                                    SizedBox(height: 24),
                  
                                    //
                                    AppTextfield(
                                      hintText: 'Enter Restaurant Address',
                                      prefixIcon: Icon(Icons.location_on),
                                      textEditingController:
                                          supplierRegistrationController
                                              .restaurantAddressController,
                                      validate: supplierRegistrationController
                                          .validateRestaurantAddress,
                                      onSaved: supplierRegistrationController
                                          .saveRestaurantAddress,
                                    ),
                  
                                    //
                                    SizedBox(height: 24),
                  
                                    //
                                    AppTextfield(
                                      hintText:
                                          'Enter Restaurant\'s Liscense Number',
                                      prefixIcon: Icon(
                                        Icons.verified_outlined,
                                      ),
                                      textEditingController:
                                          supplierRegistrationController
                                              .liscenseController,
                                      keyboardType: TextInputType.number,
                                      validate: supplierRegistrationController
                                          .validateLiscense,
                                      onSaved: supplierRegistrationController
                                          .saveLiscense,
                                    ),
                  
                                    //
                                    SizedBox(height: 24),
                  
                                    AppDropDownButton(
                                        items:
                                            supplierRegistrationController.city,
                                        onChanged: supplierRegistrationController
                                            .onCityChanged,
                                        selectedValue:
                                            supplierRegistrationController
                                                .cities.value,
                                        hintText: 'Select Your City',
                                        icon: Icons.location_city),
                                  ],
                                ),
                        ),
                  
                        //
                        //SizedBox(height: 8),
                  
                        //Getting current location code
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     AppText(
                        //       'Get Location',
                        //       isLightShade: true,
                        //       isBold: true,
                        //     ),
                        //     IconButton(
                        //       onPressed: () {
                        //         //locationController.getLocation();
                        //         //Get.to(() => CurrentLocation());
                        //         supplierRegistrationController.getLocation();
                        //       },
                        //       icon: Icon(
                        //         Icons.location_history,
                        //         color: Get.theme.colorScheme.primary,
                        //         size: 26,
                        //       ),
                        //     )
                        //   ],
                        // ),
                  
                        // //
                  
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
                        //             'LatLng     : ${supplierRegistrationController.latitude.value}')),
                        //         Obx(() => Text(
                        //             'Longitude    :  ${supplierRegistrationController.longitude.value}')),
                        //       ]),
                        // ),
                  
                        //
                  
                        //
                        SizedBox(height: 24),
                  
                        AppText(
                          'Select your gender',
                          isLightShade: true,
                          isBold: true,
                        ),
                  
                        SizedBox(height: 4),
                  
                        //
                        Container(
                          alignment: Alignment.topLeft,
                          child: AppGroupButtons(
                            fontSize: 14,
                            selectedButtonIndex: supplierRegistrationController
                                .selectedIndexForGenderList,
                            items: supplierRegistrationController.genderList,
                            onSelected:
                                supplierRegistrationController.onGenderSelected,
                          ),
                        ),
                  
                        //
                        SizedBox(height: 16),
                  
                        //
                        Row(
                          children: [
                            AppText(
                              'Meal Type',
                              isLightShade: true,
                              isBold: true,
                            ),
                            AppText(
                              ' (Type of meal you cook?)',
                              isLightShade: true,
                              textType: TextType.small,
                            ),
                          ],
                        ),
                  
                        SizedBox(height: 4),
                  
                        //
                        Container(
                          alignment: Alignment.topLeft,
                          child: AppGroupButtons(
                            fontSize: 14,
                            selectedButtonIndex: supplierRegistrationController
                                .selectedIndexForMealType,
                            items: supplierRegistrationController.mealTypeList,
                            onSelected:
                                supplierRegistrationController.onMealTypeSelected,
                          ),
                        ),
                  
                        //
                        SizedBox(height: 16),
                  
                        // //
                        // AppText(
                        //   'Can you donate food to NGO?',
                        //   isLightShade: true,
                        //   isBold: true,
                        // ),
                  
                        // SizedBox(height: 4),
                  
                        //
                        // Container(
                        //   alignment: Alignment.topLeft,
                        //   child: AppGroupButtons(
                        //     fontSize: 14,
                        //     selectedButtonIndex: supplierRegistrationController
                        //         .selectedButtonIndex,
                        //     items: supplierRegistrationController
                        //         .deliverFoodToNgoList,
                        //     onSelected: supplierRegistrationController
                        //         .onDeliverFoodToNgoSelected,
                        //   ),
                        // ),
                  
                        //Fconst SizedBox(height: 16),
                  
                        AppText(
                          'Description',
                          isLightShade: true,
                          isBold: true,
                        ),
                  
                        const SizedBox(height: 6),
                  
                        AppTextfield(
                          hintText: 'Add Description',
                          minLines: 3,
                          maxLines:3,
                          prefixIcon: Icon(Icons.description_outlined),
                          textEditingController: supplierRegistrationController
                              .descriptionController,
                          validate:
                              supplierRegistrationController.validateDescription,
                          onSaved: supplierRegistrationController.saveDescription,
                        ),
                  
                        const SizedBox(height: 32),
                  
                        //
                        AppButton(
                          text: 'Register',
                          textStyle: TextStyle(fontWeight: FontWeight.bold),
                          onPressed: supplierRegistrationController.saveUserData,
                          //isDisabled: !supplierRegistrationController
                          //  .showRegisterButton.value,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            //
            Container(
              child: Center(
                child: supplierRegistrationController.isLoading.value
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
}
