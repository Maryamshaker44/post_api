import 'package:api_project/core/widget/my_validatore.dart';
import 'package:api_project/feature/auth/cubit/auth_cubit.dart';
import 'package:api_project/feature/auth/cubit/auth_state.dart';
import 'package:api_project/feature/auth/view/screen/login_screen.dart';
import 'package:api_project/feature/auth/view/widget/custom_text_field.dart';
import 'package:api_project/feature/auth/view/widget/gender.dart';
import 'package:api_project/feature/auth/view/widget/listener.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController nationalIdController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController profileImageController = TextEditingController();
  final TextEditingController tokenController = TextEditingController();
  bool visible = true;

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    emailController.addListener(() {
      setState(() {});
    });
    passwordController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: listener,
        builder: (context, state) {
          return Material(
            child: InkWell(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Scaffold(
                body: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: formKey,
                    child: ListView(children: [
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
                              "Register",
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
                      Row(children: [
                        const Text(
                          "Please upload a photo for your profile",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        context.read<AuthCubit>().image == null
                            ? MaterialButton(
                                onPressed: () {
                                  context.read<AuthCubit>().addImage();
                                },
                                child: const Icon(
                                  Icons.camera,
                                  size: 80,
                                ),
                              )
                            : Container(
                                height: 80,
                                width: 100,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: FileImage(
                                        context.read<AuthCubit>().image!),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                      ]),
                      CustomTextField(
                        controller: nameController,
                        validator: (value) {
                          return MyValidators.displayNameValidator(value);
                        },
                        label: "Name",
                        hint: "Enter your name",
                        prefix: Icons.account_circle,
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        controller: nationalIdController,
                        validator: (value) {
                          return MyValidators.nationalIdValidator(value);
                        },
                        keyboard: TextInputType.number,
                        label: "National ID",
                        hint: "Enter your ID",
                        prefix: Icons.perm_identity_outlined,
                      ),
                      const SizedBox(height: 20),
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
                      SizedBox(height: 20.h),
                      CustomTextField(
                        controller: phoneController,
                        validator: (value) {
                          return MyValidators.phoneValidator(value);
                        },
                        keyboard: TextInputType.phone,
                        label: "Phone Number",
                        hint: "Enter your phone",
                        prefix: Icons.phone,
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
                      CustomTextField(
                        controller: tokenController,
                        validator: (value) {
                          return MyValidators.tokenValidator(value);
                        },
                        label: "Token",
                        hint: "Enter a token",
                        prefix: Icons.token,
                      ),
                      const SizedBox(height: 20),
                      GenderSelection(genderController: genderController),
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
                          context.read<AuthCubit>().postDataCubit(
                                namedata: nameController.text,
                                emaildata: emailController.text,
                                genderdata: genderController.text,
                                nationalIddata: nationalIdController.text,
                                passworddata: passwordController.text,
                                phonedata: phoneController.text,
                                tokendata: tokenController.text,
                              );
                        },
                        child: const Text("Sign Up"),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) {
                            return const LoginScreen();
                          }));
                        },
                        child: const Center(
                          child: Text.rich(TextSpan(children: [
                            TextSpan(
                                text: "Do you have An Account ? ",
                                style: TextStyle(
                                  color: Colors.grey,
                                )),
                            TextSpan(
                                text: "Login",
                                style: TextStyle(
                                    color: Colors.purpleAccent,
                                    fontWeight: FontWeight.bold)),
                          ])),
                        ),
                      ),
                    ]),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
