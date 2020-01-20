import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:stream_loader/stream_loader.dart';
import 'package:stream_loader_demo/country.dart';
import 'package:built_collection/built_collection.dart';

void main() => runApp(MyApp());

Stream<BuiltList<Country>> getCountries() async* {
  final response = await http.get('http://country.io/names.json');
  if (response.statusCode != HttpStatus.ok) {
    throw Exception(
        'Get countries not success, with status code: ${response.statusCode} and body: ${response.body}');
  }
  var json = jsonDecode(response.body) as Map<String, dynamic>;
  var countries = json.entries
      .map(
        (entry) => Country(
          (b) => b
            ..name = entry.value
            ..code = entry.key,
        ),
      )
      .toList();
  yield BuiltList.of(countries);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'stream_loader demo',
      theme: ThemeData(
        fontFamily: 'GoogleSans',
        primarySwatch: Colors.red,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: LoaderWidget<BuiltList<Country>>(
        blocProvider: () => LoaderBloc(
          loaderFunction: getCountries,
          refresherFunction: getCountries,
          initialContent: BuiltList.of([]),
        ),
        messageHandler: messageHandler,
        builder: (context, state, bloc) {
          if (state.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    state.error.toString(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.subtitle,
                  ),
                  RaisedButton(
                    onPressed: bloc.fetch,
                    padding: const EdgeInsets.all(16),
                    child: Text('Retry'),
                    color: Theme.of(context).accentColor,
                  ),
                ],
              ),
            );
          }

          var countries = state.content;
          return RefreshIndicator(
            onRefresh: bloc.refresh,
            child: ListView.builder(
              itemCount: countries.length,
              itemBuilder: (context, index) {
                var country = countries[index];
                return ListTile(
                  leading: Image.network(
                      'https://www.countryflags.io/${country.code.toLowerCase()}/shiny/64.png'),
                  title: Text(country.name),
                  subtitle: Text(country.code),
                );
              },
            ),
          );
        },
      ),
    );
  }

  void messageHandler(
    LoaderMessage<BuiltList<Country>> message,
    LoaderBloc<BuiltList<Country>> bloc,
  ) {
    void showSnackBar(String message) {
      scaffoldKey.currentState?.showSnackBar(
        SnackBar(
          content: Text(message),
          duration: const Duration(seconds: 1),
        ),
      );
    }

    message.fold(
      onFetchFailure: null,
      onFetchSuccess: null,
      onRefreshFailure: null,
      onRefreshSuccess: (_) => showSnackBar('Refresh success'),
    );
  }
}
