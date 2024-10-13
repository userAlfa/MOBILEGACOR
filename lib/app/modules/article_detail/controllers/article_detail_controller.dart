import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleDetailController extends GetxController {
  late WebViewController webViewController;

  @override
  void onInit() {
    super.onInit();
  }

  WebViewController initializeWebView(String uri) {
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(uri));
    return webViewController;
  }

  @override
  void onClose() {
    super.onClose();
  }
}
