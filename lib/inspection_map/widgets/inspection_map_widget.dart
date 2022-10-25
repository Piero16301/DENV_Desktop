import 'dart:async';

import 'package:denv_desktop/app/app.dart';
import 'package:denv_desktop/inspection_map/inspection_map.dart';
import 'package:denv_desktop/l10n/l10n.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inspection_api/inspection_api.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_maps/maps.dart';
import 'package:text_scroll/text_scroll.dart';

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

class _InspectionMapWidgetState extends State<InspectionMapWidget>
    with WidgetsBindingObserver {
  late StreamSubscription<void> _subscription;

  late MapZoomPanBehavior _zoomPanBehavior;
  late MapTileLayerController _mapController;

  @override
  void initState() {
    super.initState();

    _subscription = Stream<void>.periodic(const Duration(seconds: 5)).listen(
      (_) async {
        debugPrint('Actualizando marcadores del mapa');
        final bufferHomeInspections =
            await context.read<InspectionMapCubit>().updateHomeInspections();
        var counter = 0;
        final currentLength = widget.homeInspections.length;
        for (var i = currentLength;
            i < currentLength + bufferHomeInspections.length;
            i++) {
          widget.homeInspections.add(bufferHomeInspections[counter]);
          _mapController.insertMarker(i);
          counter++;
        }
        // ignore: use_build_context_synchronously
        context.read<InspectionMapCubit>().mergeHomeInspections();
        // ignore: use_build_context_synchronously
        context.read<InspectionMapCubit>().updateLastUpdated();
      },
    );

    _mapController = MapTileLayerController();
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
  }

  @override
  void dispose() {
    _subscription.cancel();
    _mapController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _subscription.resume();
    } else {
      if (!_subscription.isPaused) _subscription.pause();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.select(
      (AppCubit cubit) => cubit.state.isDarkMode,
    );
    final inspectionCubit = context.read<InspectionMapCubit>();
    final lastUpdated = inspectionCubit.state.lastUpdated;
    final l10n = context.l10n;

    return ScaffoldPage(
      header: PageHeader(
        title: Text(l10n.inspectionMapAppBarTitle),
      ),
      content: Row(
        children: [
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
              child: Container(
                padding: EdgeInsets.zero,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isDarkMode ? Colors.white : Colors.black,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
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
                                  const SizedBox(height: 2.5),
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
                                            Text(
                                              l10n.inspectionMapDateText,
                                              style: const TextStyle(
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
                                            Text(
                                              l10n.inspectionMapHourText,
                                              style: const TextStyle(
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
                                latitude:
                                    widget.homeInspections[index].latitude,
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
                                      ..zoomLevel = 18;
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
                      Positioned(
                        left: 10,
                        bottom: 10,
                        child: Container(
                          height: 40,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: isDarkMode ? Colors.black : Colors.white,
                            border: Border.all(
                              color: isDarkMode ? Colors.white : Colors.black,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              l10n.inspectionMapLastUpdatedText(
                                lastUpdated!.date,
                                lastUpdated.time,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 10,
                        top: 10,
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: isDarkMode ? Colors.black : Colors.white,
                            border: Border.all(
                              color: isDarkMode ? Colors.white : Colors.black,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Tooltip(
                            message: l10n.inspectionMapRestartView,
                            displayHorizontally: true,
                            useMousePosition: false,
                            child: IconButton(
                              icon: const Icon(
                                FluentIcons.sync,
                                size: 20,
                              ),
                              onPressed: () {
                                _zoomPanBehavior
                                  ..focalLatLng =
                                      inspectionCubit.getCenterLatLng()
                                  ..zoomLevel = 12;
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 25, bottom: 25),
              child: Container(
                padding: EdgeInsets.zero,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isDarkMode ? Colors.white : Colors.black,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 10,
                            ),
                            child: TextScrollDetails(content: 'DNI: 12345678'),
                          ),
                          Expander(
                            header: Text(
                              'Dirección',
                              style:
                                  FluentTheme.of(context).typography.bodyLarge,
                            ),
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                TextScrollDetails(
                                  content: 'Código postal: 19276',
                                ),
                                SizedBox(height: 2.5),
                                TextScrollDetails(content: 'País: España'),
                                SizedBox(height: 2.5),
                                TextScrollDetails(
                                  content: 'Departamento: Barcelona',
                                ),
                                SizedBox(height: 2.5),
                                TextScrollDetails(
                                  content: 'Provincia: Barcelona',
                                ),
                                SizedBox(height: 2.5),
                                TextScrollDetails(
                                  content: 'Distrito: Les Corts',
                                ),
                                SizedBox(height: 2.5),
                                TextScrollDetails(
                                  content: 'Urbanización: Les Corts',
                                ),
                                SizedBox(height: 2.5),
                                TextScrollDetails(
                                  content: 'Calle: Carrer de la Diputació',
                                ),
                                SizedBox(height: 2.5),
                                TextScrollDetails(content: 'Número: 342'),
                                SizedBox(height: 2.5),
                                TextScrollDetails(
                                  content:
                                      'Dirección: Carrer de la Diputació, 342, 19276 Les Corts, Barcelona, España',
                                ),
                                SizedBox(height: 2.5),
                                TextScrollDetails(content: 'Manzana: A-1'),
                                SizedBox(height: 2.5),
                                TextScrollDetails(content: 'Lote: 1'),
                              ],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 10,
                            ),
                            child: TextScroll(
                              'N° de habitantes: 5',
                              mode: TextScrollMode.bouncing,
                              velocity: Velocity(
                                pixelsPerSecond: Offset(15, 0),
                              ),
                              delayBefore: Duration(milliseconds: 500),
                              pauseBetween: Duration(milliseconds: 50),
                              selectable: true,
                              style: TextStyle(
                                fontFamily: 'Courier New',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Expander(
                            header: Text(
                              'Condición de vivienda',
                              style:
                                  FluentTheme.of(context).typography.bodyLarge,
                            ),
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                TextScrollDetails(
                                  content: 'Vivienda inspecionada: 1',
                                ),
                                SizedBox(height: 2.5),
                                TextScrollDetails(
                                  content: 'Vivienda renuente: 1',
                                ),
                                SizedBox(height: 2.5),
                                TextScrollDetails(
                                  content: 'Vivienda cerrada: 1',
                                ),
                                SizedBox(height: 2.5),
                                TextScrollDetails(
                                  content: 'Vivienda deshabitada: 1',
                                ),
                                SizedBox(height: 2.5),
                                TextScrollDetails(
                                  content: 'Vivienda focos: 1',
                                ),
                                SizedBox(height: 2.5),
                                TextScrollDetails(
                                  content: 'Vivienda tratada con abte: 1',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        right: 10,
                        bottom: 10,
                        child: SizedBox(
                          height: 40,
                          width: 40,
                          child: FilledButton(
                            child: const Icon(FluentIcons.chrome_close),
                            onPressed: () {},
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TextScrollDetails extends StatelessWidget {
  const TextScrollDetails({
    super.key,
    required this.content,
  });

  final String content;

  @override
  Widget build(BuildContext context) {
    return TextScroll(
      content,
      mode: TextScrollMode.bouncing,
      velocity: const Velocity(
        pixelsPerSecond: Offset(15, 0),
      ),
      delayBefore: const Duration(milliseconds: 500),
      pauseBetween: const Duration(milliseconds: 50),
      selectable: true,
      style: const TextStyle(
        fontFamily: 'Courier New',
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

extension on DateTime {
  String get date {
    return DateFormat('dd-MM-yyyy', 'es_ES').format(this);
  }

  String get time {
    return DateFormat('hh:mm a', 'en_US').format(this);
  }
}
