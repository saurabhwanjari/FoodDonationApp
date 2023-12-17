import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donation_app/controllers/authentication/ngo_registration_controller.dart';
import 'package:donation_app/controllers/ngo_controllers/edit_ngo_controller.dart';
import 'package:donation_app/controllers/ngo_controllers/ngo_data_controller.dart';
import 'package:donation_app/widgets/app_button.dart';
import 'package:donation_app/widgets/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../../models/ngo_head.dart';
import '../../../widgets/app_text.dart';

class EditNGOProfile extends StatelessWidget {
  //

  EditNGOProfile({Key? key}) : super(key: key);

  final EditNGOController editNGOController = Get.put(EditNGOController());
  NGODataController ngoDataController = Get.find<NGODataController>();

  @override
  Widget build(BuildContext context) {
    editNGOController.initializeData();
    NGODataController ngoDataController = Get.find<NGODataController>();

    //
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Get.theme.colorScheme.primary,
          size: 34,
        ),
        title: Container(
          padding: EdgeInsets.only(top: 8),
          child:
              //shows name of organization on the appbar
              AppText(
            'Edit Profile',
            textType: TextType.large,
            isBold: true,
            textColor: Get.theme.colorScheme.primary,
          ),
        ),
        elevation: 0,
        backgroundColor: Get.theme.colorScheme.background,
      ),

      //body
      body: Obx(
        () => Stack(
          children: [
            SingleChildScrollView(
              child: Opacity(
                opacity: editNGOController.isLoading.value ? 0.25 : 1,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Form(
                    key: editNGOController.registrationKey,
                    //
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        //
                        Stack(
                          children: [
                            Obx(
                              () => editNGOController.imageCaptured.value
                                  ? Obx(
                                      () => Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color:
                                                Get.theme.colorScheme.primary,
                                            width: 1,
                                          ),
                                        ),
                                        child: CircleAvatar(
                                          radius: 70,
                                          backgroundImage: FileImage(
                                              editNGOController.image.value!),
                                        ),
                                      ),
                                    )
                                  : Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Get.theme.colorScheme.primary,
                                          width: 1,
                                        ),
                                      ),
                                      child: CircleAvatar(
                                        radius: 70,
                                        backgroundImage: NetworkImage(
                                            ngoDataController.rxNGOHead.value
                                                .profilePicture),
                                      ),
                                    ),
                            ),

                            //
                            Positioned(
                              right: 5,
                              bottom: 5,
                              child: InkWell(
                                onTap: editNGOController.captureOnCick,
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
                                    ),
                                  ),
                                ),
                              ),

                              //
                            ),
                          ],
                        ),

                        SizedBox(height: 16),

                        //name
                        AppTextfield(
                          hintText: 'Name',
                          validate: editNGOController.validateName,
                          onSaved: editNGOController.saveName,
                          textEditingController:
                              editNGOController.ngoNameController,
                          prefixIcon: Icon(Icons.person_outline),
                        ),

                        SizedBox(height: 16),

                        //organization name
                        AppTextfield(
                          hintText: 'Organization Name',
                          validate: editNGOController.validateOrganizationName,
                          onSaved: editNGOController.saveorganizationName,
                          textEditingController:
                              editNGOController.organizationNameController,
                          prefixIcon: Icon(Icons.people_outline),
                        ),

                        SizedBox(height: 16),

                        //address
                        AppTextfield(
                          hintText: 'Address',
                          validate: editNGOController.validateAddress,
                          onSaved: editNGOController.saveAddress,
                          textEditingController:
                              editNGOController.addressController,
                          prefixIcon: Icon(Icons.location_on),
                        ),

                        SizedBox(height: 16),

                        //People In Organization
                        AppTextfield(
                          hintText: 'People In Organization',
                          validate:
                              editNGOController.validatePeopleInOrganization,
                          onSaved: editNGOController.savePeopleInOrganization,
                          textEditingController:
                              editNGOController.peopleInOrganizationController,
                          prefixIcon: Icon(Icons.people_outline),
                        ),

                        SizedBox(height: 16),

                        //Campaigns Done
                        AppTextfield(
                          hintText: 'Campaigns Done',
                          validate: editNGOController.validateCampaigns,
                          onSaved: editNGOController.saveCampaigns,
                          textEditingController:
                              editNGOController.campaignsController,
                          prefixIcon: Icon(Icons.campaign),
                        ),

                        SizedBox(height: 16),

                        //Events Done
                        AppTextfield(
                          hintText: 'Events Done',
                          validate: editNGOController.validateEvents,
                          onSaved: editNGOController.saveEvents,
                          textEditingController:
                              editNGOController.eventsController,
                          prefixIcon: Icon(Icons.event_available),
                        ),

                        SizedBox(height: 16),

                        AppButton(
                          text: 'Save Changes',
                          onPressed: () async {
                            editNGOController.updateNGOProfile();
                          },
                          textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            //
            Center(
              child: editNGOController.isLoading.value
                  ? SpinKitCircle(
                      color: Get.theme.colorScheme.primary,
                      size: 50,
                    )
                  : Container(),
            )
          ],
        ),
      ),
    );
  }
}
