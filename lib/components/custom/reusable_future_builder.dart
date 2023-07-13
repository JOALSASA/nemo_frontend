import 'package:flutter/material.dart';
import 'package:nemo_frontend/models/api_erro_dto.dart';

class ReusableFutureBuilder<T> extends StatelessWidget {
  const ReusableFutureBuilder({
    Key? key,
    required this.future,
    required this.builder,
    this.textColor,
    this.loadingWidget,
    this.errorWidget,
  }) : super(key: key);

  final Future<List<T>> future;
  final AsyncWidgetBuilder<List<T>> builder;
  final Color? textColor;
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
          if (snapshot.error is ApiErroDTO) {
            var obj = snapshot.error as ApiErroDTO;
            return Text(
              '${obj.mensagem}',
              style: const TextStyle(fontSize: 16),
            );
          }

          return errorWidget ?? Text('Error: ${snapshot.error}');
        }
        if (snapshot.data!.isEmpty) {
          return Text(
            'Não encontramos nenhum item',
            style: TextStyle(fontSize: 16, color: textColor),
          );
        }

        return builder(context, snapshot);
      },
    );
  }
}
