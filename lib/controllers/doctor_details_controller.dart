import 'package:dr_plus/controllers/appbased_controller/appbase_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import '../models/doctor_details_model.dart';
import '../services/request_keys.dart';
import '../widgets/show_message.dart';

class DoctorDetailsController extends AppBaseController{

  int? selectedDays=0;
  String? docId;
  @override
  void onInit() {
    // TODO: implement onInit
    docId = Get.arguments ;
    DetailsData();
    super.onInit();
  }

  // List<Map<String,dynamic>> detailList =[
  //   {'image':'assets/images/doctor4.png','name':'Dr.Karan Mehra','profession':'Consultant Dermatology','address':'MBBS, MD, FCR (London)','experience':'Year of exp : 12 Years'},
  //   {'image':'assets/images/doctor5.png','name':'Dr.Karan Mehra','profession':'Consultant Dermatology','address':'MBBS, MD, FCR (London)','experience':'Year of exp : 12 Years'},
  //   {'image':'assets/images/doctor6.png','name':'Dr.Karan Mehra','profession':'Consultant Dermatology','address':'MBBS, MD, FCR (London)','experience':'Year of exp : 12 Years'},
  //
  // ];




  List <DoctorDetailsData> doctorDetailsData = [] ;
  Future<void> DetailsData () async{
    isBusy = true ;
    update();
    try{
      Map<String, String> body = {};
      body[RequestKeys.docId] = docId.toString();
      print('____doctorId______${body}_________');


      DoctorDetailsResponseModel res  = await api.getDoctorDetails(body) ;
      if(res.status??false){
        doctorDetailsData = res.data??[];
        if(doctorDetailsData.first.clinic!.isEmpty ||doctorDetailsData.first.clinic!.isNotEmpty ){
          isBusy=false;
        }

        update();
      }else {
        isBusy = false ;
        update();
        ShowMessage.showSnackBar('Error',"Something went wrong") ;
      }

    }catch(error) {
      ShowMessage.showSnackBar('Error',"${error}") ;
    }


  }



}