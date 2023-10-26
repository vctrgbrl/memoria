import 'package:flutter/material.dart';
import 'routes/routes.dart';

import 'views/home_page.dart';

void main() {
  runApp(
    MaterialApp(
      routes: Routes.routes,
      home: const HomePage(),
      title: "Memória",
    )
  );
}