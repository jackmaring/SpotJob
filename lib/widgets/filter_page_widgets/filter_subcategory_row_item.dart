import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:spotjob/models/category.dart';
import 'package:spotjob/providers/change_category.dart';
import 'package:spotjob/utils/top_methods/job_top_methods.dart';

class FilterSubcategoryRowItem extends StatelessWidget {
  final String subcategoryName;
  final Category category;

  FilterSubcategoryRowItem({this.subcategoryName, this.category});

  @override
  Widget build(BuildContext context) {
    final changeCategoryProvider = Provider.of<ChangeCategory>(context);
    bool isInTags = JobTopMethods.getIsInTags(
        changeCategoryProvider.filterTags, subcategoryName);

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
                  ? changeCategoryProvider.removeSubcategoryTag(
                      category, subcategoryName)
                  : changeCategoryProvider.addSubcategoryTag(
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
