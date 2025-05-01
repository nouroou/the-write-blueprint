import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_write_blueprint/core/common/widgets/loader.dart';
import 'package:the_write_blueprint/core/theme/app_pallete.dart';
import 'package:the_write_blueprint/core/utils/show_snackbar.dart';
import 'package:the_write_blueprint/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:the_write_blueprint/features/auth/presentation/pages/signin_page.dart';
import 'package:the_write_blueprint/features/auth/presentation/widgets/auth_button.dart';
import 'package:the_write_blueprint/features/auth/presentation/widgets/auth_field.dart';
import 'package:the_write_blueprint/home_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();
  final nameController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              showSnackbar(context, state.message, true);
            } else if (state is AuthSuccess) {
              Navigator.pushAndRemoveUntil(
                  context, HomePage.route(context), (route) => false);
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return Loader();
            }
            return Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _signupText(),
                  _sizedBox(30),
                  AuthField(
                      hintText: 'Username',
                      editingController: usernameController),
                  _sizedBox(),
                  AuthField(
                      hintText: 'Full Name', editingController: nameController),
                  _sizedBox(),
                  AuthField(
                      hintText: 'email@example.com',
                      editingController: emailController),
                  _sizedBox(),
                  AuthField(
                      hintText: 'Password',
                      editingController: passwordController,
                      isPassword: true),
                  _sizedBox(24),
                  AuthButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          context.read<AuthBloc>().add(
                                AuthSignup(
                                    email: emailController.text.trim(),
                                    password: passwordController.text.trim(),
                                    name: nameController.text.trim(),
                                    username: usernameController.text.trim(),
                                    avatarUrl: ''),
                              );
                        }
                      },
                      text: 'Register'),
                  _sizedBox(),
                  _signinText(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  _signinText() => GestureDetector(
        onTap: () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SigninPage())),
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Already have an account? ',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              TextSpan(
                text: 'Sign In',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: AppPallete.gradient2, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      );

  SizedBox _sizedBox([double height = 20]) => SizedBox(
        height: height,
      );

  Text _signupText() {
    return Text(
      'Sign Up..',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 50,
      ),
    );
  }
}
