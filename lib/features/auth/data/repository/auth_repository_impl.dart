import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:blog_app/features/auth/domain/entities/user.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl(this.authRemoteDataSource);

  @override
  Future<Either<Failure, User>> loginWithEmailAndPassword(
      {required String email, required String password}) {
    // TODO: implement loginWithEmailAndPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailAndPassword(
      {required String name,
      required String email,
      required String password}) async {
    try {
      final user = await authRemoteDataSource.signUpWithEmailAndPassword(
        name: name,
        email: email,
        password: password,
      );

      return Right(user);
    } on ServerException catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
