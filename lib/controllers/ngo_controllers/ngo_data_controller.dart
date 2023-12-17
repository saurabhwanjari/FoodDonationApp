import 'package:get/get.dart';
import 'package:donation_app/models/ngo_head.dart';

class NGODataController extends GetxService {
  //
  NGOHead ngoHead;
  var rxNGOHead = NGOHead.blankUser().obs;

  NGODataController({
    required this.ngoHead,
  }){
    rxNGOHead.value = ngoHead;
  }
}