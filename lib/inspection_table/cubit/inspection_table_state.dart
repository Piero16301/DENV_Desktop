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

class InspectionTableState extends Equatable {
  final InspectionTableStatus status;
  final List<InspectionTable> inspectionTables;
  final String? error;

  const InspectionTableState({
    this.status = InspectionTableStatus.initial,
    this.inspectionTables = const [],
    this.error,
  });

  InspectionTableState copyWith({
    InspectionTableStatus? status,
    List<InspectionTable>? inspectionTables,
    String? error,
  }) {
    return InspectionTableState(
      status: status ?? this.status,
      inspectionTables: inspectionTables ?? this.inspectionTables,
      error: error,
    );
  }

  @override
  List<Object?> get props => [status, inspectionTables, error];
}
