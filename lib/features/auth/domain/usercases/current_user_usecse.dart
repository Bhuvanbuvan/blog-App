import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/auth/domain/entities/user.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class CurrentUserUsecse implements Usecase<User, NoParams> {
  final AuthRepository authRepository;

  const CurrentUserUsecse(this.authRepository);
  @override
  Future<Either<Failure, User>> call(NoParams parms) async {
    return await authRepository.currentUser();
  }
}
