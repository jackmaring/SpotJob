import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:spotjob/models/category.dart';
import 'package:spotjob/providers/change_category.dart';
import 'package:spotjob/utils/top_methods/job_top_methods.dart';

class FilterCategoryRowItem extends StatelessWidget {
  final Category category;

  FilterCategoryRowItem({this.category});

  @override
  Widget build(BuildContext context) {
    final changeCategoryProvider = Provider.of<ChangeCategory>(context);
    bool isInTags = JobTopMethods.getIsInTags(
        changeCategoryProvider.filterTags, category.name);

    return Row(
      children: [
        SizedBox(
          height: 20,
          width: 20,
          child: Checkbox(
            value: isInTags,
            onChanged: (_) {
              isInTags
                  ? changeCategoryProvider.removeCategoryTag(category)
                  : changeCategoryProvider.addCategoryTag(category);
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
