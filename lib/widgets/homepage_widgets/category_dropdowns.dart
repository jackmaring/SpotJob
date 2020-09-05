import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:spotjob/models/category.dart';

import 'package:spotjob/providers/change_category.dart';
import 'category_list_item.dart';

class CategoryDropdowns extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<List<Category>>(context) ?? [];
    final changeCategoryProvider = Provider.of<ChangeCategory>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        PopupMenuButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          padding: EdgeInsets.zero,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.bottomLeft,
            child: Row(
              children: <Widget>[
                Text(
                  changeCategoryProvider.categoryLabel,
                  style: Theme.of(context).textTheme.headline3,
                ),
                Icon(
                  FontAwesomeIcons.caretDown,
                  size: 25,
                ),
              ],
            ),
          ),
          itemBuilder: (context) => [
            PopupMenuItem(
              child: CategoryListItem(
                'ALL JOBS',
                () => changeCategoryProvider.changeToAllJobs(),
              ),
            ),
            for (int i = 0; i < categories.length; i++)
              PopupMenuItem(
                child: CategoryListItem(
                  categories[i].name,
                  () => changeCategoryProvider.changeCategory(categories[i]),
                ),
              ),
          ],
        ),
        changeCategoryProvider.currentCategory != null
            ? PopupMenuButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: EdgeInsets.zero,
                child: Row(
                  children: <Widget>[
                    Text(
                      changeCategoryProvider.subcategoryLabel,
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          .copyWith(color: Theme.of(context).accentColor),
                      textAlign: TextAlign.left,
                    ),
                    Icon(
                      FontAwesomeIcons.caretDown,
                      size: 15,
                      color: Theme.of(context).accentColor,
                    ),
                  ],
                ),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: CategoryListItem(
                      'ALL ${changeCategoryProvider.currentCategory.name}',
                      () => changeCategoryProvider.changeToAllSubcategories(),
                    ),
                  ),
                  for (int i = 0;
                      i <
                          changeCategoryProvider
                              .currentCategory.subcategories.length;
                      i++)
                    PopupMenuItem(
                      child: CategoryListItem(
                        changeCategoryProvider.currentCategory.subcategories[i],
                        () => changeCategoryProvider.changeSubcategory(
                            changeCategoryProvider
                                .currentCategory.subcategories[i]),
                      ),
                    )
                ],
              )
            : Row(
                children: <Widget>[
                  Text(
                    changeCategoryProvider.subcategoryLabel,
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        .copyWith(color: Theme.of(context).accentColor),
                    textAlign: TextAlign.left,
                  ),
                  Icon(
                    FontAwesomeIcons.caretDown,
                    size: 15,
                    color: Theme.of(context).accentColor,
                  ),
                ],
              ),
      ],
    );
  }
}
