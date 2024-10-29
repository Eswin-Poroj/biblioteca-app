import 'package:biblioteca/screen/users_screen/home_screen.dart';
import 'package:biblioteca/screen/login_registrer/registrer/registrer_screen.dart';
import 'package:biblioteca/utils/graddient_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/book.dart';
import '../models/user_provider.dart';
import '../screen/users_screen/books/book_details_screen.dart';
import '../screen/users_screen/books/reserver_book_screen.dart';
import '../screen/login_registrer/login_screen.dart';
import '../screen/login_registrer/registrer/update_user.dart';
import '../screen/users_screen/books/view_books_reserver_screen.dart';
import '../screen/users_screen/view_groups_screen.dart';

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
    pageBuilder: (context, state) {
      return CustomTransitionPage(
        child: const GradientScaffold(
          child: RegistrerScreen(),
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      );
    },
    builder: (context, state) => const GradientScaffold(
      child: RegistrerScreen(),
    ),
  ),
  GoRoute(
    path: '/update-user',
    pageBuilder: (context, state) {
      final User user = state.extra as User;
      return CustomTransitionPage(
        key: state.pageKey,
        child: GradientScaffold(
          child: UpdateUser(user: user),
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      );
    },
    routes: [
      GoRoute(
        path: '/home-screen',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const GradientScaffold(
            child: HomeScreen(),
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        ),
      ),
    ],
  ),
  GoRoute(
    path: '/home-screen',
    pageBuilder: (context, state) => CustomTransitionPage(
      key: state.pageKey,
      child: const GradientScaffold(
        child: HomeScreen(),
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
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
        pageBuilder: (context, state) {
          final Book book = state.extra as Book;
          return CustomTransitionPage(
            child: GradientScaffold(child: BookDetailsScreen(book: book)),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return ScaleTransition(
                scale: animation,
                child: child,
              );
            },
          );
        },
        routes: [
          GoRoute(
            path: '/reserver-book',
            pageBuilder: (context, state) {
              final Book book = state.extra as Book;
              return CustomTransitionPage(
                key: state.pageKey,
                child: GradientScaffold(
                  child: ReserverBookScreen(book: book),
                ),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return RotationTransition(
                    turns: animation,
                    child: child,
                  );
                },
              );
            },
          ),
        ],
      ),
    ],
  ),
  GoRoute(
    path: '/libros-reservados',
    pageBuilder: (context, state) => CustomTransitionPage(
      key: state.pageKey,
      child: const GradientScaffold(
        child: ViewBooksReserverScreen(),
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    ),
  ),
  GoRoute(
    path: '/view-groups',
    pageBuilder: (context, state) {
      return CustomTransitionPage(
        key: state.pageKey,
        child: const GradientScaffold(
          child: ViewGroupsScreen(),
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      );
    },
  ),
};
