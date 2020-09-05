import 'package:flutter/material.dart';

import 'package:spotjob/styles/custom_colors.dart';

class SearchBar extends StatelessWidget {
  final Function(String) onChanged;

  SearchBar({this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      height: 40,
      child: TextField(
        textAlignVertical: TextAlignVertical.center,
        cursorColor: CustomColors.lightBlue,
        style: TextStyle(
          fontSize: 14,
          color: CustomColors.gray,
          fontWeight: FontWeight.w300,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.only(left: 16),
          prefixIcon: Icon(
            Icons.search,
            size: 20,
            color: CustomColors.gray,
          ),
          hintText: 'Search',
          hintStyle: TextStyle(
            color: CustomColors.gray,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              width: 1,
              color: CustomColors.gray,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              width: 2,
              color: CustomColors.gray,
            ),
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
