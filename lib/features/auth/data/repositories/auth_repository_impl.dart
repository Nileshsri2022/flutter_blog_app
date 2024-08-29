import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/features/auth/domain/entities/user.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:blog_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:fpdart/src/either.dart';

class AuthRepositoryImpl implements AuthRepository {
  // dependency injection
  final AuthRemoteDataSource remoteDataSource;
  const AuthRepositoryImpl(this.remoteDataSource);
  @override
  Future<Either<Failure, User>> loginWithEmailPassword(
      {required String email, required String password}) async {
    return _getUser(()async=>await remoteDataSource.loginWithEmailPassword(
      email: email,
      password: password,
    ));

  }

  @override
  Future<Either<Failure, User>> signupWithEmailPassword(
      {required String name,
      required String email,
      required String password}) async {
    return _getUser(() async => await remoteDataSource.signupWithEmailPassword(
        name: name, email: email, password: password));
    // means the return a success
  }

  Future<Either<Failure, User>> _getUser(
    Future<User> Function() fn,
  ) async {
    try {
      final user = await fn();
      // means the return a success
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
