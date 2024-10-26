import 'package:biblioteca/screen/home_screen.dart';
import 'package:biblioteca/screen/login_registrer/registrer/registrer_screen.dart';
import 'package:biblioteca/utils/graddient_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/book.dart';
import '../models/user_provider.dart';
import '../screen/books/book_details_screen.dart';
import '../screen/books/reserver_book_screen.dart';
import '../screen/login_registrer/login_screen.dart';
import '../screen/login_registrer/registrer/update_user.dart';

final routes = {
  GoRoute(
    path: '/',
    pageBuilder: (context, state) => CustomTransitionPage(
      key: state.pageKey,
      child: const GradientScaffold(
        child: LoginScreen(),
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    ),
  ),
  GoRoute(
    path: '/registrer',
    builder: (context, state) => const GradientScaffold(
      child: RegistrerScreen(),
    ),
  ),
  GoRoute(
    path: '/update-user',
    builder: (context, state) {
      final User user = state.extra as User;
      return GradientScaffold(
        child: UpdateUser(user: user),
      );
    },
    routes: [
      GoRoute(
        path: '/home-screen',
        builder: (context, state) => const GradientScaffold(
          child: HomeScreen(),
        ),
      ),
    ],
  ),
  GoRoute(
    path: '/home-screen',
    builder: (context, state) => const GradientScaffold(
      child: HomeScreen(),
    ),
    routes: [
      GoRoute(
        path: '/book-details',
        builder: (context, state) {
          final Book book = state.extra as Book;
          return GradientScaffold(
            child: BookDetailsScreen(book: book),
          );
        },
        routes: [
          GoRoute(
            path: '/reserver-book',
            builder: (context, state) {
              final Book book = state.extra as Book;
              return GradientScaffold(
                child: ReserverBookScreen(
                  book: book,
                ),
              );
            },
          ),
        ],
      ),
    ],
  ),
};
