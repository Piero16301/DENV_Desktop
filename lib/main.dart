import 'package:fluent_ui/fluent_ui.dart';

import 'package:deteccion_zonas_dengue_desktop/sources/pages/pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FluentApp(
      debugShowCheckedModeBanner: false,
      title: 'DENV',
      initialRoute: 'home',
      routes: {
        'home'       : (BuildContext context) => const HomePage(),
        'data_table' : (BuildContext context) => const DataTablePage(),
      },
      theme: ThemeData.dark(),
    );
  }
}
