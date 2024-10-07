import 'package:chat_app/core/database/cache.dart';
import 'package:chat_app/feature/authentication/cubit/auth_cubit.dart';
import 'package:chat_app/feature/profile/presentation/view/user_profile_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'feature/authentication/presentation/view/sign_in_view.dart';
import 'feature/profile/cubit/profile_cubit.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize cache and Firebase
  await Cache.cacheInt();
  debugPrint(Cache.getValue(key: 'userId').toString());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => ProfileCubit()..getUserProfile()),
      ],
      child: MaterialApp(
        home: Cache.getValue(key: 'userId') != null
            ? FirebaseAuth.instance.currentUser!.emailVerified
                ?  UserProfileView()
                :  UserProfileView()
            : const SignIn(),
      ),
    );
  }
}
