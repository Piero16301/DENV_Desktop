import 'package:denv_desktop/inspection_table/inspection_table.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InspectionTableView extends StatelessWidget {
  const InspectionTableView({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<InspectionTableCubit>().getHomeInspections();

    return BlocConsumer<InspectionTableCubit, InspectionTableState>(
      listener: (context, state) {
        if (state.exportStatus == InspectionExportStatus.success) {
          context.read<InspectionTableCubit>().resetExportStatus();
          showExportDialog(context: context, isSuccess: true);
        } else if (state.exportStatus == InspectionExportStatus.failure) {
          context.read<InspectionTableCubit>().resetExportStatus();
          showExportDialog(context: context, isSuccess: false);
        }
      },
      builder: (context, state) {
        if (state.status.isLoading) {
          return const InspectionTableLoading();
        } else if (state.status.isSuccess) {
          if (state.homeInspections.isEmpty) {
            return const InspectionTableEmpty();
          }
          return InspectionTableWidget(
            homeInspections: state.homeInspections,
          );
        } else if (state.status.isFailure) {
          return const InspectionTableError();
        }
        return const SizedBox.shrink();
      },
    );
  }

  Future<void> showExportDialog({
    required BuildContext context,
    required bool isSuccess,
  }) async {
    await showDialog<void>(
      context: context,
      builder: (context) {
        if (isSuccess) {
          return const SuccessDialog();
        } else {
          return const FailureDialog();
        }
      },
    );
  }
}
