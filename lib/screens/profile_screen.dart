import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happy_tech_mastering_api_with_flutter/cubit/user_cubit.dart';
import 'package:happy_tech_mastering_api_with_flutter/cubit/user_state.dart';
import 'package:happy_tech_mastering_api_with_flutter/screens/update_profile_screen.dart';
import 'package:happy_tech_mastering_api_with_flutter/widgets/custom_form_button.dart';
import 'package:happy_tech_mastering_api_with_flutter/widgets/show_snack_bar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<UserCubit, UserState>(
        listener: (context, state) {
          if (state is GetUserProfileDataFailure) {
            showSnackBar(context, message: state.message);
          }
        },
        builder: (context, state) {
          // ignore: prefer_const_constructors
          return state is GetUserProfileDataLoading
              ? const Center(child: CircularProgressIndicator())
              : state is GetUserProfileDataSuccess
                  ? ListView(
                      children: [
                        const SizedBox(height: 16),
                        //! Profile Picture
                        CircleAvatar(
                          radius: 80,
                          backgroundImage:
                              NetworkImage(state.userModel.profilePic),
                        ),
                        const SizedBox(height: 16),
                        //! Name
                        ListTile(
                          title: Text("Name : ${state.userModel.name}"),
                          leading: const Icon(Icons.person),
                        ),
                        const SizedBox(height: 16),

                        //! Email
                        ListTile(
                          title: Text("Email : ${state.userModel.email}"),
                          leading: const Icon(Icons.email),
                        ),
                        const SizedBox(height: 16),

                        //! Phone number
                        ListTile(
                          title:
                              Text("phone number : ${state.userModel.phone}"),
                          leading: const Icon(Icons.phone),
                        ),
                        const SizedBox(height: 16),

                        //! Address
                        ListTile(
                          title: Text(
                              "Address : ${state.userModel.address['type']}"),
                          leading: const Icon(Icons.location_city),
                        ),
                        const SizedBox(height: 100),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 28.0),
                          child: CustomFormButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UpdateProfileScreen(
                                    user: state.userModel,
                                  ),
                                ),
                              );
                            },
                            innerText: "Edit Profile",
                          ),
                        ),
                      ],
                    )
                  : Container();
        },
      ),
    );
  }
}
