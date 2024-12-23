import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentScreen extends StatefulWidget {
  final String url;

  const PaymentScreen({Key? key, required this.url}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {


  Future<bool> _onWillPop() async {
    Navigator.pop(context, 'unfinish');
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
       ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (request) {
            // Tangani navigasi, misalnya redirect URL
            if (request.url.contains('finish')) {
              // Tutup WebView dan kembali ke layar sebelumnya
              Navigator.pop(context, 'finish');
              return NavigationDecision.prevent;
            } else if (request.url.contains('failed')) {
              Navigator.pop(context, 'failed');
              return NavigationDecision.prevent;
            } else if (request.url.contains('unfinish')) {
              Navigator.pop(context, 'unfinish');
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
          body: SafeArea(
            child: WebViewWidget(
              controller: controller,
            ),
          ),
      ),
    );
  }
}
