import 'package:denv_desktop/app/app.dart';
import 'package:denv_desktop/inspection_map/inspection_map.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InspectionMapError extends StatelessWidget {
  const InspectionMapError({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.select(
      (AppCubit cubit) => cubit.state.isDarkMode,
    );
    final inspectionCubit = context.read<InspectionMapCubit>();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Failed to load inspections',
          style: FluentTheme.of(context).typography.subtitle,
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: 150,
          child: FilledButton(
            onPressed: () => inspectionCubit.getHomeInspections(
              isDarkMode: isDarkMode,
            ),
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    FluentIcons.refresh,
                    size: 25,
                    color: isDarkMode
                        ? const Color.fromARGB(255, 39, 39, 39)
                        : Colors.white,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Retry',
                    style:
                        FluentTheme.of(context).typography.bodyStrong!.copyWith(
                              color: isDarkMode
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
