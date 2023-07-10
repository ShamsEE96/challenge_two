import 'package:challenge_two/core/data/models/apis/meal_model.dart';
import 'package:challenge_two/core/data/models/common_response.dart';
import 'package:challenge_two/core/data/network/endpoints/meal_endpoints.dart';
import 'package:challenge_two/core/data/network/network_config.dart';
import 'package:challenge_two/core/enums/request_type.dart';
import 'package:challenge_two/core/utils/network_utils.dart';
import 'package:dartz/dartz.dart';

class MealRepository {
  Future<Either<String, List<MealModel>>> getAll() async {
    try {
      return NetworkUtil.sendRequest(
        requestType: RequestType.GET,
        url: MealEndpoints.getAll,
        headers: NetworkConfig.getHeaders(
          needAuth: false,
          requestType: RequestType.GET,
        ),
      ).then(
        (response) {
          CommonResponseModel<List<dynamic>> commonResponse =
              CommonResponseModel.fromJson(response);
          if (commonResponse.getStatus) {
            List<MealModel> resultList = [];

            commonResponse.data!.forEach(
              (element) {
                resultList.add(MealModel.fromJson(element));
              },
            );

            return Right(resultList);
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
