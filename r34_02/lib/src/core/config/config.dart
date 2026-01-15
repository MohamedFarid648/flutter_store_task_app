//  export 'injection.dart';
//    export 'keyboard.dart';

library config;

import 'package:dio/dio.dart';
import 'package:flutter_store_task_app/src/core/constants/app_urls.dart';
import 'package:flutter_store_task_app/src/features/auth/data/implements/auth_repository_imp.dart';
import 'package:flutter_store_task_app/src/features/product/data/implements/products_repository_impl.dart';
import 'package:flutter_store_task_app/src/features/product/data/sources/products_remote_data_source.dart';
import 'package:flutter_store_task_app/src/features/product/domain/repositories/products_repository.dart';
import 'package:flutter_store_task_app/src/features/product/domain/usecases/get_product_details_usecase.dart';
import 'package:flutter_store_task_app/src/features/product/domain/usecases/get_products_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

// AUTH FEATURE
import '../../features/auth/data/sources/auth_remote_data_source.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/login_usecase.dart';
import '../../features/auth/domain/usecases/register_usecase.dart';

import '../services/session_manager.dart';
import '../../features/cart/presentation/cubit/cart_cubit.dart';

part 'di.dart';
