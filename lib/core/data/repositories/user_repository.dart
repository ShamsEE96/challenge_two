import 'package:challenge_two/core/data/models/apis/token_info_model.dart';
import 'package:challenge_two/core/data/models/common_response.dart';
import 'package:challenge_two/core/data/network/endpoints/user_endpoints.dart';
import 'package:challenge_two/core/data/network/network_config.dart';
import 'package:challenge_two/core/enums/request_type.dart';
import 'package:challenge_two/core/utils/network_utils.dart';
import 'package:dartz/dartz.dart';

class UserRepository {
  Future<Either<String, TokenInfoModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      return NetworkUtil.sendRequest(
        requestType: RequestType.POST,
        url: UserEndpoints.login,
        headers: NetworkConfig.getHeaders(
          requestType: RequestType.POST,
          needAuth: false,
        ),
        body: {
          'userName': email,
          'password': password,
        },
      ).then(
        (response) {
          CommonResponseModel<Map<String, dynamic>> commonResponse =
              CommonResponseModel.fromJson(response);
          if (commonResponse.getStatus) {
            return Right(
              TokenInfoModel.fromJson(
                commonResponse.data ?? {},
              ),
            );
          } else {
            return Left(commonResponse.message ?? '');
          }
        },
      );
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, bool>> register({
    required String email,
    required String firstname,
    required String lastname,
    required int age,
    required String password,
    required String photoPath,
  }) async {
    try {
      return NetworkUtil.sendMultipartRequest(
        requestType: RequestType.POST,
        url: UserEndpoints.register,
        fields: {
          'Email': email,
          'FirstName': firstname,
          'LastName': lastname,
          'Password': password,
          'Age': age.toString()
        },
        files: {
          'Photo': photoPath,
        },
        headers: NetworkConfig.getHeaders(
          requestType: RequestType.POST,
          needAuth: false,
          extraHeaders: {
            'Host': 'training.owner-tech.com',
            // 'Content-Type':
            //     'multipart/form-data; boundary=--------------------------641542932887345895299314',
            // 'Content-Length': '37139'
          },
        ),
      ).then(
        (response) {
          CommonResponseModel<Map<String, dynamic>> commonResponse =
              CommonResponseModel.fromJson(response);
          if (commonResponse.getStatus) {
            return Right(commonResponse.getStatus);
          } else {
            return Left(commonResponse.message ?? '');
          }
        },
      );
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, Map<String, dynamic>>> forgotPassword({
    required String email,
    // required String password,
  }) async {
    try {
      return NetworkUtil.sendRequest(
        requestType: RequestType.POST,
        url: UserEndpoints.forgotPassword,
        headers: NetworkConfig.getHeaders(
          requestType: RequestType.POST,
          needAuth: false,
        ),
        params: {
          "email1": email,
        },
      ).then(
        (response) {
          CommonResponseModel<Map<String, dynamic>> commonResponse =
              CommonResponseModel.fromJson(response);
          if (commonResponse.getStatus) {
            return Right(
              commonResponse.data ?? {},
            );
          } else {
            return Left(commonResponse.message ?? '');
          }
        },
      );
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, Map<String, dynamic>>> newPassword({
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      return NetworkUtil.sendRequest(
        requestType: RequestType.POST,
        url: UserEndpoints.resetPassword + "/${email}",
        headers: NetworkConfig.getHeaders(
          requestType: RequestType.POST,
          needAuth: false,
        ),
        body: {
          "password": password,
          "confirmPassword": confirmPassword,
        },
      ).then(
        (response) {
          CommonResponseModel<Map<String, dynamic>> commonResponse =
              CommonResponseModel.fromJson(response);
          if (commonResponse.getStatus) {
            return Right(
              commonResponse.data ?? {},
            );
          } else {
            return Left(commonResponse.message ?? '');
          }
        },
      );
    } catch (e) {
      return Left(e.toString());
    }
  }
}
