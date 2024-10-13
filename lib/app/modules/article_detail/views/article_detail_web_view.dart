import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../data/models/article.dart';
import '../controllers/article_detail_controller.dart';

class ArticleDetailWebView extends GetView<ArticleDetailController> {
  final Article article;

  const ArticleDetailWebView({
    Key? key,
    required this.article,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("WebView"),
      ),
      body: WebViewWidget(
        controller: controller.initializeWebView(article.url),
      ),
    );
  }
}
