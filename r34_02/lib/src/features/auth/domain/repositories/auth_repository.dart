import '../entities/login_entity.dart';
import '../entities/register_entity.dart';

abstract class AuthRepository {
  Future<LoginEntity> login({required String email, required String password});

  Future<RegisterEntity> register({
    required String username,
    required String email,
    required String password,
  });
}
