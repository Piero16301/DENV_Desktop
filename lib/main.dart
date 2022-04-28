import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';

import 'package:deteccion_zonas_dengue_desktop/shared_preferences/preferences.dart';
import 'package:deteccion_zonas_dengue_desktop/providers/providers.dart';
import 'package:deteccion_zonas_dengue_desktop/pages/pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Preferences.init();

  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ( _ ) => ThemeProvider(isDarkMode: Preferences.isDarkMode)),
        ChangeNotifierProvider(create: ( _ ) => PointsProvider()),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FluentApp(
      debugShowCheckedModeBanner: false,
      builder: (context, child) => MediaQuery(data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true), child: child!),
      title: 'DENV',
      initialRoute: 'home',
      routes: {
        'home'       : (BuildContext context) => const HomePage(),
        'data_table' : (BuildContext context) => const DataTablePage(),
      },
      theme: Provider.of<ThemeProvider>(context).currentTheme,
    );
  }
}
