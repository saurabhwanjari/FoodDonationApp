import 'package:get/get.dart';
import 'package:donation_app/models/supplier.dart';

class SupplierDataController extends GetxService {
  //
  Supplier supplier;
  var rxSupplier = Supplier.blankUser().obs;

  SupplierDataController({
    required this.supplier,
  }){
    rxSupplier.value = supplier;
  }
}