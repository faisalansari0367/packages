import 'package:api/constants/endpoints.dart';
import 'package:api_client/api_client.dart';
import 'package:api_client/configs/client.dart';

import 'models/models.dart';
import 'user_repo.dart';

class UserRepoImpl implements UserRepo {
  final Client client;

  UserRepoImpl({required this.client});

  @override
  Future<ApiResult<RewardsResponseModel>> getRewards(
      {required String id}) async {
    try {
      final result = await client.get('${Endpoints.showReward}/$id');
      final model = RewardsResponseModel.fromJson(result.data);
      return ApiResult.success(data: model);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<TransactionsResponseModel>> getTransactions(
      {required String id}) async {
    try {
      final result =
          await client.get('${Endpoints.showTransactionHistory}/$id');
      final model = TransactionsResponseModel.fromJson(result.data);
      return ApiResult.success(data: model);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult> updateProfile({required UpdateProfileParams params}) async {
    try {
      final result = await client
          .build()
          .put(Endpoints.showProfile, data: params.toJson());
      // final model = TransactionsResponseModel.fromJson(result.data);
      return const ApiResult.success(data: Null);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }
}
