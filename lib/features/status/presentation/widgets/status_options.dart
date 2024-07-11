
import 'package:flutter/material.dart';

import '../../../../cores/app/theme/style.dart';
import '../../../../cores/routing/routes.dart';
import '../../domain/entities/status_entity.dart';

class StatusOptions extends StatelessWidget {
  final StatusEntity? myStatus;
  const StatusOptions({super.key, this.myStatus});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, Routes.myStatusPage,
            arguments: myStatus);
      },
      child: Icon(
        Icons.more_horiz,
        color: greyColor.withOpacity(.5),
      ),
    );
  }
}
