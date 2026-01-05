import 'package:dio/dio.dart';
import 'package:flutter_store_task_app/src/core/constants/app_urls.dart';

import '../models/login_model.dart';
import '../models/register_model.dart';

abstract class AuthRemoteDataSource {
  Future<LoginModel> loginUser({
    required String email,
    required String password,
  });

  Future<RegisterModel> registerUser({
    required String username,
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio _dio;

  AuthRemoteDataSourceImpl(this._dio);

  @override
  Future<LoginModel> loginUser({
    required String email,
    required String password,
  }) async {
    final response = await _dio.post(
      AppUrls.login,
      data: {'email': email, 'password': password},
    );

    return LoginModel.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<RegisterModel> registerUser({
    required String username,
    required String email,
    required String password,
  }) async {
    final response = await _dio.post(
      AppUrls.register, // TODO: adjust endpoint
      data: {'username': username, 'email': email, 'password': password},
    );
    print(response);
    return RegisterModel.fromJson(response.data as Map<String, dynamic>);
  }
}
