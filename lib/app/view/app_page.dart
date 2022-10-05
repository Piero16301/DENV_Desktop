import 'package:denv_desktop/app/app.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inspection_repository/inspection_repository.dart';
import 'package:local_repository/local_repository.dart';

class AppPage extends StatelessWidget {
  const AppPage({
    super.key,
    required InspectionRepository inspectionRepository,
    required LocalRepository localRepository,
  })  : _inspectionRepository = inspectionRepository,
        _localRepository = localRepository;

  final InspectionRepository _inspectionRepository;
  final LocalRepository _localRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _inspectionRepository),
        RepositoryProvider.value(value: _localRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => AppCubit(
              appTheme: _localRepository.isDarkMode()
                  ? ThemeData.dark()
                  : ThemeData.light(),
              locale: Locale(_localRepository.getLanguage()),
              localRepository: _localRepository,
            ),
          ),
        ],
        child: const AppView(),
      ),
    );
  }
}
