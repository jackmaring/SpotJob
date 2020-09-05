import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:spotjob/models/category.dart';
import 'package:spotjob/providers/create_job.dart';
import 'package:spotjob/utils/top_methods/job_top_methods.dart';

class NewJobSubcategoryRowItem extends StatelessWidget {
  final String subcategoryName;
  final Category category;

  NewJobSubcategoryRowItem({this.subcategoryName, this.category});

  @override
  Widget build(BuildContext context) {
    final createJobProvider = Provider.of<CreateJob>(context);
    bool isInTags =
        JobTopMethods.getIsInTags(createJobProvider.tags, subcategoryName);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 20,
          width: 20,
          child: Checkbox(
            value: isInTags,
            onChanged: (_) {
              isInTags
                  ? createJobProvider.removeSubcategoryTag(
                      category, subcategoryName)
                  : createJobProvider.addSubcategoryTag(
                      category, subcategoryName);
            },
          ),
        ),
        SizedBox(width: 8),
        Text(
          '${subcategoryName[0] + subcategoryName.substring(1).toLowerCase()}',
        ),
      ],
    );
  }
}
