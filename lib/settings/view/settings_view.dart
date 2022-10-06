import 'package:denv_desktop/app/app.dart';
import 'package:denv_desktop/l10n/l10n.dart';
import 'package:denv_desktop/settings/settings.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final isDarkMode = context.select<AppCubit, bool>(
      (cubit) => cubit.state.isDarkMode,
    );
    final locale = context.select<AppCubit, String>(
      (cubit) => cubit.state.locale,
    );

    context.read<SettingsCubit>().changeTheme(isDarkMode: isDarkMode);
    context.read<SettingsCubit>().changeLocale(locale: locale);

    return ScaffoldPage.scrollable(
      header: PageHeader(
        title: Text(l10n.settingsPageAppBarTitle),
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
    final isDarkTheme = context.select<SettingsCubit, bool>(
      (cubit) => cubit.state.isDarkMode,
    );
    final appCubit = context.read<AppCubit>();
    final l10n = context.l10n;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: Text(
            l10n.settingsPageAppThemeTitle,
            style: FluentTheme.of(context).typography.subtitle,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: RadioButton(
            checked: !isDarkTheme,
            onChanged: (value) {
              if (value) {
                context.read<SettingsCubit>().changeTheme(isDarkMode: false);
                appCubit.changeTheme(isDarkMode: false);
              }
            },
            content: Text(l10n.settingsPageAppThemeLight),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: RadioButton(
            checked: isDarkTheme,
            onChanged: (value) {
              if (value) {
                context.read<SettingsCubit>().changeTheme(isDarkMode: true);
                appCubit.changeTheme(isDarkMode: true);
              }
            },
            content: Text(l10n.settingsPageAppThemeDark),
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
    final isSpanishLocale = context.select<AppCubit, String>(
          (cubit) => cubit.state.locale,
        ) ==
        'es';
    final isEnglishLocale = context.select<AppCubit, String>(
          (cubit) => cubit.state.locale,
        ) ==
        'en';
    final appCubit = context.read<AppCubit>();
    final l10n = context.l10n;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: Text(
            l10n.settingsPageAppLanguageTitle,
            style: FluentTheme.of(context).typography.subtitle,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: RadioButton(
            checked: isSpanishLocale,
            onChanged: (value) {
              if (value) {
                context.read<SettingsCubit>().changeLocale(locale: 'es');
                appCubit.changeLocale('es');
              }
            },
            content: Text(l10n.settingsPageAppLanguageSpanish),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: RadioButton(
            checked: isEnglishLocale,
            onChanged: (value) {
              if (value) {
                context.read<SettingsCubit>().changeLocale(locale: 'en');
                appCubit.changeLocale('en');
              }
            },
            content: Text(l10n.settingsPageAppLanguageEnglish),
          ),
        ),
      ],
    );
  }
}
