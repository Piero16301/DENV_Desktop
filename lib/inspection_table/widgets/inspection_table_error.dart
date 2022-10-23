import 'package:denv_desktop/app/app.dart';
import 'package:denv_desktop/inspection_table/inspection_table.dart';
import 'package:denv_desktop/l10n/l10n.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InspectionTableError extends StatelessWidget {
  const InspectionTableError({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkThemeOn = context.select(
      (AppCubit cubit) => cubit.state.isDarkMode,
    );
    final inspectionCubit = context.read<InspectionTableCubit>();
    final l10n = context.l10n;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          l10n.inspectionTableErrorText,
          style: FluentTheme.of(context).typography.subtitle,
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: 150,
          child: FilledButton(
            onPressed: inspectionCubit.getHomeInspections,
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    FluentIcons.sync,
                    size: 25,
                    color: isDarkThemeOn
                        ? const Color.fromARGB(255, 39, 39, 39)
                        : Colors.white,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    l10n.inspectionTableErrorUpdate,
                    style:
                        FluentTheme.of(context).typography.bodyStrong!.copyWith(
                              color: isDarkThemeOn
                                  ? const Color.fromARGB(255, 39, 39, 39)
                                  : Colors.white,
                            ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
