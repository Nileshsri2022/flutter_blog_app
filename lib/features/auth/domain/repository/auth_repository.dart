import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/features/auth/domain/entities/user.dart';
import 'package:fpdart/fpdart.dart';

// Supabase password=> KValDjsknmRXidYd
abstract interface class AuthRepository{
  Future<Either<Failure,User>>signupWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<Either<Failure,User>>loginWithEmailPassword({
    required String email,
    required String password,
  });

}