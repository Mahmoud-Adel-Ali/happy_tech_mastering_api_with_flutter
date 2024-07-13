import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happy_tech_mastering_api_with_flutter/cubit/user_cubit.dart';
import 'package:happy_tech_mastering_api_with_flutter/cubit/user_state.dart';
import 'package:happy_tech_mastering_api_with_flutter/widgets/custom_form_button.dart';
import 'package:happy_tech_mastering_api_with_flutter/widgets/show_snack_bar.dart';

deleteUserDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        child: SizedBox(
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text(
                'Are you sure to delete your account',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'NotoSerif'),
              ),
              BlocConsumer<UserCubit, UserState>(listener: (context, state) {
                if (state is DeletingFailure) {
                  showSnackBar(context, message: state.message);
                } else if (state is DeletingSuccess) {
                  showSnackBar(context, message: state.message);
                  showSnackBar(context, message: 'your account is deleted !');
                  Navigator.pop(context);
                  Navigator.pop(context);
                }
              }, builder: (context, state) {
                return state is DeletingLoading
                    ? const CircularProgressIndicator()
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 28.0),
                        child: CustomFormButton(
                          onPressed: () {
                            context.read<UserCubit>().deleteUser();
                          },
                          innerText: "Delete my account",
                        ),
                      );
              }),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                child: CustomFormButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  innerText: "Cancel",
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
