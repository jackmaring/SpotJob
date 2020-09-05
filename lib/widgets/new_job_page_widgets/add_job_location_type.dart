import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:spotjob/models/job.dart';
import 'package:spotjob/providers/create_job.dart';
import 'package:spotjob/widgets/common/blue_button.dart';
import 'package:spotjob/widgets/common/white_button.dart';

class SelectLocationType extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final createJobProvider = Provider.of<CreateJob>(context);
    LocationType locationType = createJobProvider.locationType;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'LOCATION TYPE',
          style: Theme.of(context).textTheme.headline5,
        ),
        SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              locationType == LocationType.location
                  ? WhiteButton(
                      text: 'Remote',
                      onTap: () {
                        createJobProvider.locationType = LocationType.remote;
                      },
                    )
                  : BlueButton(
                      text: 'Remote',
                      onTap: () {},
                    ),
              locationType == LocationType.location
                  ? BlueButton(
                      text: 'Location',
                      onTap: () {},
                    )
                  : WhiteButton(
                      text: 'Location',
                      onTap: () {
                        createJobProvider.locationType = LocationType.location;
                      },
                    ),
            ],
          ),
        ),
      ],
    );
  }
}
