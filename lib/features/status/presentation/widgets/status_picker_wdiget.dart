
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../cores/app/theme/style.dart';
import '../../../user/domain/entities/user_entity.dart';
import '../../domain/entities/status_entity.dart';

class StatusPickerWidget extends StatelessWidget {
  final Function(StatusEntity? myStatus, UserEntity currentUser)
  onEitherShowOrUploadSheet;
  final UserEntity currentUser;
  final StatusEntity? myStatus;
  const StatusPickerWidget({super.key, r, required this.onEitherShowOrUploadSheet, required this.currentUser, this.myStatus});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 10,
      bottom: 8,
      child: GestureDetector(
        onTap: () {
          onEitherShowOrUploadSheet(
            myStatus,
            currentUser
          );
        },
        child: Container(
          width: 25,
          height: 25,
          decoration: BoxDecoration(
            color: tabColor,
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
                width: 2, color: backgroundColor),
          ),
          child: const Center(
            child: Icon(
              Icons.add,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }
}
