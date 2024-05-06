import 'package:blog_app/core/common/cubits/app_user_cubit/app_user_cubit.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/auth/presentation/pages/login_page.dart';
import 'package:blog_app/features/blog/presentation/pages/blog_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    context.read<AuthBloc>().add(IsUserLoggedInEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppUserCubit, AppUserState>(
      builder: (context, state) {
        if (state is AuthenticatedState) {
          return const BlogPage();
        } else if (state is UnAuthenticatedState) {
          return const LoginPage();
        }
        return const LoginPage();
      },
    );
    // return BlocSelector<AppUserCubit, AppUserState, bool>(
    //   selector: (state) {
    //     return state is UserAuthenticatedState;
    //   },
    //   builder: (context, isLoggedIn) {
    //     if (isLoggedIn) {
    //       return const BlogPage();
    //     }
    //     return const LoginPage();
    //   },
    // );
  }
}
