
import 'package:flutter/material.dart';

import '../../../../cores/app/theme/style.dart';
import '../../../user/domain/entities/user_entity.dart';
import '../../domain/entities/status_entity.dart';

class MyStatusInfo extends StatelessWidget {
  final Function(StatusEntity? myStatus, UserEntity currentUser)
  onEitherShowOrUploadSheet;
  final UserEntity currentUser;
  final StatusEntity? myStatus;
  const MyStatusInfo({super.key, required this.onEitherShowOrUploadSheet, required this.currentUser, this.myStatus,});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "My status",
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(
            height: 2,
          ),
          GestureDetector(
            onTap: () {
              onEitherShowOrUploadSheet(
                myStatus,
                currentUser
              );
            },
            child: const Text(
              "Tap to add your status update",
              style: TextStyle(color: greyColor),
            ),
          ),
        ],
      ),
    );
  }
}
