import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/auth/domain/entities/user.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserLoginUsecase implements Usecase<User, UserLoginIn> {
  final AuthRepository authRepository;

  const UserLoginUsecase(this.authRepository);
  @override
  Future<Either<Failure, User>> call(UserLoginIn parms) async {
    return await authRepository.loginWithEmailAndPassword(
      email: parms.email,
      password: parms.password,
    );
  }
}

class UserLoginIn {
  final String email;
  final String password;

  UserLoginIn({required this.email, required this.password});
}
