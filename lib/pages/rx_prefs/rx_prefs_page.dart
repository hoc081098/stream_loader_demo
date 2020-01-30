import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';
import 'package:rx_shared_preferences/rx_shared_preferences.dart';
import 'package:stream_loader/stream_loader.dart';

class RxPrefsPage extends StatelessWidget {
  static const routeName = '/rx_prefs';

  static const keyListStrings = 'com.hoc.strings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rx Prefs'),
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        child: LoaderWidget<List<String>>(
          blocProvider: () => LoaderBloc(
            loaderFunction: () => RxSharedPreferences.getInstance()
                .getStringListStream(keyListStrings)
                .map((strings) => strings ?? []),
            initialContent: [],
            enableLogger: true,
          ),
          builder: (context, state, bloc) {
            if (state.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            final strings = state.content;

            if (strings.isEmpty) {
              return Center(
                child: Text(
                  'Empty list',
                  style: Theme.of(context).textTheme.title,
                ),
              );
            }

            return ListView.builder(
              itemCount: strings.length,
              itemBuilder: (context, index) {
                final item = strings[index];

                return ListTile(
                  title: Text(item),
                  trailing: IconButton(
                    icon: Icon(Icons.remove_circle),
                    onPressed: () => remove(item),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: add,
        child: Icon(Icons.add),
      ),
    );
  }

  void add() async {
    final currentList =
        await RxSharedPreferences.getInstance().getStringList(keyListStrings);
    final newItem = randomString(10);
    final newList = [...?currentList, newItem];
    await RxSharedPreferences.getInstance().setStringList(
      keyListStrings,
      newList,
    );
  }

  void remove(String item) async {
    final currentList =
        await RxSharedPreferences.getInstance().getStringList(keyListStrings);
    final newList = currentList.where((i) => i != item).toList();
    await RxSharedPreferences.getInstance().setStringList(
      keyListStrings,
      newList,
    );
  }
}
