import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:share/share.dart';

class IndexActivity extends StatefulWidget {
  @override
  _IndexActivityState createState() => _IndexActivityState();
}

class _IndexActivityState extends State<IndexActivity> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  String url = 'https://franfood.herokuapp.com/';

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      key: _globalKey,
      debuggingEnabled: false,
      withJavascript: true,
      scrollBar: false,
      appCacheEnabled: true,
      withOverviewMode: true,
      ignoreSSLErrors: true,
      withLocalStorage: true,
      useWideViewPort: true,
      url: url,
      initialChild: Center(child: CircularProgressIndicator(),),
      appBar: AppBar(
        title: Text("Fran Food App"),
        backgroundColor: Colors.black,
        leading: Icon(Icons.fastfood),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              final RenderBox box = context.findRenderObject();
              Share.share(url,
                  subject: url,
                  sharePositionOrigin:
                  box.localToGlobal(Offset.zero) &
                  box.size);
            },
          ),
        ],
      ),
    );
  }

  Container _contactBottomSheet(ctx) {
    return Container(
      child: Text('Container Bottom sheet'),
    );
  }

}

