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
  const InspectionTableState({
    this.status = InspectionTableStatus.initial,
    this.homeInspections = const <HomeInspectionDetailed>[],
  });

  final InspectionTableStatus status;
  final List<HomeInspectionDetailed> homeInspections;

  @override
  List<Object?> get props => [
        status,
        homeInspections,
      ];

  InspectionTableState copyWith({
    InspectionTableStatus? status,
    List<HomeInspectionDetailed>? homeInspections,
  }) {
    return InspectionTableState(
      status: status ?? this.status,
      homeInspections: homeInspections ?? this.homeInspections,
    );
  }
}
