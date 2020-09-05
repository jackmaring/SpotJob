import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:spotjob/models/job.dart';
import 'package:spotjob/providers/change_category.dart';
import 'package:spotjob/widgets/common/blue_button.dart';
import 'package:spotjob/widgets/common/white_button.dart';

class SelectFilterLocationType extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final changeCategoryProvider = Provider.of<ChangeCategory>(context);
    LocationType locationType = changeCategoryProvider.filterLocationType;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'LOCATION TYPE',
              style: Theme.of(context).textTheme.headline5,
            ),
            SizedBox(width: 8),
            Text(
              'any location type',
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(width: 8),
            SizedBox(
              height: 20,
              width: 20,
              child: Checkbox(
                value: changeCategoryProvider.anyLocationType,
                onChanged: (_) =>
                    changeCategoryProvider.toggleAnyLocationType(),
              ),
            ),
          ],
        ),
        SizedBox(height: 24),
        !changeCategoryProvider.anyLocationType
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    locationType == LocationType.location
                        ? WhiteButton(
                            text: 'Remote',
                            onTap: () {
                              changeCategoryProvider.filterLocationType =
                                  LocationType.remote;
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
                              changeCategoryProvider.filterLocationType =
                                  LocationType.location;
                            },
                          ),
                  ],
                ),
              )
            : Container(),
      ],
    );
  }
}
