import 'package:blog_app/core/secrets/secrets.dart';
import 'package:blog_app/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:blog_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:blog_app/features/auth/domain/usercases/current_user_usecse.dart';
import 'package:blog_app/features/auth/domain/usercases/user_login_usecase.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:blog_app/features/auth/domain/usercases/user_sign_up.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  final supabase = await Supabase.initialize(
      anonKey: Secrets.supabaseAnonKey, url: Secrets.supabaseUrl);

  serviceLocator.registerLazySingleton(() => supabase.client);
}

void _initAuth() {
  //datasource
  serviceLocator
    ..registerFactory<AuthRemoteDatasource>(
      () => AuthRemoteDataSourceImpl(
        serviceLocator(),
      ),
    )
    //repository
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(
        serviceLocator(),
      ),
    )
    //signup Usecase
    ..registerFactory(
      () => UserSignUp(
        serviceLocator(),
      ),
    )
    //login usecase
    ..registerFactory(
      () => UserLoginUsecase(
        serviceLocator(),
      ),
    )
    //currentuser usecase
    ..registerFactory(
      () => CurrentUserUsecse(
        serviceLocator(),
      ),
    )
    //bloc state impl
    ..registerLazySingleton(
      () => AuthBlocBloc(
        userSignUp: serviceLocator(),
        loginUsercase: serviceLocator(),
        currentusercaser: serviceLocator(),
      ),
    );
}
