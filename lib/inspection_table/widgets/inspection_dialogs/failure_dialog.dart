import 'package:denv_desktop/inspection_table/inspection_table.dart';
import 'package:denv_desktop/l10n/l10n.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FailureDialog extends StatelessWidget {
  const FailureDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final inspecionCubit = context.read<InspectionTableCubit>();
    final dataGridKey = context.select(
      (InspectionTableState state) => state.dataGridKey,
    );
    final l10n = context.l10n;

    return ContentDialog(
      title: Text(l10n.inspectionTableExportFailureTitleDialog),
      content: Text(l10n.inspectionTableExportFailureContentDialog),
      actions: [
        Button(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.inspectionTableExportFailureCancelButton),
        ),
        FilledButton(
          onPressed: () => inspecionCubit.exportHomeInspectionsExcel(
            dataGridKey: dataGridKey!,
            context: context,
          ),
          child: Text(l10n.inspectionTableExportFailureRetryButton),
        ),
      ],
    );
  }
}
