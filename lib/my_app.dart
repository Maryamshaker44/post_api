import 'package:api_project/feature/auth/cubit/auth_cubit.dart';
import 'package:api_project/feature/auth/view/screen/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      builder: (_, child) {
        return BlocProvider(
          create: (context) => AuthCubit(),
          child: const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: AuthScreen(),
          ),
        );
      },
    );
  }
}
