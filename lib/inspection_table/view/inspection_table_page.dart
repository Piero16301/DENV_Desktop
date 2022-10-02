import 'package:denv_desktop/inspection_table/inspection_table.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inspection_repository/inspection_repository.dart';

class InspectionTablePage extends StatelessWidget {
  const InspectionTablePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => InspectionTableCubit(context.read<InspectionRepository>()),
      child: const InspectionTableView(),
    );
  }
}
