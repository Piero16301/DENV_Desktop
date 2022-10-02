import 'package:denv_desktop/app/app.dart';
import 'package:denv_desktop/bootstrap.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:inspection_api_remote/inspection_api_remote.dart';
import 'package:inspection_repository/inspection_repository.dart';

void main() {
  bootstrap(() async {
    await dotenv.load(fileName: './.env');
    final httpClient = Dio(
      BaseOptions(
        baseUrl: dotenv.get('BACKEND_URL'),
        connectTimeout: 3000,
        receiveTimeout: 3000,
      ),
    );

    final inspectionApi = InspectionApiRemote(httpClient: httpClient);
    final inspectionRepository = InspectionRepository(apiRemote: inspectionApi);

    return AppPage(
      inspectionRepository: inspectionRepository,
    );
  });
}
