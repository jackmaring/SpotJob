import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:spotjob/providers/create_job.dart';
import 'package:spotjob/widgets/common/cards_list.dart';
import 'package:spotjob/widgets/common/spotjob_bottom_sheet.dart';
import 'package:spotjob/widgets/new_job_page_widgets/new_job_category_row_list.dart';

class AddJobTags extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final createJobProvider = Provider.of<CreateJob>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: [
            RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.headline5,
                children: <TextSpan>[
                  TextSpan(text: 'TAGS '),
                  TextSpan(
                    text: '(Add at least 1)',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.add_circle_outline,
                size: 25,
                color: Theme.of(context).accentColor,
              ),
              onPressed: () {
                SpotjobBottomSheet.spotjobBottomSheet(
                  context: context,
                  title: 'SELECT YOUR TAGS',
                  child: NewJobCategoryRowList(),
                  onTap: () => Navigator.pop(context),
                );
              },
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 8),
          child: CardsList(createJobProvider.tags, false, false),
        ),
      ],
    );
  }
}
