import 'package:challenge_two/core/data/network/network_config.dart';

class UserEndpoints {
  static String login = NetworkConfig.getFullApiRoute('user/login');
  static String register = NetworkConfig.getFullApiRoute('user/register');
  static String forgotPassword =
      NetworkConfig.getFullApiRoute('User/ForgotPassword');
  static String verfiyOTPCode =
      NetworkConfig.getFullApiRoute('User/VerfiyCode');
  static String resetPassword =
      NetworkConfig.getFullApiRoute('User/ResetPassword');
}
