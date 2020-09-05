import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:spotjob/pages/tabs_pages/tabs_page.dart';
import 'package:spotjob/providers/change_category.dart';
import 'package:spotjob/styles/custom_colors.dart';
import 'package:spotjob/widgets/common/back_arrow_appbar.dart';
import 'package:spotjob/widgets/common/big_text.dart';
import 'package:spotjob/widgets/common/long_blue_button.dart';
import 'package:spotjob/widgets/filter_page_widgets/filter_category_row_list.dart';
import 'package:spotjob/widgets/filter_page_widgets/select_filter_location_type.dart';
import 'package:spotjob/widgets/filter_page_widgets/select_filter_pay_range.dart';

class FilterPage extends StatelessWidget {
  static const routeName = '/filter';

  @override
  Widget build(BuildContext context) {
    final changeCategoryProvider = Provider.of<ChangeCategory>(context);

    return Scaffold(
      appBar: BackArrowAppBar(
        onPressed: () => Navigator.pop(context),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 73),
            BigText('FILTER'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 300,
                    child: FilterCategoryRowList(),
                  ),
                  SizedBox(height: 8),
                  Divider(
                    color: CustomColors.gray,
                  ),
                  // SizedBox(height: 32),
                  // SelectFilterPayType(),
                  SizedBox(height: 32),
                  SelectFilterPayRange(),
                  SizedBox(height: 24),
                  SelectFilterLocationType(),
                  SizedBox(height: 64),
                  LongBlueButton(
                    text: 'Apply Filter',
                    onTap: () {
                      changeCategoryProvider.changeToCustomFilter();
                      Navigator.pushNamedAndRemoveUntil(
                          context, TabsPage.routeName, (route) => false);
                    },
                  ),
                  SizedBox(height: 48),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
