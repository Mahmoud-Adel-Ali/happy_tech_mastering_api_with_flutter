import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happy_tech_mastering_api_with_flutter/core/models/user_model.dart';
import 'package:happy_tech_mastering_api_with_flutter/cubit/user_cubit.dart';
import 'package:happy_tech_mastering_api_with_flutter/cubit/user_state.dart';
import 'package:happy_tech_mastering_api_with_flutter/widgets/custom_form_button.dart';
import 'package:happy_tech_mastering_api_with_flutter/widgets/custom_input_field.dart';
import 'package:happy_tech_mastering_api_with_flutter/widgets/pick_image_widget.dart';
import 'package:happy_tech_mastering_api_with_flutter/widgets/show_snack_bar.dart';

class UpdateProfileScreen extends StatelessWidget {
  const UpdateProfileScreen({super.key, required this.user});
  final UserModel user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Profile'),
      ),
      body: BlocConsumer<UserCubit, UserState>(
        listener: (context, state) {
          if (state is UpdateFailure) {
            showSnackBar(context, message: state.message);
          } else if (state is UpdateSuccess) {
            showSnackBar(context, message: state.message);
            context.read<UserCubit>().getUserProfileData();
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return Center(
            child: Form(
              key: context.read<UserCubit>().updateFormKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    //! Image
                    const PickImageWidget(),
                    const SizedBox(height: 16),
                    //! Name
                    CustomInputField(
                      labelText: 'Name',
                      hintText: 'Your name',
                      isDense: true,
                      controller: context.read<UserCubit>().updateName,
                    ),
                    const SizedBox(height: 16),
                    //! Phone Number
                    CustomInputField(
                      labelText: 'Phone number',
                      hintText: 'Your phone number ex:01234567890',
                      isDense: true,
                      controller: context.read<UserCubit>().updatePhoneNumber,
                    ),
                    const SizedBox(height: 100),
                    //!update Button
                    state is UpdateLoading
                        ? const CircularProgressIndicator()
                        : CustomFormButton(
                            innerText: 'Update',
                            onPressed: () {
                              context.read<UserCubit>().updateUser(user);
                            },
                          ),
                    const SizedBox(height: 18),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
