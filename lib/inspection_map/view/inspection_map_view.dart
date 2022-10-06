import 'package:denv_desktop/app/app.dart';
import 'package:denv_desktop/inspection_map/inspection_map.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InspectionMapView extends StatelessWidget {
  const InspectionMapView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.select(
      (AppCubit cubit) => cubit.state.isDarkMode,
    );
    context.read<InspectionMapCubit>().getHomeInspections(
          isDarkMode: isDarkMode,
        );

    return BlocBuilder<InspectionMapCubit, InspectionMapState>(
      builder: (context, state) {
        if (state.status.isLoading) {
          return const InspectionMapLoading();
        } else if (state.status.isSuccess) {
          if (state.homeInspections.isEmpty) {
            return const InspectionMapEmpty();
          }
          return InspectionMapWidget(
            homeInspections: state.homeInspections,
          );
        } else if (state.status.isFailure) {
          return const InspectionMapError();
        }
        return const SizedBox.shrink();
      },
    );
  }
}
