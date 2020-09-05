import 'package:flutter/material.dart';

class CategoryListItem extends StatelessWidget {
  final String category;
  final Function changeText;

  CategoryListItem(this.category, this.changeText);

  @override
  Widget build(BuildContext context) {
    return PopupMenuItem(
      child: GestureDetector(
        child: ListTile(
          title: Text(
            category,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        onTap: changeText,
      ),
    );
  }
}
