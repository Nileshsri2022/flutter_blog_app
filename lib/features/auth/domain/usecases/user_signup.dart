import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/auth/domain/entities/user.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/src/either.dart';

class UserSignup implements UseCase<User, UserSignUpparams> {
  final AuthRepository authRepository;
  const UserSignup(this.authRepository);
  @override
  Future<Either<Failure, User>> call(UserSignUpparams params) async {
    return  await authRepository.signupWithEmailPassword(
        name: params.name, email: params.email, password: params.password);
  }
}

class UserSignUpparams {
  final String email;
  final String password;
  final String name;

  UserSignUpparams(
      {required this.email, required this.password, required this.name});
}
