import 'package:api/src/api_repo.dart';
import 'package:api_client/api_result/api_result.dart';
import 'package:api_client/configs/client.dart';
import 'package:hive_storage/hive_storage.dart';

import 'auth/auth_repo.dart';
import 'user/user_repo.dart';

class ApiRepoImpl implements ApiRepo {
  final Client client;
  // ignore: unused_field
  final AuthRepo _authRepo;
  final UserRepo _userRepo;

  ApiRepoImpl({
    required this.client,
    required Box box,
  })  : _authRepo = AuthRepoImpl(client: client, box: box),
        _userRepo = UserRepoImpl(client: client);

  @override
  User? getUser() => _authRepo.getUser();

  @override
  bool get isLoggedIn => _authRepo.isLoggedIn;

  @override
  Future<void> logout() => _authRepo.logout();

  @override
  Future<ApiResult<User>> signIn({required LoginParams data}) {
    return _authRepo.signIn(data: data);
  }

  @override
  Future<ApiResult<SignupResponseModel>> signUp({required SignUpModel data}) {
    return _authRepo.signUp(data: data);
  }

  @override
  Stream<User?> get userStream => _authRepo.userStream;

  @override
  Future<ApiResult<RewardsResponseModel>> getRewards({required String id}) {
    return _userRepo.getRewards(id: id);
  }

  @override
  Future<ApiResult<TransactionsResponseModel>> getTransactions(
      {required String id}) {
    return _userRepo.getTransactions(id: id);
  }

  @override
  Future<ApiResult> updateProfile({required UpdateProfileParams params}) {
    return _userRepo.updateProfile(params: params);
  }

  @override
  String imageUrl(String image) =>
      'https://uniquetowinggoa.com/pearlhotel/$image';
}
