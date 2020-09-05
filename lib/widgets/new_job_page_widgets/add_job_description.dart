import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:spotjob/providers/create_job.dart';

class AddJobDescription extends StatelessWidget {
  final TextEditingController descController;

  AddJobDescription(this.descController);

  @override
  Widget build(BuildContext context) {
    final job = Provider.of<CreateJob>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'DESCRIPTION',
          style: Theme.of(context).textTheme.headline5,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: TextField(
            controller: descController..text = job.descText,
            onChanged: (value) {
              job.descText = value;
            },
            style: Theme.of(context).textTheme.headline5,
            keyboardType: TextInputType.multiline,
            maxLines: 3,
          ),
        ),
      ],
    );
  }
}
