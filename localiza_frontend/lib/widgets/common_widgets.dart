import 'package:flutter/material.dart';

Widget loadingWidget() {
  return const Center(child: CircularProgressIndicator());
}

Widget errorWidget(String message) {
  return Center(
    child: Text(
      "Erro: $message",
      style: const TextStyle(color: Colors.red, fontSize: 18),
    ),
  );
}

Widget emptyWidget(String message) {
  return Center(
    child: Text(
      message,
      style: const TextStyle(fontSize: 18, color: Colors.grey),
    ),
  );
}
