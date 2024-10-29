import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/features/auth/domain/usercases/user_sign_up.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class Usecase<SuccessType, Parms> {
  Future<Either<Failure, SuccessType>> call(UserSignUpParams parms);
}
