import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whats_app_clone/features/user/presentation/widgets/profile_item.dart';
import 'package:whats_app_clone/features/user/presentation/widgets/settings_item.dart';
import '../../../../cores/app/const/app_const.dart';
import '../../../../cores/app/global/widgets/profile_widget.dart';
import '../../../../cores/app/theme/style.dart';
import '../../../../cores/storage/storage_provider.dart';
import '../../domain/entities/user_entity.dart';
import '../cubit/user/user_cubit.dart';

class EditProfilePage extends StatefulWidget {
  final UserEntity currentUser;

  const EditProfilePage({super.key, required this.currentUser});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _aboutController = TextEditingController();

  File? _image;
  bool _isProfileUpdating = false;

  Future selectImage() async {
    try {
      final pickedFile =
          await ImagePicker.platform.getImage(source: ImageSource.gallery);

      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
        } else {
          print("no image has been selected");
        }
      });
    } catch (e) {
      toast("some error occured $e");
    }
  }

  @override
  void initState() {
    _usernameController =
        TextEditingController(text: widget.currentUser.username);
    _aboutController = TextEditingController(text: widget.currentUser.status);
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _aboutController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Profile"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 150,
                      height: 150,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(75),
                        child: ProfileWidget(
                            imageUrl: widget.currentUser.profileUrl,
                            image: _image),
                      ),
                    ),
                    Positioned(
                      bottom: 15,
                      right: 15,
                      child: GestureDetector(
                        onTap: selectImage,
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: tabColor,
                          ),
                          child: const Icon(
                            Icons.camera_alt_rounded,
                            color: blackColor,
                            size: 30,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ProfileItem(
                  controller: _usernameController,
                  title: "Name",
                  description: "Enter username",
                  icon: Icons.person,
                  onTap: () {}),
              ProfileItem(
                  controller: _aboutController,
                  title: "About",
                  description: "Hey there I'm using WhatsApp",
                  icon: Icons.info_outline,
                  onTap: () {}),
              SettingsItem(title: "Phone",
                  description: "${widget.currentUser.phoneNumber}",
                  icon: Icons.phone,
                  onTap: () {}),
              const SizedBox(height: 40),
              GestureDetector(
                onTap: submitProfileInfo,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  width: 120,
                  height: 40,
                  decoration: BoxDecoration(
                    color: tabColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: _isProfileUpdating == true
                      ? const Center(
                          child: SizedBox(
                            width: 25,
                            height: 25,
                            child: CircularProgressIndicator(
                              color: whiteColor,
                            ),
                          ),
                        )
                      : const Center(
                          child: Text(
                            "Save",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                ),
              ),
            ],
          ),
        ));
  }



  void submitProfileInfo() {
    if (_image != null) {
      StorageProviderRemoteDataSource.uploadProfileImage(
          file: _image!,
          onComplete: (onProfileUpdateComplete) {
            setState(() {
              _isProfileUpdating = onProfileUpdateComplete;
            });
          }).then((profileImageUrl) {
        _profileInfo(profileUrl: profileImageUrl);
      });
    } else {
      _profileInfo(profileUrl: widget.currentUser.profileUrl);
    }
  }

  void _profileInfo({String? profileUrl}) {
    if (_usernameController.text.isNotEmpty) {
      BlocProvider.of<UserCubit>(context)
          .updateUser(
              user: UserEntity(
        uid: widget.currentUser.uid,
        email: "",
        username: _usernameController.text,
        phoneNumber: widget.currentUser.phoneNumber,
        status: _aboutController.text,
        isOnline: false,
        profileUrl: profileUrl,
      ))
          .then((value) {
        toast("Profile updated");
      });
    }
  }
}
