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
      children: [
        Text(
          'Tema de la aplicación',
          style: FluentTheme.of(context).typography.subtitle,
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: RadioButton(
            checked: !context.select(
              (AppCubit cubit) => cubit.state.isDarkThemeOn,
            ),
            onChanged: (value) {
              if (value) {
                context.read<SettingsCubit>().changeTheme(
                      lightValue: value,
                      darkValue: !value,
                    );
                context.read<AppCubit>().changeTheme(darkValue: !value);
              }
            },
            content: const Text('Tema claro'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: RadioButton(
            checked: context.select(
              (AppCubit cubit) => cubit.state.isDarkThemeOn,
            ),
            onChanged: (value) {
              if (value) {
                context.read<SettingsCubit>().changeTheme(
                      lightValue: !value,
                      darkValue: value,
                    );
                context.read<AppCubit>().changeTheme(darkValue: value);
              }
            },
            content: const Text('Tema oscuro'),
          ),
        ),
      ],
    );
  }
}
