import 'package:denv_desktop/app/app.dart';
import 'package:denv_desktop/inspection_map/inspection_map.dart';
import 'package:denv_desktop/l10n/l10n.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inspection_api/inspection_api.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class InspectionMapWidget extends StatefulWidget {
  const InspectionMapWidget({
    super.key,
    required this.homeInspections,
    required this.centerLatitude,
    required this.centerLongitude,
    required this.isDarkMode,
  });

  final List<HomeInspectionSummarized> homeInspections;
  final double centerLatitude;
  final double centerLongitude;
  final bool isDarkMode;

  @override
  State<InspectionMapWidget> createState() => _InspectionMapWidgetState();
}

class _InspectionMapWidgetState extends State<InspectionMapWidget> {
  late MapZoomPanBehavior _zoomPanBehavior;
  late MapTileLayerController _mapController;

  @override
  void initState() {
    super.initState();
    _zoomPanBehavior = MapZoomPanBehavior(
      minZoomLevel: 3,
      maxZoomLevel: 20,
      zoomLevel: 12,
      focalLatLng: MapLatLng(
        widget.centerLatitude,
        widget.centerLongitude,
      ),
      showToolbar: false,
      enableMouseWheelZooming: true,
    );
    _mapController = MapTileLayerController();
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.select(
      (AppCubit cubit) => cubit.state.isDarkMode,
    );
    final inspectionCubit = context.read<InspectionMapCubit>();
    final l10n = context.l10n;

    return ScaffoldPage(
      header: PageHeader(
        title: Text(l10n.inspectionMapAppBarTitle),
      ),
      content: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.asset(
                        isDarkMode
                            ? 'assets/map_grids/dark_grid.png'
                            : 'assets/map_grids/light_grid.png',
                        repeat: ImageRepeat.repeat,
                      ),
                    ),
                    SfMaps(
                      layers: [
                        MapTileLayer(
                          controller: _mapController,
                          urlTemplate: inspectionCubit.state.bingUrlTemplate,
                          zoomPanBehavior: _zoomPanBehavior,
                          initialMarkersCount: widget.homeInspections.length,
                          tooltipSettings: const MapTooltipSettings(
                            color: Colors.transparent,
                          ),
                          markerTooltipBuilder: (context, index) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 150,
                                  height: 112.5,
                                  decoration: BoxDecoration(
                                    color: isDarkMode
                                        ? Colors.black
                                        : Colors.white,
                                    border: Border.all(
                                      color: isDarkMode
                                          ? Colors.white
                                          : Colors.black,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Image.network(
                                    widget.homeInspections[index].photoUrl,
                                    fit: BoxFit.contain,
                                    loadingBuilder: (
                                      context,
                                      child,
                                      loadingProgress,
                                    ) {
                                      if (loadingProgress == null) {
                                        return child;
                                      }
                                      return const Center(
                                        child: ProgressRing(),
                                      );
                                    },
                                    errorBuilder: (
                                      context,
                                      error,
                                      stackTrace,
                                    ) {
                                      return Image.asset(
                                        'assets/images/no-image.png',
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Container(
                                  width: 150,
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: isDarkMode
                                        ? Colors.black
                                        : Colors.white,
                                    border: Border.all(
                                      color: isDarkMode
                                          ? Colors.white
                                          : Colors.black,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'Fecha:',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            widget.homeInspections[index]
                                                .dateTime.date,
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'Hora:',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            widget.homeInspections[index]
                                                .dateTime.time,
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                          markerBuilder: (context, index) {
                            return MapMarker(
                              latitude: widget.homeInspections[index].latitude,
                              longitude:
                                  widget.homeInspections[index].longitude,
                              // alignment: Alignment.center,
                              child: GestureDetector(
                                onTap: () {
                                  _zoomPanBehavior
                                    ..focalLatLng = MapLatLng(
                                      widget.homeInspections[index].latitude,
                                      widget.homeInspections[index].longitude,
                                    )
                                    ..zoomLevel = 17.5;
                                  // _mapController.updateMarkers([1, 5]);
                                },
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 250),
                                  height: 20,
                                  width: 20,
                                  child: FittedBox(
                                    child: Icon(
                                      FluentIcons.alert_solid,
                                      color: Colors.blue,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

extension on DateTime {
  String get date {
    final month = DateFormat('MMM', 'es_ES')
        .format(this)
        .replaceFirst('.', '')
        .toUpperCase();
    return '$day-$month-$year';
  }

  String get time {
    return DateFormat('hh:mm a', 'es_ES').format(this);
  }
}
