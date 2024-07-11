import 'package:flutter/cupertino.dart';
import 'package:flutter_story_view/models/story_item.dart';
import 'package:whats_app_clone/features/status/presentation/widgets/status_dotted_borders_widget.dart';
import '../../../../cores/app/global/widgets/profile_widget.dart';
import '../../../user/domain/entities/user_entity.dart';
import '../../domain/entities/status_entity.dart';

class StatusAvatarWidget extends StatelessWidget {
  final Function(StatusEntity?, UserEntity) onEitherShowOrUploadSheet;
  final StatusEntity? myStatus;
  final UserEntity currentUser;

  const StatusAvatarWidget({
    super.key,
    required this.myStatus,
    required this.currentUser,
    required this.onEitherShowOrUploadSheet,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onEitherShowOrUploadSheet(
          myStatus,
          currentUser,
        );
      },
      child: Container(
        width: 55,
        height: 55,
        margin: const EdgeInsets.all(12.5),
        child: CustomPaint(
          painter: StatusDottedBordersWidget(
            isMe: true,
            numberOfStories: myStatus?.stories?.length ?? 0,
            spaceLength: 4,
            images: myStatus?.stories ?? [],
            uid: currentUser.uid,
          ),
          child: Container(
            margin: const EdgeInsets.all(3),
            width: 55,
            height: 55,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: ProfileWidget(
                imageUrl: myStatus?.imageUrl,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
