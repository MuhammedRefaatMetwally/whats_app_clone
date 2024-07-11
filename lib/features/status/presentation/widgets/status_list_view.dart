import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_story_view/models/story_item.dart';
import 'package:whats_app_clone/features/status/presentation/widgets/status_dotted_borders_widget.dart';

import '../../../../cores/app/global/date/date_formats.dart';
import '../../../../cores/app/global/widgets/profile_widget.dart';
import '../../../user/domain/entities/user_entity.dart';
import '../../domain/entities/status_entity.dart';

class StatusListView extends StatelessWidget {
  final List<StatusEntity> statuses;
  final Function(StatusEntity status, List<StoryItem> stories)
  onShowStatusImageViewBottomModalSheet;
  final UserEntity currentUser;
  const StatusListView({super.key, required this.statuses,required this.currentUser, required this.onShowStatusImageViewBottomModalSheet});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: statuses.length,
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      itemBuilder: (context, index) {
        final status = statuses[index];
        List<StoryItem> stories = status.stories!
            .map((storyItem) => StoryItem(
          url: storyItem.url??"",
          viewers: storyItem.viewers,
          type: StoryItemTypeExtension.fromString(storyItem.type!),
        ))
            .toList();
        return ListTile(
          onTap: () {
            onShowStatusImageViewBottomModalSheet(
             status,
               stories,
            );
          },
          leading: SizedBox(
            width: 55,
            height: 55,
            child: CustomPaint(
              painter: StatusDottedBordersWidget(
                isMe: false,
                numberOfStories: status.stories!.length,
                spaceLength: 4,
                images: status.stories,
                uid: currentUser.uid??"",
              ),
              child: Container(
                margin: const EdgeInsets.all(3),
                width: 55,
                height: 55,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: ProfileWidget(imageUrl: status.imageUrl),
                ),
              ),
            ),
          ),
          title: Text(
            status.username??"",
            style: const TextStyle(fontSize: 16),
          ),
          subtitle: Text(formatDateTime(status.createdAt!.toDate())),
        );
      },
    );
  }
}
