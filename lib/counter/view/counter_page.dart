import 'package:denv_desktop/counter/counter.dart';
import 'package:denv_desktop/l10n/l10n.dart';
import 'package:denv_desktop/settings/settings.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CounterCubit(),
      child: const CounterView(),
    );
  }
}

class CounterView extends StatelessWidget {
  const CounterView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return NavigationView(
      appBar: NavigationAppBar(title: Text(l10n.counterAppBarTitle)),
      pane: NavigationPane(
        selected: context.select((CounterCubit cubit) => cubit.state),
        onChanged: context.read<CounterCubit>().changePane,
        items: [
          PaneItem(
            icon: const Icon(FluentIcons.table),
            title: const Text('Table'),
            body: const CounterText(),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.chart),
            title: const Text('Chart'),
            body: const CounterText(),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.settings),
            title: const Text('Settings'),
            body: const CounterText(),
          ),
        ],
        footerItems: [
          PaneItem(
            icon: const Icon(FluentIcons.settings),
            title: const Text('Settings'),
            body: const SettingsPage(),
          ),
        ],
      ),
    );
  }
}

class CounterText extends StatelessWidget {
  const CounterText({super.key});

  @override
  Widget build(BuildContext context) {
    final page = context.select((CounterCubit cubit) => cubit.state);
    return Text('$page', style: const TextStyle(fontSize: 24));
  }
}
