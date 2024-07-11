import 'package:flutter/material.dart';
import 'package:flutter_story_view/models/story_item.dart';
import 'package:whats_app_clone/features/status/presentation/widgets/status_list_view.dart';
import '../../../../cores/app/theme/style.dart';
import '../../../user/domain/entities/user_entity.dart';
import '../../domain/entities/status_entity.dart';
import 'my_status_widget.dart';

class StatusPageBody extends StatelessWidget {
  final List<StatusEntity> statuses;
  final UserEntity currentUser;
  final StatusEntity? myStatus;
  final Function(StatusEntity, List<StoryItem>) onShowStatusImageViewBottomModalSheet;
  final Function(StatusEntity?, UserEntity) onEitherShowOrUploadSheet;

  const StatusPageBody({
    super.key,
    required this.statuses,
    required this.currentUser,
    this.myStatus,
    required this.onShowStatusImageViewBottomModalSheet,
    required this.onEitherShowOrUploadSheet,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyStatusWidget(
              currentUser: currentUser,
              myStatus: myStatus,
              onEitherShowOrUploadSheet: onEitherShowOrUploadSheet,
            ),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Text(
                "Recent updates",
                style: TextStyle(
                  fontSize: 15,
                  color: greyColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 10),
            StatusListView(
              statuses: statuses,
              onShowStatusImageViewBottomModalSheet: onShowStatusImageViewBottomModalSheet,
              currentUser: currentUser,
            ),
          ],
        ),
      ),
    );
  }
}
