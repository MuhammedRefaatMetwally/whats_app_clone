import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:whats_app_clone/cores/app/global/widgets/profile_widget.dart';
import 'package:whats_app_clone/cores/routing/routes.dart';
import '../../../../cores/app/home/home_page.dart';
import '../../../../cores/app/theme/style.dart';
import '../../domain/entities/status_entity.dart';
import '../cubit/status/status_cubit.dart';
import '../widgets/delete_status_update_alert.dart';

class MyStatusPage extends StatelessWidget {
  final StatusEntity status;

  const MyStatusPage({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Status"),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 12),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 55,
                  height: 55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: ProfileWidget(
                      imageUrl: status.imageUrl
                    ),
                  ),
                ),
                const SizedBox(width: 15,),
                Expanded(
                  child: Text(
                    GetTimeAgo.parse(status.createdAt!.toDate().subtract(Duration(seconds: DateTime.now().second))),
                    style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                  ),
                ),

                PopupMenuButton<String>(
                  icon:Icon(Icons.more_vert, color: greyColor.withOpacity(.5),),
                  color: appBarColor,
                  iconSize: 28,
                  onSelected: (value) {},
                  itemBuilder: (_) => <PopupMenuEntry<String>>[
                    PopupMenuItem<String>(
                      value: "Delete",
                      child: GestureDetector(onTap: () {
                        deleteStatusUpdate(context, onTap: () {
                          Navigator.pop(context);
                          BlocProvider.of<StatusCubit>(context).deleteStatus(
                              status: StatusEntity(
                                  statusId: status.statusId
                              )
                          );
                          Navigator.pushReplacementNamed(context,
                              Routes.welcomePage,arguments: status.uid);
                          });
                      },
                      child: const Text('Delete'),),),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
