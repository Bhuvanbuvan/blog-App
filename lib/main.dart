import 'package:blog_app/core/secrets/secrets.dart';
import 'package:blog_app/core/theme/theme_app.dart';
import 'package:blog_app/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:blog_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:blog_app/features/auth/domain/usercases/user_sign_up.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc_bloc.dart';
import 'package:blog_app/features/auth/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final supabase = await Supabase.initialize(
      anonKey: Secrets.supabaseAnonKey, url: Secrets.supabaseUrl);
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => AuthBlocBloc(
          userSignUp: UserSignUp(
            authRepository: AuthRepositoryImpl(
              AuthRemoteDataSourceImpl(supabase.client),
            ),
          ),
        ),
      )
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeApp.dartThemeMode,
      home: const LoginPage(),
    );
  }
}
