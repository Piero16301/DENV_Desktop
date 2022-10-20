import 'package:denv_desktop/app/app.dart';
import 'package:denv_desktop/inspection_map/inspection_map.dart';
import 'package:denv_desktop/l10n/l10n.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inspection_api/inspection_api.dart';
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
                          tooltipSettings: MapTooltipSettings(
                            color: Colors.red,
                          ),
                          
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
