

// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:project/controllers/color_controller.dart';
// import 'package:project/reuse/reusablebtn.dart';
// import 'package:project/reuse/reusabletext.dart';

// reusableCard(BuildContext context,String ApplicationNo,String invoiceDate,String reqFor,
// String Address,String model,String year,Function ontap,Function ontapEvaluation){
//   final ScrollController innerController = ScrollController();
//   return Container(
//             height: MediaQuery.sizeOf(context).height * 0.23,
//             decoration: BoxDecoration(
//               border: Border.all(color: colorController.mainColor,style: BorderStyle.solid,width: 3),
//               borderRadius: BorderRadius.all(Radius.circular(12.0)),
//               color: colorController.whiteColor,
//     boxShadow: [
//       BoxShadow(
//         color: Colors.black.withOpacity(0.3),
//         spreadRadius: 0.5,
//         blurRadius: 8,
//         offset: Offset(4, 6), 
//       ),
//     ],
//             ),
//             child: Padding(
//               padding:  EdgeInsets.all(MediaQuery.sizeOf(context).height * 0.01,),
//               child: Scrollbar(
//                 controller: innerController,
//         thumbVisibility: true,
//         child: ListView(
//           controller: innerController,
//           physics: const ClampingScrollPhysics(),
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Expanded(child: reusableText('Application No : $ApplicationNo',color: colorController.textColorDark,fontsize: 15,)),
//                         SizedBox(width: MediaQuery.sizeOf(context).width * 0.03,),
//                         Expanded(child: reusableText('Invoice Date : $invoiceDate',color: colorController.textColorDark,fontsize: 15,)),
//                       ],
//                     ),
//                     reusablaSizaBox(context, 0.01),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Expanded(child: reusableText('Requested For : $reqFor',color: colorController.textColorDark,fontsize: 15,)),
//                         SizedBox(width: MediaQuery.sizeOf(context).width * 0.03,),
//                         Expanded(child: reusableText('Address : $Address',color: colorController.textColorDark,fontsize: 15,)),
//                       ],
//                     ),
//                     reusablaSizaBox(context, 0.01),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Expanded(child: reusableText('Model : $model',color: colorController.textColorDark,fontsize: 15,)),
//                         SizedBox(width: MediaQuery.sizeOf(context).width * 0.03,),
//                         Expanded(child: reusableText('Year : $year',color: colorController.textColorDark,fontsize: 15,)),
//                       ],
//                     ),
//                     reusablaSizaBox(context, 0.01),
//                     reusableBtn(context, 'All Details', (){
//                       ontap();
//                     },width: 0.45,height: 0.035),
//                     reusablaSizaBox(context, 0.01),
//                     reusableBtn(context, 'View', (){
//                       ontapEvaluation();
//                     },width: 0.45,height: 0.035),
//                   ],
//                 ),
//               ),
//             ),
//           );
// }


import 'package:flutter/material.dart';
import 'package:project/controllers/color_controller.dart';
import 'package:project/reuse/reusablebtn.dart';
import 'package:project/reuse/reusabletext.dart';

Widget VehicleListCard(BuildContext context,String brandLogo,String carName,String ownerName,String dateTime,String status,VoidCallback onTap){
  return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: colorController.whiteColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Row(
          children: [
            /// LEFT - BRAND LOGO
            Container(
              // height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width * 0.2,
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.network(
                brandLogo,
                fit: BoxFit.contain,
              ),
            ),

            SizedBox(width: MediaQuery.of(context).size.width * 0.03),

            /// CENTER - DETAILS
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  reusableText(
                    color: colorController.blackColor,
                    fontsize: 16,
                    carName,
                    fontweight: FontWeight.w600
                  ),
                  reusablaSizaBox(context, 0.005),
                  reusableText(
                    color: colorController.lightblackColor,
                    fontsize: 12.5,
                    ownerName,
                  ),
                  reusablaSizaBox(context, 0.005),
                  reusableText(
                    color: colorController.lightblackColor,
                    fontsize: 12.5,
                    dateTime,
                  ),
                ],
              ),
            ),

            /// RIGHT - STATUS
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                reusableText(status,color: colorController.lightblackColor,fontsize: 12),
                const SizedBox(height: 4),
                Icon(
                  Icons.handshake,
                  color: colorController.grayTextColor,
                  size: 20,
                ),
              ],
            ),
          ],
        ),
      ),
    );
}