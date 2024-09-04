// import 'package:flutter/material.dart';

// import 'get'

// class Tuya extends gs.GetView {
//   @override
//   build(context) {
//     // var req = context.request.query;
//     // final body = await context.request.payload();
//     // logKey('req tuya', a);

//     // context.request.payload().then((value) async {
//     //   var tuyaC = gs.Get.find<TuyaController>();
//     //   final a = await tuyaC.getDeviceDetails(value?['device_id']);
//     //   return context.sendJson(
//     //     {
//     //       'data': a,
//     //     },
//     //   );
//     // });
//     // return const gs.WidgetEmpty();

//     return gs.PayloadWidget(
//       builder: (context, payload) {
//         var tuyaC = gs.Get.find<TuyaController>();
//         tuyaC.getDeviceDetails(payload?['device_id']).then(
//               (value) => context.sendJson(
//                 {'result': value},
//               ),
//             );
//         return gs.WidgetEmpty();
//       },
//     );

//     // return gs.Json(
//     //   {
//     //     'result': result,
//     //   },
//     //   // result,
//     // );
//   }
// }
