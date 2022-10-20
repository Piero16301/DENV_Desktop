import 'package:denv_desktop/inspection_map/inspection_map.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inspection_repository/inspection_repository.dart';

class InspectionMapPage extends StatelessWidget {
  const InspectionMapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => InspectionMapCubit(context.read<InspectionRepository>()),
      child: const InspectionMapView(),
    );
  }
}
