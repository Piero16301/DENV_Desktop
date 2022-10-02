import 'package:denv_desktop/app/app.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inspection_repository/inspection_repository.dart';

class AppPage extends StatelessWidget {
  const AppPage({
    super.key,
    required InspectionRepository inspectionRepository,
  }) : _inspectionRepository = inspectionRepository;

  final InspectionRepository _inspectionRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _inspectionRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => AppCubit()),
        ],
        child: const AppView(),
      ),
    );
  }
}
