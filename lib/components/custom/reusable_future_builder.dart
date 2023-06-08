import 'package:flutter/material.dart';

class ReusableFutureBuilder<T> extends StatelessWidget {
  const ReusableFutureBuilder({
    Key? key,
    required this.future,
    required this.builder,
    this.loadingWidget,
    this.errorWidget,
  }) : super(key: key);

  final Future<List<T>> future;
  final AsyncWidgetBuilder<List<T>> builder;
  final Widget? loadingWidget;
  final Widget? errorWidget;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<T>>(
      future: future,
      builder: (BuildContext context, AsyncSnapshot<List<T>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return loadingWidget ?? const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return errorWidget ?? Text('Error: ${snapshot.error}');
        } else {
          return builder(context, snapshot);
        }
      },
    );
  }
}