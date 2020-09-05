import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:spotjob/models/job.dart';
import 'package:spotjob/providers/create_job.dart';

class AddJobAddress extends StatelessWidget {
  final TextEditingController addressController;

  AddJobAddress(this.addressController);

  @override
  Widget build(BuildContext context) {
    final createJobProvider = Provider.of<CreateJob>(context);
    return createJobProvider.locationType == LocationType.location
        ? Padding(
            padding: const EdgeInsets.only(top: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'ADDRESS',
                  style: Theme.of(context).textTheme.headline5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: addressController
                      ..text = createJobProvider.address,
                    onChanged: (value) {
                      createJobProvider.address = value;
                    },
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
              ],
            ),
          )
        : Container();
  }
}
