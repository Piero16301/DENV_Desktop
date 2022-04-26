import 'package:fluent_ui/fluent_ui.dart';

import 'package:deteccion_zonas_dengue_desktop/pages/pages.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      appBar: NavigationAppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: DefaultTextStyle(
            style: FluentTheme.of(context).typography.title!,
            child: const Text('DENV'),
          ),
        ),
        leading: const Center(
          child: Image(
            image: AssetImage('assets/app_icon.png'),
            fit: BoxFit.fill,
          ),
        ),
      ),
      pane: NavigationPane(
        header: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: DefaultTextStyle(
            style: FluentTheme.of(context).typography.bodyLarge!,
            child: const Text('Herramientas'),
          ),
        ),
        items: [
          PaneItem(
            icon: const Icon(FluentIcons.table),
            title: const Text('Tabla de reportes'),
          ),
          PaneItem(
              icon: const Icon(FluentIcons.nav2_d_map_view),
              title: const Text('Mapa de reportes'),
          ),
        ],
        selected: _currentPage,
        displayMode: PaneDisplayMode.auto,
        onChanged: (i) {
          setState(() {
            _currentPage = i;
          });
        },
        footerItems: [
          PaneItemSeparator(),
          PaneItem(
            icon: const Icon(FluentIcons.settings),
            title: const Text('Ajustes'),
          ),
        ],
      ),
      content: NavigationBody(
        index: _currentPage,
        children: const [
          DataTablePage(),
          MapReportsPage(),
          SettingsPage(),
        ],
      ),
    );
  }
}
