import 'package:flutter/material.dart';

class SpotjobBottomSheet {
  static spotjobBottomSheet({
    BuildContext context,
    String title,
    Widget child,
    Function onTap,
  }) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      builder: (context) => Column(
        children: [
          SizedBox(height: 32),
          Container(
            height: 6,
            width: 75,
            decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.headline4.copyWith(
                        decoration: TextDecoration.underline,
                      ),
                ),
                SizedBox(height: 24),
                child,
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 24.0),
                    child: GestureDetector(
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Theme.of(context).accentColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Icon(
                          Icons.forward,
                          color: Colors.white,
                        ),
                      ),
                      onTap: onTap,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
