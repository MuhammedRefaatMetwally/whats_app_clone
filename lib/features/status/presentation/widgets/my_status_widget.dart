import 'package:flutter/material.dart';
import 'package:flutter_story_view/models/story_item.dart';
import 'package:whats_app_clone/features/status/presentation/widgets/status_avatar_widget.dart';
import 'package:whats_app_clone/features/status/presentation/widgets/status_no_avatar_widget.dart';
import 'package:whats_app_clone/features/status/presentation/widgets/status_options.dart';
import 'package:whats_app_clone/features/status/presentation/widgets/status_picker_wdiget.dart';
import '../../../user/domain/entities/user_entity.dart';
import '../../domain/entities/status_entity.dart';
import 'my_status_info.dart';

class MyStatusWidget extends StatelessWidget {
  final UserEntity currentUser;
  final StatusEntity? myStatus;

  final Function(StatusEntity?, UserEntity) onEitherShowOrUploadSheet;

  const MyStatusWidget({
    Key? key,
    required this.currentUser,
    required this.myStatus,
    required this.onEitherShowOrUploadSheet,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Stack(
          children: [
            myStatus != null
                ? StatusAvatarWidget(
              onEitherShowOrUploadSheet: onEitherShowOrUploadSheet,
              currentUser: currentUser,
              myStatus: myStatus,
            )
                : StatusNoAvatarWidget(currentUser: currentUser),
            myStatus != null
                ? Container()
                : StatusPickerWidget(
              onEitherShowOrUploadSheet: onEitherShowOrUploadSheet,
              myStatus: myStatus,
              currentUser: currentUser,
            ),
          ],
        ),
        MyStatusInfo(
          onEitherShowOrUploadSheet: onEitherShowOrUploadSheet,
          myStatus: myStatus,
          currentUser: currentUser,
        ),
        StatusOptions(
          myStatus: myStatus,
        ),
        const SizedBox(
          width: 10,
        ),
      ],
    );
  }
}
