import 'package:flutter/material.dart';

import 'package:spotjob/widgets/common/single_item_card.dart';

class CardsList extends StatelessWidget {
  final List<String> items;
  final bool canDelete;
  final bool isSkill;

  CardsList(this.items, this.canDelete, this.isSkill);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.horizontal,
      spacing: 8,
      runSpacing: 8,
      children: items
          .map(
            (item) => SingleItemCard(
              item: item,
              canDelete: canDelete,
              isSkill: isSkill,
            ),
          )
          .toList(),
    );
  }
}
