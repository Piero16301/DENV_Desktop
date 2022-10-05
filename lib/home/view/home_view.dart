import 'package:denv_desktop/app/app.dart';
import 'package:denv_desktop/home/home.dart';
import 'package:denv_desktop/inspection_table/inspection_table.dart';
import 'package:denv_desktop/l10n/l10n.dart';
import 'package:denv_desktop/settings/settings.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return NavigationView(
      appBar: NavigationAppBar(
        title: DefaultTextStyle(
          style: FluentTheme.of(context).typography.subtitle!,
          child: Text(l10n.homePageAppBarTitle),
        ),
      ),
      pane: NavigationPane(
        selected: context.select((HomeCubit cubit) => cubit.state.paneIndex),
        onChanged: context.read<HomeCubit>().changePane,
        items: [
          PaneItem(
            icon: const Icon(FluentIcons.table),
            title: Text(l10n.inspectionTableAppBarTitle),
            body: const InspectionTablePage(),
          ),
          // PaneItem(
          //   icon: const Icon(FluentIcons.chart),
          //   title: const Text('Chart'),
          //   body: const CounterText(),
          // ),
          // PaneItem(
          //   icon: const Icon(FluentIcons.settings),
          //   title: const Text('Settings'),
          //   body: const CounterText(),
          // ),
        ],
        footerItems: [
          PaneItem(
            icon: const Icon(FluentIcons.settings),
            title: Text(l10n.settingsPageAppBarTitle),
            body: const SettingsPage(),
          ),
        ],
      ),
    );
  }
}
