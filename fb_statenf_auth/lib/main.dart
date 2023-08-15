import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fb_auth_provider/providers/profile/profile_provider.dart';
import 'package:fb_auth_provider/repositories/profile_repository.dart';
import 'package:firebase_auth/firebase_auth.dart' as fbAuth;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'pages/home_page.dart';
import 'pages/login_page.dart';
import 'pages/signup_page.dart';
import 'pages/splash_page.dart';
import 'providers/auth/auth_provider.dart';
import 'providers/login/login_provider.dart';
import 'providers/signup/signup_provider.dart';
import 'repositories/auth_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthRepository>(
          create: (_) => AuthRepository(
            firebaseFirestore: FirebaseFirestore.instance,
            firebaseAuth: fbAuth.FirebaseAuth.instance,
          ),
        ),
        Provider<ProfileRepository>(
          create: (_) => ProfileRepository(
            firebaseFirestore: FirebaseFirestore.instance,
          ),
        ),
        StreamProvider<fbAuth.User?>(
          initialData: null,
          create: (context) => context.read<AuthRepository>().user,
        ),
        StateNotifierProvider<AuthProvider, AuthState>(
          create: (context) => AuthProvider(),
        ),
        StateNotifierProvider<LoginProvider, LoginState>(
          create: (context) => LoginProvider(),
        ),
        StateNotifierProvider<SignupProvider, SignupState>(
          create: (context) => SignupProvider(),
        ),
        StateNotifierProvider<ProfileProvider, ProfileState>(
          create: (context) => ProfileProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'FB Auth',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue,
          ),
          useMaterial3: true,
        ),
        home: const SplashPage(),
        routes: {
          SignupPage.routeName: (context) => const SignupPage(),
          LoginPage.routeName: (context) => const LoginPage(),
          HomePage.routeName: (context) => const HomePage(),
        },
      ),
    );
  }
}
