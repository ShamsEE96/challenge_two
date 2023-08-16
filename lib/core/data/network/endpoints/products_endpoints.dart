import 'package:challenge_two/core/data/network/network_config.dart';

class ProductEndpoints {
  static String getAllCategory = NetworkConfig.getFullApiRoute('categories');
  static String getAllProduct = NetworkConfig.getFullApiRoute('');
  static String getByCategory = NetworkConfig.getFullApiRoute('category/');
}
