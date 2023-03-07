import 'dart:async';
import 'dart:convert';

import 'package:api/constants/endpoints.dart';
import 'package:api_client/api_client.dart';
import 'package:api_client/configs/client.dart';
import 'package:hive_storage/hive_storage.dart';

import 'auth_repo.dart';
import 'models/models.dart';
import 'storage/storage_service.dart';

class AuthRepoImpl implements AuthRepo {
  final Client client;
  final Box box;
  final StorageService storage;

  AuthRepoImpl({
    required this.client,
    required this.box,
  }) : storage = StorageService(box: box) {
    client.token = storage.getToken();
  }

  @override
  Future<ApiResult<SignupResponseModel>> signUp(
      {required SignUpModel data}) async {
    try {
      final result = await client.post(Endpoints.signUp, data: data.toJson());
      final model = SignupResponseModel.fromJson(result.data);
      if (model.status != 200) {
        return ApiResult.failure(
          error: NetworkExceptions.defaultError(model.error()),
        );
      }
      await storage.setToken(model.token!);
      return ApiResult.success(data: model);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<User>> signIn({required LoginParams data}) async {
    try {
      final result = await client.builder().build().post(
            Endpoints.loginCustomer,
            data: jsonEncode(data.toJson()),
          );
      // // final code = result.data['code'];
      // if (result.data['status'] != '200') {
      //   return ApiResult.failure(
      //     error: NetworkExceptions.defaultError(result.data['message']),
      //   );
      // }
      final model = SignInResponse.fromJson((result.data));
      await Future.wait([
        storage.setToken(model.token!),
        storage.setUser(User.fromJson(result.data).toJson()),
        storage.setIsLoggedIn(true),
      ]);
      return ApiResult.success(data: User(balancePoints: model.balancePoints));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  User? getUser() => storage.getUser();

  @override
  Future<void> logout() async {
    await storage.setIsLoggedIn(false);
    await storage.removeToken();
    await storage.removeUser();
  }

  @override
  bool get isLoggedIn => storage.isLoggedIn;

  @override
  Stream<User?> get userStream => storage.userStream;

  // @override
  // Future<ApiResult<ResponseModel>> forgotPassword(
  //     {required String email}) async {
  //   try {
  //     final result =
  //         await client.post(Endpoints.forgotPassword, data: {'email': email});
  //     if (result.data['code'] != '200') {
  //       return ApiResult.failure(
  //           error: NetworkExceptions.defaultError(result.data['message']));
  //     }
  //     final model = ResponseModel.fromMap(result.data);
  //     return ApiResult.success(data: model);
  //   } catch (e) {
  //     return ApiResult.failure(error: NetworkExceptions.getDioException(e));
  //   }
  // }
}
