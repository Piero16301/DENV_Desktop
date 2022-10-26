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

  final int _padRight = 27;

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
            flex: 2,
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
                      SizedBox(
                        height: double.infinity,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 18,
                                  vertical: 10,
                                ),
                                child: TextScrollDetails(
                                  title: 'DNI'.padRight(_padRight),
                                  content: '12345678',
                                ),
                              ),
                              Expander(
                                header: Text(
                                  'Dirección',
                                  style: FluentTheme.of(context)
                                      .typography
                                      .bodyLarge,
                                ),
                                content: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextScrollDetails(
                                      title:
                                          'Código postal'.padRight(_padRight),
                                      content: '19376',
                                    ),
                                    const SizedBox(height: 2.5),
                                    TextScrollDetails(
                                      title: 'País'.padRight(_padRight),
                                      content: 'España',
                                    ),
                                    const SizedBox(height: 2.5),
                                    TextScrollDetails(
                                      title: 'Departamento'.padRight(_padRight),
                                      content: 'Barcelona',
                                    ),
                                    const SizedBox(height: 2.5),
                                    TextScrollDetails(
                                      title: 'Provincia'.padRight(_padRight),
                                      content: 'Barcelona',
                                    ),
                                    const SizedBox(height: 2.5),
                                    TextScrollDetails(
                                      title: 'Distrito'.padRight(_padRight),
                                      content: 'Les Corts',
                                    ),
                                    const SizedBox(height: 2.5),
                                    TextScrollDetails(
                                      title: 'Urbanización'.padRight(_padRight),
                                      content: 'Les Corts',
                                    ),
                                    const SizedBox(height: 2.5),
                                    TextScrollDetails(
                                      title: 'Calle'.padRight(_padRight),
                                      content: 'Carrer de la Diputació',
                                    ),
                                    const SizedBox(height: 2.5),
                                    TextScrollDetails(
                                      title: 'Número'.padRight(_padRight),
                                      content: '342',
                                    ),
                                    const SizedBox(height: 2.5),
                                    TextScrollDetails(
                                      title: 'Dirección'.padRight(_padRight),
                                      content:
                                          'Carrer de la Diputació, 342, 19376 Les Corts, Barcelona, España',
                                    ),
                                    const SizedBox(height: 2.5),
                                    TextScrollDetails(
                                      title: 'Manzana'.padRight(_padRight),
                                      content: 'A-1',
                                    ),
                                    const SizedBox(height: 2.5),
                                    TextScrollDetails(
                                      title: 'Lote'.padRight(_padRight),
                                      content: '12',
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 18,
                                  vertical: 10,
                                ),
                                child: TextScrollDetails(
                                  title: 'N° de habitantes'.padRight(_padRight),
                                  content: '5',
                                ),
                              ),
                              Expander(
                                header: Text(
                                  'Condición de vivienda',
                                  style: FluentTheme.of(context)
                                      .typography
                                      .bodyLarge,
                                ),
                                content: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextScrollDetails(
                                      title: 'Vivienda inspecionada'
                                          .padRight(_padRight),
                                      content: '1',
                                    ),
                                    const SizedBox(height: 2.5),
                                    TextScrollDetails(
                                      title: 'Vivienda renuente'
                                          .padRight(_padRight),
                                      content: '1',
                                    ),
                                    const SizedBox(height: 2.5),
                                    TextScrollDetails(
                                      title: 'Vivienda cerrada'
                                          .padRight(_padRight),
                                      content: '1',
                                    ),
                                    const SizedBox(height: 2.5),
                                    TextScrollDetails(
                                      title: 'Vivienda deshabitada'
                                          .padRight(_padRight),
                                      content: '1',
                                    ),
                                    const SizedBox(height: 2.5),
                                    TextScrollDetails(
                                      title:
                                          'Vivienda focos'.padRight(_padRight),
                                      content: '1',
                                    ),
                                    const SizedBox(height: 2.5),
                                    TextScrollDetails(
                                      title:
                                          'Vivienda tratada con abte'.padRight(
                                        _padRight,
                                      ),
                                      content: '1',
                                    ),
                                  ],
                                ),
                              ),
                              Expander(
                                header: Text(
                                  'Tipo de recipientes',
                                  style: FluentTheme.of(context)
                                      .typography
                                      .bodyLarge,
                                ),
                                content: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextScrollDetails(
                                      title:
                                          'Tanque elevado'.padRight(_padRight),
                                      content: 'I=1, P=1, T=1',
                                    ),
                                    const SizedBox(height: 2.5),
                                    TextScrollDetails(
                                      title: 'Tanque bajo, pozos'.padRight(
                                        _padRight,
                                      ),
                                      content: 'I=1, P=1, T=1',
                                    ),
                                    const SizedBox(height: 2.5),
                                    TextScrollDetails(
                                      title: 'Barril, cilindro sanson'.padRight(
                                        _padRight,
                                      ),
                                      content: 'I=1, P=1, T=1',
                                    ),
                                    const SizedBox(height: 2.5),
                                    TextScrollDetails(
                                      title: 'Balde, abtea, tina'.padRight(
                                        _padRight,
                                      ),
                                      content: 'I=1, P=1, T=1',
                                    ),
                                    const SizedBox(height: 2.5),
                                    TextScrollDetails(
                                      title: 'Llanta'.padRight(_padRight),
                                      content: 'I=1, P=1, T=1',
                                    ),
                                    const SizedBox(height: 2.5),
                                    TextScrollDetails(
                                      title: 'Florero, maceta'.padRight(
                                        _padRight,
                                      ),
                                      content: 'I=1, P=1, T=1',
                                    ),
                                    const SizedBox(height: 2.5),
                                    TextScrollDetails(
                                      title: 'Inservibles'.padRight(_padRight),
                                      content: 'I=1, P=1, T=1',
                                    ),
                                    const SizedBox(height: 2.5),
                                    TextScrollDetails(
                                      title: 'Otros'.padRight(_padRight),
                                      content: 'I=1, P=1, T=1',
                                    ),
                                  ],
                                ),
                              ),
                              Expander(
                                header: Text(
                                  'Total de recipiente',
                                  style: FluentTheme.of(context)
                                      .typography
                                      .bodyLarge,
                                ),
                                content: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextScrollDetails(
                                      title: 'Recipientes inspeccionados'
                                          .padRight(_padRight),
                                      content: '1',
                                    ),
                                    const SizedBox(height: 2.5),
                                    TextScrollDetails(
                                      title: 'Recipientes focos'.padRight(
                                        _padRight,
                                      ),
                                      content: '1',
                                    ),
                                    const SizedBox(height: 2.5),
                                    TextScrollDetails(
                                      title: 'Recipientes tratados'.padRight(
                                        _padRight,
                                      ),
                                      content: '1',
                                    ),
                                    const SizedBox(height: 2.5),
                                    TextScrollDetails(
                                      title: 'Recipientes destruidos'.padRight(
                                        _padRight,
                                      ),
                                      content: '1',
                                    ),
                                  ],
                                ),
                              ),
                              Expander(
                                header: Text(
                                  'Foco de A. aegypti',
                                  style: FluentTheme.of(context)
                                      .typography
                                      .bodyLarge,
                                ),
                                content: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextScrollDetails(
                                      title: 'Larvas'.padRight(_padRight),
                                      content: '1',
                                    ),
                                    const SizedBox(height: 2.5),
                                    TextScrollDetails(
                                      title: 'Pupas'.padRight(
                                        _padRight,
                                      ),
                                      content: '1',
                                    ),
                                    const SizedBox(height: 2.5),
                                    TextScrollDetails(
                                      title: 'Adulto'.padRight(
                                        _padRight,
                                      ),
                                      content: '1',
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 18,
                                  vertical: 10,
                                ),
                                child: TextScrollDetails(
                                  title: 'Larvicida (grs)'.padRight(_padRight),
                                  content: '3.762',
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 18,
                                  vertical: 10,
                                ),
                                child: TextScrollDetails(
                                  title: 'Comentario'.padRight(_padRight),
                                  content:
                                      'Se ha reportado una nueva inspección de vivienda',
                                ),
                              ),
                            ],
                          ),
                        ),
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
    required this.title,
    required this.content,
  });

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return TextScroll(
      '$title: $content',
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
