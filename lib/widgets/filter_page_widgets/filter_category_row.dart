import 'package:flutter/material.dart';

import 'package:spotjob/models/category.dart';
import 'package:spotjob/widgets/filter_page_widgets/filter_category_row_item.dart';
import 'package:spotjob/widgets/filter_page_widgets/filter_subcategory_row_item.dart';

class FilterCategoryRow extends StatelessWidget {
  final Category category;

  FilterCategoryRow(this.category);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FilterCategoryRowItem(
            category: category,
          ),
          SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.only(left: 28.0),
            child: Wrap(
              spacing: 24,
              runSpacing: 8,
              direction: Axis.horizontal,
              children: category.subcategories
                  .map((subcategory) => FilterSubcategoryRowItem(
                        subcategoryName: subcategory,
                        category: category,
                      ))
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}
