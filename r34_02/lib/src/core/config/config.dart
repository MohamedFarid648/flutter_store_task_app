//  export 'injection.dart';
//    export 'keyboard.dart';

library config;

import 'package:dio/dio.dart';
import 'package:flutter_store_task_app/src/core/constants/app_urls.dart';
import 'package:flutter_store_task_app/src/features/auth/data/implements/auth_repository_imp.dart';
import 'package:get_it/get_it.dart';

// AUTH FEATURE
import '../../features/auth/data/sources/auth_remote_data_source.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/login_usecase.dart';
import '../../features/auth/domain/usecases/register_usecase.dart';

part 'di.dart';
