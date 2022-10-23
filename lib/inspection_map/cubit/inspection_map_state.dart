part of 'inspection_map_cubit.dart';

enum InspectionMapStatus {
  initial,
  loading,
  success,
  failure;

  bool get isInitial => this == InspectionMapStatus.initial;
  bool get isLoading => this == InspectionMapStatus.loading;
  bool get isSuccess => this == InspectionMapStatus.success;
  bool get isFailure => this == InspectionMapStatus.failure;
}

class InspectionMapState extends Equatable {
  const InspectionMapState({
    this.status = InspectionMapStatus.initial,
    this.homeInspections = const <HomeInspectionSummarized>[],
    this.bufferHomeInspections = const <HomeInspectionSummarized>[],
    this.lastUpdated,
    this.centerLatitude = 0,
    this.centerLongitude = 0,
    this.bingUrlTemplate = '',
  });

  final InspectionMapStatus status;
  final List<HomeInspectionSummarized> homeInspections;
  final List<HomeInspectionSummarized> bufferHomeInspections;
  final DateTime? lastUpdated;
  final double centerLatitude;
  final double centerLongitude;
  final String bingUrlTemplate;

  @override
  List<Object?> get props => [
        status,
        homeInspections,
        bufferHomeInspections,
        lastUpdated,
        centerLatitude,
        centerLongitude,
        bingUrlTemplate,
      ];

  InspectionMapState copyWith({
    InspectionMapStatus? status,
    List<HomeInspectionSummarized>? homeInspections,
    List<HomeInspectionSummarized>? bufferHomeInspections,
    DateTime? lastUpdated,
    double? centerLatitude,
    double? centerLongitude,
    String? bingUrlTemplate,
  }) {
    return InspectionMapState(
      status: status ?? this.status,
      homeInspections: homeInspections ?? this.homeInspections,
      bufferHomeInspections:
          bufferHomeInspections ?? this.bufferHomeInspections,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      centerLatitude: centerLatitude ?? this.centerLatitude,
      centerLongitude: centerLongitude ?? this.centerLongitude,
      bingUrlTemplate: bingUrlTemplate ?? this.bingUrlTemplate,
    );
  }
}
