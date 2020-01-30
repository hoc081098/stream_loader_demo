import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stream_loader_demo/pages/count_down/count_down_new_year_page.dart';
import 'package:stream_loader_demo/pages/fetch_json/fetch_json_page.dart';
import 'package:stream_loader_demo/pages/rx_prefs/rx_prefs_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'stream_loader demo',
      theme: ThemeData(
        fontFamily: 'GoogleSans',
        brightness: Brightness.dark,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
      routes: <String, WidgetBuilder>{
        FetchJsonPage.routeName: (context) => FetchJsonPage(),
        CountDownNewYearPage.routeName: (context) => CountDownNewYearPage(),
        RxPrefsPage.routeName: (context) => RxPrefsPage(),
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('stream_loader examples'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              HomeButton(
                title: 'Fetch json',
                routeName: FetchJsonPage.routeName,
              ),
              HomeButton(
                title: 'Count down new year',
                routeName: CountDownNewYearPage.routeName,
              ),
              HomeButton(
                title: 'rx_shared_preferences',
                routeName: RxPrefsPage.routeName,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeButton extends StatelessWidget {
  final String title;
  final String routeName;

  const HomeButton({
    Key key,
    @required this.title,
    @required this.routeName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final rectangleBorder = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    );
    const margin = EdgeInsets.symmetric(vertical: 12);
    const padding = EdgeInsets.symmetric(vertical: 16);
    final titleStyle = Theme.of(context).textTheme.button.copyWith(
          color: Theme.of(context).primaryColor,
        );

    return Container(
      width: width / 2,
      margin: margin,
      child: RaisedButton(
        child: Text(
          title,
          style: titleStyle,
        ),
        onPressed: () => Navigator.pushNamed(context, routeName),
        color: Theme.of(context).accentColor,
        padding: padding,
        shape: rectangleBorder,
      ),
    );
  }
}
