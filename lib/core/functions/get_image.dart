import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happy_tech_mastering_api_with_flutter/cubit/user_cubit.dart';
import 'package:happy_tech_mastering_api_with_flutter/widgets/show_snack_bar.dart';
import 'package:image_picker/image_picker.dart';

Future getImage({required BuildContext context, required bool isClick}) async {
  await ImagePicker().pickImage(source: ImageSource.gallery).then(
    (value) {
      if (value == null) {
        return showSnackBar(context, message: 'un selected image');
      } else {
        context.read<UserCubit>().upLoadProfilPicture(value);
      }
    },
  );
}
