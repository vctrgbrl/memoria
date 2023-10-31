import 'package:flutter/material.dart';
import 'package:memoria/views/home_page.dart';
import 'routes/routes.dart';

void main() {
  runApp(
    MaterialApp(
      routes: Routes.routes,
      home: const HomePage(),
      title: "Memória",
    )
  );
}