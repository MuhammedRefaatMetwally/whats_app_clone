
import 'package:flutter/cupertino.dart';
import 'package:whats_app_clone/features/user/domain/entities/user_entity.dart';

import '../../../../cores/app/global/widgets/profile_widget.dart';

class StatusNoAvatarWidget extends StatelessWidget {
  final UserEntity currentUser;
  const StatusNoAvatarWidget({super.key, required this.currentUser});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
          horizontal: 10, vertical: 10),
      width: 60,
      height: 60,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: ProfileWidget(
            imageUrl: currentUser.profileUrl),
      ),
    );
  }
}
