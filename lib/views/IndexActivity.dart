import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:share/share.dart';
import '../views/FoodFragment.dart';

class IndexActivity extends StatefulWidget {
  @override
  _IndexActivityState createState() => _IndexActivityState();
}

class _IndexActivityState extends State<IndexActivity> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  String url = 'https://franfood.herokuapp.com/';
  int _currentIndex = 0;
  List<Widget> _children = [FoodFragment(), FoodFragment(), FoodFragment()];

  void _changeIndex(index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: _children[_currentIndex],
      bottomNavigationBar: bottomNavigationBar(),
    );
  }

  AppBar appBar() {
    return AppBar(
      title: Text("Fran Food"),
      leading: Icon(Icons.fastfood),
      backgroundColor: Colors.red[900],
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.share),
          onPressed: () {
            final RenderBox box = context.findRenderObject();
            Share.share(url,
                subject: url,
                sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
          },
        ),
      ],
    );
  }

  BottomNavigationBar bottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: _changeIndex,
      backgroundColor: Colors.red[900],
      selectedItemColor: Colors.white,
      elevation: 8.0,
      showUnselectedLabels: false,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.room_service),
          title: Text('Lanches'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.local_drink),
          title: Text('Bebidas'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.restaurant),
          title: Text('Combos'),
        ),
      ],
    );
  }

  // Página de apresentação funcional
  WebviewScaffold homeWebView() {
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
        initialChild: Center(
          child: CircularProgressIndicator(),
        ),
        appBar: appBar());
  }
}
