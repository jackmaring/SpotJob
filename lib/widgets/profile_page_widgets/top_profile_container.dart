import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:spotjob/models/user.dart';
import 'package:spotjob/providers/create_user.dart';
import 'package:spotjob/widgets/profile_page_widgets/top_profile_info.dart';

class TopProfileContainer extends StatefulWidget {
  final User relevantUser;

  TopProfileContainer(this.relevantUser);

  @override
  _TopProfileContainerState createState() => _TopProfileContainerState();
}

class _TopProfileContainerState extends State<TopProfileContainer> {
  final key = GlobalKey<_TopProfileContainerState>();

  @override
  initState() {
    super.initState();

    //calling the getHeight Function after the Layout is Rendered
    Future.delayed(
      Duration.zero,
      () {
        WidgetsBinding.instance.addPostFrameCallback(
          (_) {
            final RenderBox renderBox = key.currentContext.findRenderObject();
            final createUserProvider =
                Provider.of<CreateUser>(context, listen: false);
            createUserProvider.profileTopContainerHeight =
                renderBox.size.height;
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      key: key,
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          height: 25,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 8.0,
              )
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
            ),
          ),
          child: Column(
            children: [
              TopProfileInfo(widget.relevantUser),
            ],
          ),
        ),
      ],
    );
  }
}
