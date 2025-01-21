import 'package:api_project/core/widget/my_validatore.dart';
import 'package:api_project/feature/auth/cubit/auth_cubit.dart';
import 'package:api_project/feature/auth/cubit/auth_state.dart';
import 'package:api_project/feature/auth/view/screen/auth_screen.dart';
import 'package:api_project/feature/auth/view/widget/custom_text_field.dart';
import 'package:api_project/feature/auth/view/widget/listener.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool visible = true;

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AuthCubit(),
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: listener, 
          builder: (context, state) {
          return Scaffold(
              body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: formKey,
              child: ListView(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(
                      top: 15.0,
                      left: 24.0,
                      bottom: 24.0,
                      right: 24.0,
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),
                  CustomTextField(
                    controller: emailController,
                    validator: (value) {
                      return MyValidators.emailValidator(value);
                    },
                    keyboard: TextInputType.emailAddress,
                    label: "Email",
                    hint: "example@gmail.com",
                    prefix: Icons.email,
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    validator: (value) {
                      return MyValidators.passwordValidator(value);
                    },
                    keyboard: TextInputType.visiblePassword,
                    obscureText: visible,
                    label: "Password",
                    hint: "Enter a password",
                    prefix: Icons.lock,
                    suffix: IconButton(
                        onPressed: () {
                          visible = !visible;
                          setState(() {});
                        },
                        icon: visible == false
                            ? const Icon(
                                Icons.remove_red_eye,
                              )
                            : const Icon(
                                Icons.visibility_off,
                              )),
                    controller: passwordController,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (state is AuthSuccessState) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              backgroundColor: Colors.purpleAccent,
                              content: Text(state.userdata["message"])),
                        );
                      }
                      context.read<AuthCubit>().loginDataCubit(
                            emaildata: emailController.text,
                            passworddata: passwordController.text,
                          );
                    },
                    child: const Text("Login"),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return const AuthScreen();
                      }));
                    },
                    child: const Center(
                      child: Text.rich(TextSpan(children: [
                        TextSpan(
                            text: "Don't have An Account ? ",
                            style: TextStyle(
                              color: Colors.grey,
                            )),
                        TextSpan(
                            text: "Signup",
                            style: TextStyle(
                                color: Colors.purpleAccent,
                                fontWeight: FontWeight.bold)),
                      ])),
                    ),
                  ),
                ],
              ),
            ),
          ));
        }));
  }

}
