import 'package:biblioteca/screen/librarian/add_book_screen.dart';
import 'package:biblioteca/screen/librarian/details_book_screen_librarian.dart';
import 'package:biblioteca/screen/librarian/home_admin_screen.dart';
import 'package:biblioteca/screen/librarian/libros_prestados_screen.dart';
import 'package:biblioteca/screen/librarian/solicitudes_book_screen.dart';
import 'package:biblioteca/screen/librarian/view_all_group_screen.dart';
import 'package:biblioteca/screen/librarian/view_all_user_screen.dart';
import 'package:biblioteca/screen/librarian/view_multas_screen.dart';
import 'package:biblioteca/screen/teacher/home_teacher_screen.dart';
import 'package:biblioteca/screen/teacher/view_group_teacher_screen.dart';
import 'package:biblioteca/screen/teacher/view_multas_teacher_screen.dart';
import 'package:biblioteca/screen/teacher/view_studens.dart';
import 'package:biblioteca/screen/users_screen/home_screen.dart';
import 'package:biblioteca/screen/login_registrer/registrer/registrer_screen.dart';
import 'package:biblioteca/screen/users_screen/profile_screen.dart';
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
  /// Login Screen
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

  /// Registrer Screen
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

  /// Update User Screen
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

  /// Home Screen
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
      /// Book Details Screen
      GoRoute(
        path: '/book-details',
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
          /// Reserver Book Screen
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

  /// View Books Reserver Screen
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

  /// View Groups Screen
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

  /// Profile Screen
  GoRoute(
    path: '/profile-screen',
    pageBuilder: (context, state) {
      return CustomTransitionPage(
        key: state.pageKey,
        child: const GradientScaffold(
          child: ProfileScreen(),
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

  /// Admin Home Screen
  GoRoute(
    path: '/admin-screen',
    pageBuilder: (context, state) {
      return CustomTransitionPage(
        key: state.pageKey,
        child: const GradientScaffold(
          child: HomeAdminScreen(),
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
        path: '/book-details-librarian',
        pageBuilder: (context, state) {
          final Book book = state.extra as Book;
          return CustomTransitionPage(
            key: state.pageKey,
            child: GradientScaffold(
              child: DetailsBookScreenLibrarian(book: book),
            ),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return ScaleTransition(
                scale: animation,
                child: child,
              );
            },
          );
        },
      ),
    ],
  ),

  /// Add Book Screen
  GoRoute(
    path: '/add-book-screen-librarian',
    pageBuilder: (context, state) {
      return CustomTransitionPage(
        child: const GradientScaffold(
          child: AddBookScreen(),
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
  GoRoute(
    path: '/solicitudes-aprobar-libros-screen',
    pageBuilder: (context, state) => CustomTransitionPage(
      key: state.pageKey,
      child: const GradientScaffold(
        child: SolicitudesBookScreen(),
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
    path: '/libros-prestados-screen',
    pageBuilder: (context, state) => CustomTransitionPage(
      key: state.pageKey,
      child: const GradientScaffold(
        child: LibrosPrestadosScreen(),
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
    path: '/view-all-user-screen',
    pageBuilder: (context, state) {
      return CustomTransitionPage(
        key: state.pageKey,
        child: const GradientScaffold(
          child: ViewAllUserScreen(),
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
  GoRoute(
    path: '/view-all-group-screen',
    pageBuilder: (context, state) {
      return CustomTransitionPage(
        key: state.pageKey,
        child: const GradientScaffold(
          child: ViewAllGroupScreen(),
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
  GoRoute(
    path: '/view-multas-screen',
    pageBuilder: (context, state) {
      return CustomTransitionPage(
        child: const GradientScaffold(
          child: ViewMultasScreen(),
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

  /// Routes for the teacher

  GoRoute(
    path: '/home-teacher-screen',
    pageBuilder: (context, state) {
      return CustomTransitionPage(
        key: state.pageKey,
        child: const GradientScaffold(
          child: HomeTeacherScreen(),
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
        path: '/book-details-librarian',
        pageBuilder: (context, state) {
          final Book book = state.extra as Book;
          return CustomTransitionPage(
            key: state.pageKey,
            child: GradientScaffold(
              child: DetailsBookScreenLibrarian(book: book),
            ),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return ScaleTransition(
                scale: animation,
                child: child,
              );
            },
          );
        },
      ),
    ],
  ),

  GoRoute(
    path: '/view-students',
    pageBuilder: (context, state) {
      return CustomTransitionPage(
        key: state.pageKey,
        child: const GradientScaffold(
          child: ViewStudens(),
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
  GoRoute(
    path: '/view-multas-teacher-screen',
    pageBuilder: (context, state) {
      return CustomTransitionPage(
        key: state.pageKey,
        child: const GradientScaffold(
          child: ViewMultasTeacherScreen(),
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
  GoRoute(
    path: '/view-group-teacher-screen',
    pageBuilder: (context, state) {
      return CustomTransitionPage(
        key: state.pageKey,
        child: const GradientScaffold(
          child: ViewGroupTeacherScreen(),
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
