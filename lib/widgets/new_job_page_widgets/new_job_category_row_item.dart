import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:spotjob/models/category.dart';
import 'package:spotjob/providers/create_job.dart';
import 'package:spotjob/utils/top_methods/job_top_methods.dart';

class NewJobCategoryRowItem extends StatelessWidget {
  final Category category;

  NewJobCategoryRowItem({this.category});

  @override
  Widget build(BuildContext context) {
    final createJobProvider = Provider.of<CreateJob>(context);
    bool isInTags =
        JobTopMethods.getIsInTags(createJobProvider.tags, category.name);

    return Row(
      children: [
        SizedBox(
          height: 20,
          width: 20,
          child: Checkbox(
            value: isInTags,
            onChanged: (_) {
              isInTags
                  ? createJobProvider.removeCategoryTag(category)
                  : createJobProvider.addCategoryTag(category);
            },
          ),
        ),
        SizedBox(width: 8),
        Text(
          category.name,
          style: Theme.of(context).textTheme.headline5,
        ),
      ],
    );
  }
}
