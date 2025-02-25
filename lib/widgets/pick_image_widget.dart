import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happy_tech_mastering_api_with_flutter/cubit/user_cubit.dart';
import 'package:happy_tech_mastering_api_with_flutter/cubit/user_state.dart';

import '../core/functions/get_image.dart';

class PickImageWidget extends StatefulWidget {
  const PickImageWidget({
    super.key,
  });

  @override
  State<PickImageWidget> createState() => _PickImageWidgetState();
}

class _PickImageWidgetState extends State<PickImageWidget> {
  bool isClick = false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {},
      builder: (context, state) {
        return SizedBox(
          width: 130,
          height: 130,
          child: context.read<UserCubit>().profilePic != null
              ? CircleAvatar(
                  backgroundImage: FileImage(
                      File(context.read<UserCubit>().profilePic!.path)),
                  child: Stack(
                    children: [
                      isClick
                          ? const SizedBox()
                          : Positioned(
                              bottom: 5,
                              right: 5,
                              child: GestureDetector(
                                onTap: () async {
                                  isClick = true;
                                  setState(() {});
                                  await getImage(
                                      context: context, isClick: isClick);
                                  isClick = false;
                                  setState(() {});
                                },
                                child: Container(
                                  height: 35,
                                  width: 35,
                                  decoration: BoxDecoration(
                                    color: Colors.blue.shade400,
                                    border: Border.all(
                                        color: Colors.white, width: 3),
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: const Icon(
                                    Icons.camera_alt_sharp,
                                    color: Colors.white,
                                    size: 25,
                                  ),
                                ),
                              ),
                            ),
                    ],
                  ),
                )
              : CircleAvatar(
                  backgroundColor: Colors.grey.shade200,
                  backgroundImage: const AssetImage("assets/images/avatar.png"),
                  child: Stack(
                    children: [
                      isClick
                          ? const SizedBox()
                          : Positioned(
                              bottom: 5,
                              right: 5,
                              child: GestureDetector(
                                onTap: () async {
                                  isClick = true;
                                  setState(() {});

                                  await getImage(
                                      context: context, isClick: isClick);
                                  isClick = false;
                                  setState(() {});
                                },
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.blue.shade400,
                                    border: Border.all(
                                        color: Colors.white, width: 3),
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: const Icon(
                                    Icons.camera_alt_sharp,
                                    color: Colors.white,
                                    size: 25,
                                  ),
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}
