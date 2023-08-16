import 'package:challenge_two/core/data/models/apis/product_model.dart';
import 'package:challenge_two/core/data/models/common_response.dart';
import 'package:challenge_two/core/data/network/endpoints/products_endpoints.dart';
import 'package:challenge_two/core/data/network/network_config.dart';
import 'package:challenge_two/core/enums/request_type.dart';
import 'package:challenge_two/core/utils/network_utils.dart';
import 'package:dartz/dartz.dart';

class ProductRepository {
  Future<Either<String, List<String>>> getAllCategories() async {
    try {
      return NetworkUtil.sendRequest(
        requestType: RequestType.GET,
        url: ProductEndpoints.getAllCategory,
        headers: NetworkConfig.getHeaders(
          needAuth: false,
          requestType: RequestType.GET,
        ),
      ).then(
        (response) {
          CommonResponseModel<List<dynamic>> commonResponse =
              CommonResponseModel.fromJson(response);
          if (commonResponse.getStatus) {
            List<String> resultList = [];
            commonResponse.data!.insert(0, "All");
            commonResponse.data!.forEach(
              (element) {
                resultList.add(element);
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

  Future<Either<String, List<ProductModel>>> getAllProducts() async {
    try {
      return NetworkUtil.sendRequest(
        requestType: RequestType.GET,
        url: ProductEndpoints.getAllProduct,
        headers: NetworkConfig.getHeaders(
          needAuth: false,
          requestType: RequestType.GET,
        ),
      ).then(
        (response) {
          CommonResponseModel<List<dynamic>> commonResponse =
              CommonResponseModel.fromJson(response);
          if (commonResponse.getStatus) {
            List<ProductModel> resultList = [];

            commonResponse.data!.forEach(
              (element) {
                resultList.add(ProductModel.fromJson(element));
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

  Future<Either<String, List<ProductModel>>> getProductByCategory({
    required String categoryName,
  }) async {
    try {
      return NetworkUtil.sendRequest(
        requestType: RequestType.GET,
        url: ProductEndpoints.getByCategory + "${categoryName}",
        headers: NetworkConfig.getHeaders(
          needAuth: false,
          requestType: RequestType.GET,
        ),
      ).then(
        (response) {
          CommonResponseModel<List<dynamic>> commonResponse =
              CommonResponseModel.fromJson(response);
          if (commonResponse.getStatus) {
            List<ProductModel> resultList = [];

            commonResponse.data!.forEach(
              (element) {
                resultList.add(ProductModel.fromJson(element));
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
