// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import 'package:spotjob/models/job.dart';
// import 'package:spotjob/providers/change_category.dart';
// import 'package:spotjob/widgets/common/blue_button.dart';
// import 'package:spotjob/widgets/common/white_button.dart';

// class SelectFilterPayType extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final changeCategoryProvider = Provider.of<ChangeCategory>(context);
//     PayType payType = changeCategoryProvider.filterPayType;

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
//                         changeCategoryProvider.filterPayType = PayType.perHour;
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
//                         changeCategoryProvider.filterPayType = PayType.oneTime;
//                       },
//                     ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
