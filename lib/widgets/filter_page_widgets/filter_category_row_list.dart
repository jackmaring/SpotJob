import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:spotjob/models/category.dart';
import 'package:spotjob/providers/change_category.dart';
import 'package:spotjob/widgets/filter_page_widgets/filter_category_row.dart';

class FilterCategoryRowList extends StatefulWidget {
  @override
  _FilterCategoryRowListState createState() => _FilterCategoryRowListState();
}

class _FilterCategoryRowListState extends State<FilterCategoryRowList> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      final changeCategoryProvider =
          Provider.of<ChangeCategory>(context, listen: false);
      final categories = Provider.of<List<Category>>(context, listen: false);

      if (categories != null) {
        changeCategoryProvider.addAllCategories(categories);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final changeCategoryProvider = Provider.of<ChangeCategory>(context);
    final categories = Provider.of<List<Category>>(context) ?? [];

    bool hasEveryCategoryAndSubcategory = categories.every(
      (cat) =>
          changeCategoryProvider.filterTags.contains(cat.name) &&
          cat.subcategories.every(
            (subCat) => changeCategoryProvider.filterTags.contains(subCat),
          ),
    )
        ? true
        : false;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 20,
              width: 20,
              child: Checkbox(
                value: hasEveryCategoryAndSubcategory,
                onChanged: (_) {
                  hasEveryCategoryAndSubcategory
                      ? changeCategoryProvider.removeAllCategories(categories)
                      : changeCategoryProvider.addAllCategories(categories);
                },
              ),
            ),
            SizedBox(width: 8),
            Text(
              'ALL JOBS',
              style: Theme.of(context).textTheme.headline5,
            ),
          ],
        ),
        SizedBox(height: 24),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) =>
                FilterCategoryRow(categories[index]),
            itemCount: categories.length,
          ),
        ),
      ],
    );
  }
}
