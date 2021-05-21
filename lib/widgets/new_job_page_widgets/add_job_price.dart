import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:spotjob/providers/create_job.dart';

class AddJobPrice extends StatelessWidget {
  final TextEditingController priceController;

  AddJobPrice({this.priceController});

  @override
  Widget build(BuildContext context) {
    final createJobProvider = Provider.of<CreateJob>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          // createJobProvider.payType == PayType.oneTime ? 'PAY' : 'RATE/hr',
          'PAY',
          style: Theme.of(context).textTheme.headline5,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: TextFormField(
            keyboardType: TextInputType.number,
            controller: priceController,
            onChanged: (value) {
              createJobProvider.price = value;
            },
            style: Theme.of(context).textTheme.headline5,
            validator: (value) {
              if (value.isEmpty) {
                return 'Title required';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}
