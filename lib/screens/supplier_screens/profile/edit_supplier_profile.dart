import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donation_app/controllers/authentication/ngo_registration_controller.dart';
import 'package:donation_app/controllers/ngo_controllers/edit_ngo_controller.dart';
import 'package:donation_app/controllers/ngo_controllers/ngo_data_controller.dart';
import 'package:donation_app/controllers/supplier_controllers/edit_supplier_controller.dart';
import 'package:donation_app/controllers/supplier_controllers/supplier_data_controller.dart';
import 'package:donation_app/widgets/app_button.dart';
import 'package:donation_app/widgets/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../../models/ngo_head.dart';
import '../../../widgets/app_text.dart';

class EditSupplierProfile extends StatelessWidget {
  //

  EditSupplierProfile({Key? key}) : super(key: key);

  final EditSupplierController editSupplierController =
      Get.put(EditSupplierController());
  SupplierDataController supplierDataController =
      Get.find<SupplierDataController>();

  @override
  Widget build(BuildContext context) {
    editSupplierController.initializeData();
    SupplierDataController supplierDataController =
        Get.find<SupplierDataController>();

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
                opacity: editSupplierController.isLoading.value ? 0.25 : 1,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Form(
                    key: editSupplierController.registrationKey,
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
                              () => editSupplierController.imageCaptured.value
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
                                          radius: 80,
                                          backgroundImage: FileImage(
                                              editSupplierController
                                                  .image.value!),
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
                                        radius: 80,
                                        backgroundImage: NetworkImage(
                                            supplierDataController.rxSupplier
                                                .value.profilePicture),
                                      ),
                                    ),
                            ),

                            //
                            Positioned(
                              right: 5,
                              bottom: 5,
                              child: InkWell(
                                onTap: editSupplierController.captureOnCick,
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
                          hintText: 'Your Name',
                          validate: editSupplierController.validateSupplierName,
                          onSaved: editSupplierController.saveName,
                          textEditingController:
                              editSupplierController.supplierNameController,
                          prefixIcon: Icon(Icons.person_outline),
                        ),

                        SizedBox(height: 16),

                        //Restaurant Name
                        supplierDataController.supplier.supplierRole ==
                                'Restaurant Owner'
                            ? AppTextfield(
                                hintText: 'Restaurant Name',
                                validate: editSupplierController
                                    .validateRestaurantName,
                                onSaved:
                                    editSupplierController.saverestaurantName,
                                textEditingController: editSupplierController
                                    .restaurantNameController,
                                prefixIcon: Icon(Icons.people_outline),
                              )
                            : Container(),

                        SizedBox(height: 16),

                        //Your Address
                        AppTextfield(
                          hintText: 'Your Address',
                          validate:
                              editSupplierController.validateSupplierAddress,
                          onSaved: editSupplierController.saveAddress,
                          textEditingController:
                              editSupplierController.supplierAddressController,
                          prefixIcon: Icon(Icons.location_on),
                        ),

                        SizedBox(height: 16),

                        //Restaurant Address
                        supplierDataController.supplier.supplierRole ==
                                'Restaurant Owner'
                            ? AppTextfield(
                                hintText: 'Restaurant Address',
                                validate: editSupplierController
                                    .validateRestaurantAddress,
                                onSaved: editSupplierController
                                    .saveRestaurantAddress,
                                textEditingController: editSupplierController
                                    .restaurantAddressController,
                                prefixIcon: Icon(Icons.people_outline),
                              )
                            : Container(),

                        SizedBox(height: 16),

                        //Description
                        AppTextfield(
                                hintText: 'Description',
                                minLines: 3,
                                maxLines: 3,
                                validate: editSupplierController
                                    .validateDescription,
                                onSaved: editSupplierController
                                    .saveDescription,
                                textEditingController: editSupplierController
                                    .supplierDescriptionController,
                                prefixIcon: Icon(Icons.description_outlined),
                              ),
                            

                        SizedBox(height: 24),

                        AppButton(
                          text: 'Save Changes',
                          onPressed: () async {
                            editSupplierController.updateNGOProfile();
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
              child: editSupplierController.isLoading.value
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
