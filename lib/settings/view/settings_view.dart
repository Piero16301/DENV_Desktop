import 'package:denv_desktop/app/app.dart';
import 'package:denv_desktop/settings/settings.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.scrollable(
      header: const PageHeader(
        title: Text('Ajustes'),
      ),
      children: const [
        AppThemeRadioButtons(),
        AppLocaleRadioButtons(),
      ],
    );
  }
}

class AppThemeRadioButtons extends StatelessWidget {
  const AppThemeRadioButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final isLightTheme = context.select<SettingsCubit, bool>(
      (cubit) => cubit.state.isLightThemeOn,
    );
    final isDarkTheme = context.select<SettingsCubit, bool>(
      (cubit) => cubit.state.isDarkThemeOn,
    );
    final appCubit = context.read<AppCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: Text(
            'Tema de la aplicación',
            style: FluentTheme.of(context).typography.subtitle,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: RadioButton(
            checked: isLightTheme,
            onChanged: (value) {
              if (value) {
                context.read<SettingsCubit>().changeTheme(
                      lightValue: value,
                      darkValue: !value,
                    );
                appCubit.changeTheme(ThemeData.light());
              }
            },
            content: const Text('Tema claro'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: RadioButton(
            checked: isDarkTheme,
            onChanged: (value) {
              if (value) {
                context.read<SettingsCubit>().changeTheme(
                      lightValue: !value,
                      darkValue: value,
                    );
                appCubit.changeTheme(ThemeData.dark());
              }
            },
            content: const Text('Tema oscuro'),
          ),
        ),
      ],
    );
  }
}

class AppLocaleRadioButtons extends StatelessWidget {
  const AppLocaleRadioButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final isSpanishLocale = context.select<AppCubit, Locale>(
          (cubit) => cubit.state.locale ?? const Locale('es'),
        ) ==
        const Locale('es');
    final isEnglishLocale = context.select<AppCubit, Locale>(
          (cubit) => cubit.state.locale ?? const Locale('es'),
        ) ==
        const Locale('en');
    final appCubit = context.read<AppCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: Text(
            'Idioma de la aplicación',
            style: FluentTheme.of(context).typography.subtitle,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: RadioButton(
            checked: isSpanishLocale,
            onChanged: (value) {
              if (value) {
                context.read<SettingsCubit>().changeLocale(
                      spanishValue: value,
                      englishValue: !value,
                    );
                appCubit.changeLocale(const Locale('es'));
              }
            },
            content: const Text('Español'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: RadioButton(
            checked: isEnglishLocale,
            onChanged: (value) {
              if (value) {
                context.read<SettingsCubit>().changeLocale(
                      spanishValue: !value,
                      englishValue: value,
                    );
                appCubit.changeLocale(const Locale('en'));
              }
            },
            content: const Text('Inglés'),
          ),
        ),
      ],
    );
  }
}
