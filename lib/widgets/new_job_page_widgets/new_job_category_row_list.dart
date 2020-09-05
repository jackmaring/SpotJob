import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotjob/models/category.dart';

import 'package:spotjob/widgets/new_job_page_widgets/new_job_category_row.dart';

class NewJobCategoryRowList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<List<Category>>(context) ?? [];

    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        return NewJobCategoryRow(categories[index]);
      },
      itemCount: categories.length,
    );
  }
}