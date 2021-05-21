import 'package:flutter/material.dart';

import 'package:spotjob/widgets/common/big_text.dart';

class WalletPage extends StatelessWidget {
  static const routeName = '/wallet';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText('WALLET'),
      ],
    );
  }
}
