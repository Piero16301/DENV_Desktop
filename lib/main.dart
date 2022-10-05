import 'package:denv_desktop/app/app.dart';
import 'package:denv_desktop/bootstrap.dart';
import 'package:dio/dio.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:inspection_api_remote/inspection_api_remote.dart';
import 'package:inspection_repository/inspection_repository.dart';
import 'package:local_api_remote/local_api_remote.dart';
import 'package:local_repository/local_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  bootstrap(() async {
    await dotenv.load(fileName: './.env');
    WidgetsFlutterBinding.ensureInitialized();
    final preferences = await SharedPreferences.getInstance();
    final httpClient = Dio(
      BaseOptions(
        baseUrl: dotenv.get('BACKEND_URL'),
        connectTimeout: 3000,
        receiveTimeout: 3000,
      ),
    );

    final inspectionApi = InspectionApiRemote(httpClient: httpClient);
    final inspectionRepository = InspectionRepository(apiRemote: inspectionApi);

    final localApi = LocalApiRemote(preferences: preferences);
    final localRepository = LocalRepository(apiRemote: localApi);

    return AppPage(
      inspectionRepository: inspectionRepository,
      localRepository: localRepository,
    );
  });
}
