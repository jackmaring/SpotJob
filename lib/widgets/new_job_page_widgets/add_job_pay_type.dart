// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import 'package:spotjob/models/job.dart';
// import 'package:spotjob/providers/create_job.dart';
// import 'package:spotjob/widgets/common/blue_button.dart';
// import 'package:spotjob/widgets/common/white_button.dart';

// class SelectPayType extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final createJobProvider = Provider.of<CreateJob>(context);
//     PayType payType = createJobProvider.payType;

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'PAY TYPE',
//           style: Theme.of(context).textTheme.headline5,
//         ),
//         SizedBox(height: 24),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               payType == PayType.oneTime
//                   ? WhiteButton(
//                       text: 'Hourly',
//                       onTap: () {
//                         createJobProvider.payType = PayType.perHour;
//                       },
//                     )
//                   : BlueButton(
//                       text: 'Hourly',
//                       onTap: () {},
//                     ),
//               payType == PayType.oneTime
//                   ? BlueButton(
//                       text: 'One Time',
//                       onTap: () {},
//                     )
//                   : WhiteButton(
//                       text: 'One Time',
//                       onTap: () {
//                         createJobProvider.payType = PayType.oneTime;
//                       },
//                     ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
