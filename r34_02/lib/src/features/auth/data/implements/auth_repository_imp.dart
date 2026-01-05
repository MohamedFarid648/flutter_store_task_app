import '../../domain/entities/login_entity.dart';
import '../../domain/entities/register_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../sources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<LoginEntity> login({
    required String email,
    required String password,
  }) async {
    final model = await remoteDataSource.loginUser(
      email: email,
      password: password,
    );
    return model;
  }

  @override
  Future<RegisterEntity> register({
    required String username,
    required String email,
    required String password,
  }) async {
    final model = await remoteDataSource.registerUser(
      username: username,
      email: email,
      password: password,
    );
    return model;
  }
}
