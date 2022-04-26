import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';

import 'package:deteccion_zonas_dengue_desktop/providers/providers.dart';
import 'package:deteccion_zonas_dengue_desktop/shared_preferences/preferences.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.scrollable(
      header: const PageHeader(title: Text('Ajustes')),
      children: [
        Text(
          'Tema de la aplicación',
          style: FluentTheme.of(context).typography.subtitle,
        ),

        const SizedBox(height: 10),

        // Light mode button
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: RadioButton(
            checked: !Preferences.isDarkMode,
            onChanged: (value) {
              Preferences.isDarkMode = !value;

              final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
              value ? themeProvider.setLightMode() : themeProvider.setDarkMode();

              setState(() {});
            },
            content: const Text('Claro'),
          ),
        ),

        // Dark mode button
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: RadioButton(
            checked: Preferences.isDarkMode,
            onChanged: (value) {
              Preferences.isDarkMode = value;

              final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
              value ? themeProvider.setDarkMode() : themeProvider.setLightMode();

              setState(() {});
            },
            content: const Text('Oscuro'),
          ),
        ),
      ],
    );
  }
}
