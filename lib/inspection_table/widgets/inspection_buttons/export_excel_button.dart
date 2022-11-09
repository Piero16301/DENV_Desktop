import 'package:denv_desktop/app/app.dart';
import 'package:denv_desktop/inspection_table/inspection_table.dart';
import 'package:denv_desktop/l10n/l10n.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ExportExcelButton extends StatelessWidget {
  const ExportExcelButton({
    super.key,
    required this.dataGridKey,
  });

  final GlobalKey<SfDataGridState> dataGridKey;

  @override
  Widget build(BuildContext context) {
    final isDarkThemeOn = context.select(
      (AppCubit cubit) => cubit.state.isDarkMode,
    );
    final exportStatus =
        context.select<InspectionTableCubit, InspectionExportStatus>(
      (cubit) => cubit.state.exportStatus,
    );
    final l10n = context.l10n;

    return FilledButton(
      onPressed: () =>
          context.read<InspectionTableCubit>().exportHomeInspectionsExcel(
                dataGridKey: dataGridKey,
                context: context,
              ),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Row(
          children: [
            if (exportStatus == InspectionExportStatus.loading)
              const SizedBox.square(dimension: 25, child: ProgressRing())
            else
              Icon(
                FluentIcons.excel_logo,
                size: 25,
                color: isDarkThemeOn
                    ? const Color.fromARGB(255, 39, 39, 39)
                    : Colors.white,
              ),
            const SizedBox(width: 10),
            if (exportStatus == InspectionExportStatus.loading)
              Text(
                l10n.inspectionTableExportToExcelLoading,
                style: FluentTheme.of(context).typography.bodyStrong!.copyWith(
                      color: isDarkThemeOn
                          ? const Color.fromARGB(255, 39, 39, 39)
                          : Colors.white,
                    ),
              )
            else
              Text(
                l10n.inspectionTableExportToExcel,
                style: FluentTheme.of(context).typography.bodyStrong!.copyWith(
                      color: isDarkThemeOn
                          ? const Color.fromARGB(255, 39, 39, 39)
                          : Colors.white,
                    ),
              ),
          ],
        ),
      ),
    );
  }
}
