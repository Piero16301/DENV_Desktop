import 'package:denv_desktop/inspection_table/inspection_table.dart';
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

    return ContentDialog(
      title: const Text('Error al exportar'),
      content: const Text('Ocurrió un error al exportar el archivo'),
      actions: [
        Button(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        FilledButton(
          onPressed: () => inspecionCubit.exportHomeInspectionsExcel(
            dataGridKey!,
          ),
          child: const Text('Reintentar'),
        ),
      ],
    );
  }
}
