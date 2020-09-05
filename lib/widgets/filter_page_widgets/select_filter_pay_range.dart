import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:provider/provider.dart';
import 'package:spotjob/providers/change_category.dart';

class SelectFilterPayRange extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final changeCategoryProvider = Provider.of<ChangeCategory>(context);
    double lowerValue = changeCategoryProvider.filterPayRangeLowerValue;
    double upperValue = changeCategoryProvider.filterPayRangeUpperValue;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'PAY',
              style: Theme.of(context).textTheme.headline5,
            ),
            SizedBox(width: 8),
            Text(
              'any pay',
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(width: 8),
            SizedBox(
              height: 20,
              width: 20,
              child: Checkbox(
                value: changeCategoryProvider.anyPay,
                onChanged: (_) => changeCategoryProvider.toggleAnyPay(),
              ),
            ),
          ],
        ),
        SizedBox(height: 24),
        !changeCategoryProvider.anyPay
            ? FlutterSlider(
                values: [lowerValue, upperValue],
                min: 0,
                max: 200,
                maximumDistance: 300,
                rangeSlider: true,
                trackBar: FlutterSliderTrackBar(
                  activeTrackBar: BoxDecoration(
                    color: Theme.of(context).accentColor,
                  ),
                  inactiveTrackBar: BoxDecoration(
                    color: Theme.of(context).accentColor.withOpacity(0.5),
                  ),
                  activeTrackBarHeight: 3,
                  inactiveTrackBarHeight: 2,
                ),
                handler: FlutterSliderHandler(
                  decoration: BoxDecoration(),
                  child: Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                rightHandler: FlutterSliderHandler(
                  decoration: BoxDecoration(),
                  child: Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                handlerAnimation: FlutterSliderHandlerAnimation(
                    curve: Curves.elasticOut,
                    reverseCurve: null,
                    duration: Duration(milliseconds: 700),
                    scale: 1.4),
                onDragging: (handlerIndex, lowerValue, upperValue) {
                  changeCategoryProvider.filterPayRangeLowerValue = lowerValue;
                  changeCategoryProvider.filterPayRangeUpperValue = upperValue;
                },
              )
            : Container()
      ],
    );
  }
}
