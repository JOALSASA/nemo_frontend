import 'package:flutter/material.dart';

class SombraDefault extends BoxShadow {
  const SombraDefault()
      : super(
          offset: const Offset(0, 4),
          blurRadius: 7,
          spreadRadius: 2,
          color: const Color.fromRGBO(0, 0, 0, 0.07),
        );
}
