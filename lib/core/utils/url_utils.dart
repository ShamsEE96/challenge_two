import 'package:challenge_two/core/enums/message_type.dart';
import 'package:challenge_two/ui/shared/custom_widgets/custom_toast.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlUtil {
  Future cLaunchUrl(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      CustomToast.showMessage(
        message: 'Can\'t Launch URL',
        messageType: MessageType.REJECTED,
      );
    }
  }

  static String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  final Uri emailLaunchUri = Uri(
    scheme: 'mailto',
    path: 'smith@example.com',
    query: encodeQueryParameters(<String, String>{
      'subject': 'Example Subject & Symbols are allowed!',
    }),
  );
}
