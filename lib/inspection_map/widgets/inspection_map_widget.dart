import 'package:denv_desktop/app/app.dart';
import 'package:denv_desktop/inspection_map/inspection_map.dart';
import 'package:denv_desktop/l10n/l10n.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inspection_api/inspection_api.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class InspectionMapWidget extends StatelessWidget {
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
  Widget build(BuildContext context) {
    initializeDateFormatting('es');
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
                          urlTemplate: inspectionCubit.state.bingUrlTemplate,
                          zoomPanBehavior: MapZoomPanBehavior(
                            minZoomLevel: 3,
                            maxZoomLevel: 20,
                            zoomLevel: 12,
                            focalLatLng: MapLatLng(
                              centerLatitude,
                              centerLongitude,
                            ),
                            showToolbar: false,
                            enableMouseWheelZooming: true,
                          ),
                          initialMarkersCount: homeInspections.length,
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
                                    homeInspections[index].photoUrl,
                                    fit: BoxFit.contain,
                                    loadingBuilder: (
                                      context,
                                      child,
                                      loadingProgress,
                                    ) {
                                      if (loadingProgress == null) {
                                        return child;
                                      }
                                      return Center(
                                        child: ProgressRing(
                                          value: loadingProgress
                                                      .expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                        ),
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
                                            homeInspections[index]
                                                .dateTime
                                                .date,
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
                                            homeInspections[index]
                                                .dateTime
                                                .time,
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
                              latitude: homeInspections[index].latitude,
                              longitude: homeInspections[index].longitude,
                              // alignment: Alignment.center,
                              child: GestureDetector(
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
    return DateFormat('hh:mm a').format(this);
  }
}
