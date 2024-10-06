import 'package:chat_app/feature/authentication/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../feature/authentication/presentation/view/sign_up_view.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return BlocProvider(
          create: (context) => AuthCubit(),
          child: SignUpView(),
        );
      },
    ),
  ],
);
