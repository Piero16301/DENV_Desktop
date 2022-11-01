import 'package:denv_desktop/home/home.dart';
import 'package:denv_desktop/inspection_map/inspection_map.dart';
import 'package:denv_desktop/inspection_table/inspection_table.dart';
import 'package:denv_desktop/l10n/l10n.dart';
import 'package:denv_desktop/settings/settings.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lorem/flutter_lorem.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final homeInspectionFunctions = <List<String>>[
      [
        'Tabla de registros',
        'assets/images/no-image.png',
        lorem(paragraphs: 1, words: 200),
      ],
      [
        'Mapa en tiempo real',
        'assets/images/no-image.png',
        lorem(paragraphs: 1, words: 200),
      ],
      [
        'Clusterización en tiempo real',
        'assets/images/no-image.png',
        lorem(paragraphs: 1, words: 200),
      ],
    ];

    return NavigationView(
      appBar: NavigationAppBar(
        title: DefaultTextStyle(
          style: FluentTheme.of(context).typography.subtitle!,
          child: Text(l10n.homePageAppBarTitle),
        ),
        automaticallyImplyLeading: false,
      ),
      pane: NavigationPane(
        selected: context.select((HomeCubit cubit) => cubit.state.paneIndex),
        onChanged: context.read<HomeCubit>().changePane,
        items: [
          PaneItemExpander(
            icon: const Icon(FluentIcons.home_verify),
            title: Text(l10n.homePageHomeInspectionTitle),
            body: ScaffoldPage(
              header: PageHeader(
                title: Text(l10n.homePageHomeInspectionTitle),
                // commandBar: ConstrainedBox(
                //   constraints: const BoxConstraints(maxWidth: 200),
                //   child: CommandBarCard(
                //     child: CommandBar(
                //       mainAxisAlignment: MainAxisAlignment.end,
                //       primaryItems: [
                //         CommandBarButton(
                //           icon: const Icon(FluentIcons.a_a_d_logo),
                //           label: const Text('AAD'),
                //           onPressed: () {},
                //         ),
                //         CommandBarButton(
                //           icon: const Icon(FluentIcons.a_a_d_logo),
                //           label: const Text('AAD'),
                //           onPressed: () {},
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
              ),
              content: Padding(
                padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
                child: GridView.count(
                  crossAxisCount: 3,
                  crossAxisSpacing: 25,
                  mainAxisSpacing: 25,
                  childAspectRatio: 0.6,
                  children: homeInspectionFunctions
                      .map(
                        (e) => Card(
                          borderRadius: BorderRadius.circular(10),
                          child: Column(
                            children: [
                              Text(
                                e[0],
                                style:
                                    FluentTheme.of(context).typography.subtitle,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 20),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 50,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                    e[1],
                                    width: double.infinity,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 20),
                                    child: Text(
                                      e[2],
                                      textAlign: TextAlign.justify,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
            items: [
              PaneItem(
                icon: const Icon(FluentIcons.table),
                title: Text(l10n.inspectionTableAppBarTitle),
                body: const InspectionTablePage(),
              ),
              PaneItem(
                icon: const Icon(FluentIcons.nav2_d_map_view),
                title: Text(l10n.inspectionMapAppBarTitle),
                body: const InspectionMapPage(),
              ),
            ],
          ),
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
