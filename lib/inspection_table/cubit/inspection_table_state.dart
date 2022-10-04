part of 'inspection_table_cubit.dart';

enum InspectionTableStatus {
  initial,
  loading,
  success,
  failure;

  bool get isInitial => this == InspectionTableStatus.initial;
  bool get isLoading => this == InspectionTableStatus.loading;
  bool get isSuccess => this == InspectionTableStatus.success;
  bool get isFailure => this == InspectionTableStatus.failure;
}

enum InspectionExportStatus {
  initial,
  loading,
  success,
  failure;

  bool get isInitial => this == InspectionExportStatus.initial;
  bool get isLoading => this == InspectionExportStatus.loading;
  bool get isSuccess => this == InspectionExportStatus.success;
  bool get isFailure => this == InspectionExportStatus.failure;
}

class InspectionTableState extends Equatable {
  const InspectionTableState({
    this.status = InspectionTableStatus.initial,
    this.homeInspections = const <HomeInspectionDetailed>[],
    this.dataGridKey,
    this.exportStatus = InspectionExportStatus.initial,
    this.isKeyUpdated = false,
  });

  final InspectionTableStatus status;
  final List<HomeInspectionDetailed> homeInspections;
  final GlobalKey<SfDataGridState>? dataGridKey;
  final InspectionExportStatus exportStatus;
  final bool isKeyUpdated;

  @override
  List<Object?> get props => [
        status,
        homeInspections,
        dataGridKey,
        exportStatus,
        isKeyUpdated,
      ];

  InspectionTableState copyWith({
    InspectionTableStatus? status,
    List<HomeInspectionDetailed>? homeInspections,
    GlobalKey<SfDataGridState>? dataGridKey,
    InspectionExportStatus? exportStatus,
    bool? isKeyUpdated,
  }) {
    return InspectionTableState(
      status: status ?? this.status,
      homeInspections: homeInspections ?? this.homeInspections,
      dataGridKey: dataGridKey ?? this.dataGridKey,
      exportStatus: exportStatus ?? this.exportStatus,
      isKeyUpdated: isKeyUpdated ?? this.isKeyUpdated,
    );
  }
}
