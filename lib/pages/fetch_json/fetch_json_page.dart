import 'dart:convert';
import 'dart:io';

import 'package:built_collection/built_collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:stream_loader/stream_loader.dart';
import 'package:stream_loader_demo/pages/fetch_json/country.dart';

Stream<BuiltList<Country>> getCountries() async* {
  final response = await http
      .get('https://restcountries.eu/rest/v2/all?fields=name;alpha2Code;');
  if (response.statusCode != HttpStatus.ok) {
    throw Exception(
        'Get countries not success, with status code: ${response.statusCode} and body: ${response.body}');
  }
  final listOfMaps =
      (jsonDecode(response.body) as List).cast<Map<String, dynamic>>();
  yield listOfMaps
      .map(
        (json) => Country(
          (b) => b
            ..name = json['name']
            ..code = json['alpha2Code'],
        ),
      )
      .toBuiltList();
}

class FetchJsonPage extends StatelessWidget {
  static const routeName = '/fetch_json';

  FetchJsonPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: LoaderWidget<BuiltList<Country>>(
        blocProvider: () => LoaderBloc(
          loaderFunction: getCountries,
          refresherFunction: getCountries,
          initialContent: BuiltList.of([]),
        ),
        messageHandler: (msg, bloc) => messageHandler(msg, bloc, context),
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
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  const SizedBox(height: 12),
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

          final countries = state.content;
          return RefreshIndicator(
            onRefresh: bloc.refresh,
            child: ListView.builder(
              itemCount: countries.length,
              itemBuilder: (context, index) {
                final country = countries[index];
                return ListTile(
                  leading: Image.network(
                    'https://www.countryflags.io/${country.code.toLowerCase()}/shiny/64.png',
                    width: 64,
                    fit: BoxFit.cover,
                  ),
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
    BuildContext context,
  ) {
    void showSnackBar(String message) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          duration: const Duration(seconds: 1),
        ),
      );
    }

    message.fold(
      onFetchFailure: (e, s) {},
      onFetchSuccess: (d) {},
      onRefreshFailure: (e, s) {},
      onRefreshSuccess: (_) => showSnackBar('Refresh success'),
    );
  }
}
