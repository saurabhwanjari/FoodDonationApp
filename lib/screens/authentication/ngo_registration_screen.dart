import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:group_button/group_button.dart';
import 'package:donation_app/constants/app_colors.dart';
import 'package:donation_app/services/image_upload.dart';
import 'package:donation_app/widgets/app_button.dart';
import 'package:donation_app/widgets/app_group_button.dart';

import 'package:donation_app/widgets/app_text.dart';
import 'package:donation_app/widgets/app_textfield.dart';

import '../../controllers/authentication/ngo_registration_controller.dart';
import '../../widgets/app_dropdown_button.dart';

class NGORegistrationScreen extends StatelessWidget {
  //
  NGORegistrationController ngoRegistrationController =
      Get.put(NGORegistrationController());

  //
  NGORegistrationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Stack(
          children: [
            //
            Opacity(
              opacity: ngoRegistrationController.isLoading.value ? 0.25 : 1,
              //opacity: 0.25,
              child: Container(
                padding: const EdgeInsets.only(
                    left: 32, right: 32, top: 40, bottom: 32),
                child: SingleChildScrollView(
                  child: Form(
                    key: ngoRegistrationController.ngoregistrationKey,
                    //autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //
                        AppText(
                          'NGO-Head Registration',
                          textType: TextType.extraLarge,
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
                                () => ngoRegistrationController
                                        .imageCaptured.value
                                    ? Container(
                                        child: CircleAvatar(
                                          radius: 70,
                                          backgroundImage: FileImage(
                                              ngoRegistrationController
                                                  .image.value!),
                                        ),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color:
                                                Get.theme.colorScheme.surface,
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
                                            color:
                                                Get.theme.colorScheme.surface,
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
                                  onTap:
                                      ngoRegistrationController.captureOnClick,
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

                        //Name
                        AppTextfield(
                          hintText: 'Enter Your Name',
                          validate: ngoRegistrationController.validateName,
                          onSaved: ngoRegistrationController.saveName,
                          prefixIcon: Icon(Icons.person_outline),
                          textEditingController:
                              ngoRegistrationController.nameController,
                        ),

                        SizedBox(height: 24),

                        //Organization Name
                        AppTextfield(
                          hintText: 'Enter Your Organization Name',
                          validate: ngoRegistrationController
                              .validateOrganizationName,
                          onSaved:
                              ngoRegistrationController.saveOrganizationName,
                          prefixIcon: Icon(
                            Icons.people_outline,
                          ),
                          textEditingController: ngoRegistrationController
                              .organizationNameController,
                        ),

                        //Number of people in your organization
                        SizedBox(height: 24),

                        //
                        AppTextfield(
                          hintText: 'People in Organization',
                          validate: ngoRegistrationController
                              .validatePeopleInOrganization,
                          onSaved: ngoRegistrationController
                              .savePeopleInOrganization,
                          keyboardType: TextInputType.number,
                          prefixIcon: Icon(
                            Icons.people_outline,
                          ),
                          textEditingController: ngoRegistrationController
                              .peopleInOrganizationController,
                        ),

                        //
                        SizedBox(height: 24),

                        //NGO Certification Number
                        AppTextfield(
                          hintText: 'Enter NGO Certification Number',
                          keyboardType: TextInputType.number,
                          validate: ngoRegistrationController
                              .validateNgoCertificationNumber,
                          onSaved: ngoRegistrationController
                              .saveNgoCertificationNumber,
                          prefixIcon: Icon(
                            Icons.verified_outlined,
                          ),
                          textEditingController: ngoRegistrationController
                              .certificationNumberController,
                        ),

                        //
                        SizedBox(height: 24),

                        //Number of campaigns done by the NGO
                        AppTextfield(
                          hintText: 'Enter Campaigns done',
                          validate: ngoRegistrationController.validateCampaigns,
                          onSaved: ngoRegistrationController.saveCampaigns,
                          keyboardType: TextInputType.number,
                          prefixIcon: Icon(
                            Icons.campaign,
                          ),
                          textEditingController:
                              ngoRegistrationController.campaignController,
                        ),

                        //
                        SizedBox(height: 24),

                        //Number of events done by the NGO
                        AppTextfield(
                          hintText: 'Enter Events done',
                          validate: ngoRegistrationController.validateEvents,
                          onSaved: ngoRegistrationController.saveEvents,
                          keyboardType: TextInputType.number,
                          prefixIcon: Icon(Icons.event_available),
                          textEditingController:
                              ngoRegistrationController.eventController,
                        ),

                        SizedBox(height: 24),

                        //
                        AppText(
                          'Address',
                          isBold: true,
                        ),

                        //
                        SizedBox(height: 8),

                        //Address
                        AppTextfield(
                          hintText: 'Enter Your Address',
                          validate: ngoRegistrationController.validateAddress,
                          onSaved: ngoRegistrationController.saveAddress,
                          prefixIcon: Icon(Icons.location_on),
                          textEditingController:
                              ngoRegistrationController.addressController,
                        ),

                        SizedBox(height: 24),

                        //City
                        AppDropDownButton(
                          items: ngoRegistrationController.city,
                          onChanged: ngoRegistrationController.onCityChanged,
                          selectedValue: ngoRegistrationController.cities.value,
                          hintText: 'Select Your City',
                          //icon: Icons.keyboard_arrow_down_outlined,
                        ),

                        // //Current Location
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
                        //         ngoRegistrationController.getLocation();
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
                        //             'LatLng     : ${ngoRegistrationController.latitude.value}')),
                        //         Obx(() => Text(
                        //             'Longitude    :  ${ngoRegistrationController.longitude.value}')),
                        //       ]),
                        // ),

                        //
                        SizedBox(height: 24),

                        AppText(
                          'Select your gender',
                          isBold: true,
                          isLightShade: true,
                        ),

                        //
                        SizedBox(height: 6),

                        //Gender
                        AppGroupButtons(
                          items: ngoRegistrationController.genderList,
                          fontSize: 14,
                          selectedButtonIndex:
                              ngoRegistrationController.selectedIndexforGender,
                          onSelected:
                              ngoRegistrationController.onGenderSelected,
                        ),

                        SizedBox(height: 18),

                        // //
                        // AppText(
                        //   'Can you get food from supplier?',
                        //   isLightShade: true,
                        //   isBold: true,
                        // ),

                        // SizedBox(height: 4),

                        // //
                        // Container(
                        //   alignment: Alignment.topLeft,
                        //   child: AppGroupButtons(
                        //     fontSize: 14,
                        //     selectedButtonIndex:
                        //         ngoRegistrationController.selectedIndexforgetFoodFromSupplier,
                        //     items: ngoRegistrationController
                        //         .getFoodFromSupplierList,
                        //     onSelected: ngoRegistrationController
                        //         .onGetFoodFromSupplierSelected,
                        //   ),
                        // ),

                        // SizedBox(height: 16),
                        AppText(
                          'Description',
                          isLightShade: true,
                          isBold: true,
                        ),

                        const SizedBox(height: 6),

                        //Organization Description
                        AppTextfield(
                          hintText: 'Organization Description ',
                          validate:
                              ngoRegistrationController.validateDescription,
                          onSaved: ngoRegistrationController.saveDescription,
                          minLines: 3,
                          maxLines: 3,
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.sentences,
                          //prefixIcon: Icon(Icons.description_outlined),
                          textEditingController:
                              ngoRegistrationController.descriptionController,
                        ),

                        //
                        SizedBox(height: 18),

                        //
                        AppButton(
                          text: 'Register',
                          textStyle: TextStyle(fontWeight: FontWeight.bold),
                          onPressed: ngoRegistrationController.saveUserData,
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
                child: ngoRegistrationController.isLoading.value
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
