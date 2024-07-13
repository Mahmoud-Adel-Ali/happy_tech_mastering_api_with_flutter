import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happy_tech_mastering_api_with_flutter/cubit/user_cubit.dart';
import 'package:happy_tech_mastering_api_with_flutter/cubit/user_state.dart';
import 'package:happy_tech_mastering_api_with_flutter/widgets/custom_form_button.dart';
import 'package:happy_tech_mastering_api_with_flutter/widgets/custom_input_field.dart';
import 'package:happy_tech_mastering_api_with_flutter/widgets/dont_have_an_account.dart';
import 'package:happy_tech_mastering_api_with_flutter/widgets/forget_password_widget.dart';
import 'package:happy_tech_mastering_api_with_flutter/widgets/page_header.dart';
import 'package:happy_tech_mastering_api_with_flutter/widgets/page_heading.dart';
import 'package:happy_tech_mastering_api_with_flutter/widgets/show_snack_bar.dart';

import 'profile_screen.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffEEF1F3),
        body: Column(
          children: [
            const PageHeader(),
            BlocConsumer<UserCubit, UserState>(
              listener: (context, state) {
                if (state is SignInFailure) {
                  showSnackBar(context, message: state.message);
                } else if (state is SignInSuccess) {
                  showSnackBar(context, message: 'success');
                  context.read<UserCubit>().getUserProfileData();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfileScreen(),
                    ),
                  );
                }
              },
              builder: (context, state) {
                return Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Form(
                        key: context.read<UserCubit>().signInFormKey,
                        child: Column(
                          children: [
                            const PageHeading(title: 'Sign-in'),
                            //!Email
                            CustomInputField(
                              labelText: 'Email',
                              hintText: 'Your email',
                              controller: context.read<UserCubit>().signInEmail,
                            ),
                            const SizedBox(height: 16),
                            //!Password
                            CustomInputField(
                              labelText: 'Password',
                              hintText: 'Your password',
                              obscureText: true,
                              suffixIcon: true,
                              controller:
                                  context.read<UserCubit>().signInPassword,
                            ),
                            const SizedBox(height: 16),
                            //! Forget password?
                            ForgetPasswordWidget(size: size),
                            const SizedBox(height: 20),
                            //!Sign In Button
                            state is SignInLoading
                                ? const CircularProgressIndicator()
                                : CustomFormButton(
                                    innerText: 'Sign In',
                                    onPressed: () {
                                      //! Validate the form
                                      if (context
                                          .read<UserCubit>()
                                          .signInFormKey
                                          .currentState!
                                          .validate()) {
                                        context.read<UserCubit>().signIn();
                                      }
                                    },
                                  ),
                            const SizedBox(height: 18),
                            //! Dont Have An Account ?
                            DontHaveAnAccountWidget(size: size),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
