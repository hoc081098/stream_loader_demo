import 'package:distinct_value_connectable_stream/distinct_value_connectable_stream.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stream_loader/stream_loader.dart';

part 'models.dart';

class CountDownNewYearPage extends StatelessWidget {
  static const routeName = '/count_down_new_year';
  static final newYear = DateTime(2021, DateTime.january, 1);

  final stream = Stream.periodic(const Duration(milliseconds: 500))
      .map((_) => newYear.difference(DateTime.now()))
      .map(_formatDuration)
      .shareValueDistinct(null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Happy new year'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/new_year_2021.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.65),
              BlendMode.darken,
            ),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: Container(
          child: LoaderWidget<_HMS>(
            blocProvider: () => LoaderBloc(
              loaderFunction: () => stream,
              logger: print,
            ),
            builder: (context, state, _) {
              if (state.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ScreenTypeLayout(
                tablet: _CountDownTablet(data: state.content),
                mobile: _CountDownMobile(data: state.content),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _CountDownTablet extends StatelessWidget {
  final _HMS data;

  const _CountDownTablet({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.headline4.copyWith(
          fontSize: 64,
          color: Theme.of(context).accentColor,
        );
    final style2 = Theme.of(context).textTheme.headline4.copyWith(
          fontSize: 48,
          fontWeight: FontWeight.w500,
        );

    return Center(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                data.hours,
                style: style,
              ),
              const SizedBox(height: 16),
              Text(
                'HOURS',
                style: style2,
              ),
            ],
          ),
          const SizedBox(width: 32),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                data.minutes,
                style: style,
              ),
              const SizedBox(height: 16),
              Text(
                'MINUTES',
                style: style2,
              ),
            ],
          ),
          const SizedBox(width: 32),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                data.seconds,
                style: style,
              ),
              const SizedBox(height: 16),
              Text(
                'SECONDS',
                style: style2,
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _CountDownMobile extends StatelessWidget {
  final _HMS data;

  const _CountDownMobile({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.headline4.copyWith(
          fontSize: 64,
          color: Theme.of(context).accentColor,
        );
    final style2 = Theme.of(context).textTheme.headline4.copyWith(
          fontSize: 48,
          fontWeight: FontWeight.w500,
        );
    final style3 = style2.copyWith(fontSize: 32);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                data.hours,
                style: style,
              ),
              const SizedBox(width: 8),
              Text(
                'HOURS',
                style: style3,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                data.minutes,
                style: style,
              ),
              const SizedBox(width: 8),
              Text(
                'MINUTES',
                style: style3,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                data.seconds,
                style: style,
              ),
              const SizedBox(width: 8),
              Text(
                'SECONDS',
                style: style3,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
