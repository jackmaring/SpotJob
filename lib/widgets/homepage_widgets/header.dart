import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:spotjob/pages/home_pages/filter_page.dart';
import 'package:spotjob/widgets/common/search_bar.dart';
import 'package:spotjob/widgets/homepage_widgets/category_dropdowns.dart';

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String _searchQuery;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CategoryDropdowns(),
          GestureDetector(
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.sort,
                  color: Colors.black,
                  size: 30,
                ),
                Icon(
                  FontAwesomeIcons.caretDown,
                  color: Colors.black,
                  size: 15,
                ),
              ],
            ),
            onTap: () {
              Navigator.pushNamed(context, FilterPage.routeName);
            },
          ),
          SizedBox(height: 32),
          SearchBar(
            onChanged: (value) {
              _searchQuery = value;
            },
          ),
          SizedBox(height: 12),
        ],
      ),
    );
  }
}
