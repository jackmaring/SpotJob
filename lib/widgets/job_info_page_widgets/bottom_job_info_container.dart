import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:spotjob/models/job.dart';
import 'package:spotjob/providers/create_job.dart';
import 'package:spotjob/styles/custom_colors.dart';
import 'package:spotjob/widgets/common/cards_list.dart';
import 'package:spotjob/widgets/common/single_item_card.dart';

class BottomJobInfoContainer extends StatelessWidget {
  final Job relevantJob;

  BottomJobInfoContainer(this.relevantJob);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    final createJobProvider = Provider.of<CreateJob>(context);
    final Job updatedJob = createJobProvider.updatedJob;

    return createJobProvider.jobInfoTopContainerHeight != null
        ? Container(
            width: double.infinity,
            constraints: BoxConstraints(
              minHeight: mediaQuery.size.height -
                  createJobProvider.jobInfoTopContainerHeight -
                  100,
            ),
            decoration: BoxDecoration(
              gradient: CustomColors.spotJobTopDownGradient,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    'LOCATION TYPE',
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        .copyWith(color: Colors.white),
                  ),
                ),
                SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.only(left: 24),
                  child: SingleItemCard(
                    item: updatedJob != null
                        ? updatedJob.locationType == LocationType.location
                            ? 'Location'
                            : 'Remote'
                        : relevantJob.locationType == LocationType.location
                            ? 'Location'
                            : 'Remote',
                    canDelete: false,
                  ),
                ),
                SizedBox(height: 32),
                relevantJob.locationType == LocationType.location
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              'ADDRESS',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                          SizedBox(height: 16),
                          Padding(
                            padding: const EdgeInsets.only(left: 24),
                            child: SingleItemCard(
                              item: relevantJob.address,
                              canDelete: false,
                            ),
                          ),
                          SizedBox(height: 16),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              height: MediaQuery.of(context).size.width - 48,
                              width: MediaQuery.of(context).size.width - 48,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                elevation: 4,
                                shadowColor: CustomColors.lightGray,
                              ),
                            ),
                          ),
                          SizedBox(height: 32),
                        ],
                      )
                    : Container(),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    'TAGS',
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        .copyWith(color: Colors.white),
                  ),
                ),
                SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.only(left: 24),
                  child: CardsList(
                    updatedJob != null ? updatedJob.tags : relevantJob.tags,
                    false,
                    false,
                  ),
                ),
                SizedBox(height: 64),
              ],
            ),
          )
        : Container();
  }
}
