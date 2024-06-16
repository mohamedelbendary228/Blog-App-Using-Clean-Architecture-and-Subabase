import 'package:blog_app/features/auth/presentation/pages/login_page.dart';
import 'package:blog_app/features/auth/presentation/pages/sign_up_page.dart';
import 'package:blog_app/features/blog/domain/entities/blog_entitiy.dart';
import 'package:blog_app/features/blog/presentation/pages/add_new_blog_page.dart';
import 'package:blog_app/features/blog/presentation/pages/blog_page.dart';
import 'package:blog_app/features/blog/presentation/pages/blog_viewer_page.dart';
import 'package:blog_app/landing.dart';
import 'package:blog_app/routes/routes.dart';
import 'package:flutter/material.dart';

Route<dynamic> onGenerate(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.kLoginRoute:
      return MaterialPageRoute(
        builder: (_) => const LoginPage(),
        settings: settings,
      );
    case AppRoutes.kSignUpRoute:
      return MaterialPageRoute(
        builder: (_) => const SignUpPage(),
        settings: settings,
      );
    case AppRoutes.kBlogRoute:
      return MaterialPageRoute(
        builder: (_) => const BlogPage(),
        settings: settings,
      );
    case AppRoutes.kAddNewBlogRoute:
      return MaterialPageRoute(
        builder: (_) => const AddNewBlogPage(),
        settings: settings,
      );
    case AppRoutes.kBLogViewerPageRoute:
      final blog = settings.arguments as Blog;
      return MaterialPageRoute(
        builder: (_) => BlogViewerPage(blog: blog),
        settings: settings,
      );
    case AppRoutes.kLandingRoute:
    default:
      return MaterialPageRoute(
        builder: (_) => const LandingPage(),
        settings: settings,
      );
  }
}
