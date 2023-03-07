import 'package:api_client/api_client.dart';

import 'models/models.dart';

abstract class UserRepo {
  Future<ApiResult<RewardsResponseModel>> getRewards({required String id});
  Future<ApiResult<TransactionsResponseModel>> getTransactions(
      {required String id});
  Future<ApiResult> updateProfile({required UpdateProfileParams params});
}
