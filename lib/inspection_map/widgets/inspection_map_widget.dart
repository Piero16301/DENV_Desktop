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
        context.read<InspectionMapCubit>().cleanBufferHomeInspections();
      },
    );

    _mapController = MapTileLayerController();
    _zoomPanBehavior = MapZoomPanBehavior(
      minZoomLevel: 3,
      maxZoomLevel: 20,
      zoomLevel: 8,
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
        commandBar: Expanded(
          child: CommandBarCard(
            child: CommandBar(
              overflowBehavior: CommandBarOverflowBehavior.scrolling,
              primaryItems: [
                CommandBarButton(
                  icon: const Icon(FluentIcons.number_field),
                  label: SizedBox(
                    width: 150,
                    child: TextBox(
                      placeholder: 'Días de búsqueda',
                      onChanged: (value) {},
                    ),
                  ),
                  onPressed: () {},
                ),
                CommandBarButton(
                  icon: const Icon(FluentIcons.sync),
                  label: Text(l10n.inspectionTableUpdateText),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
      content: Row(
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
              child: Card(
                borderRadius: BorderRadius.circular(10),
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
                                  onTap: () async {
                                    await inspectionCubit
                                        .getSelectedInspectionDetails(
                                      inspectionId:
                                          widget.homeInspections[index].id,
                                    );
                                    _zoomPanBehavior
                                      ..focalLatLng = MapLatLng(
                                        widget.homeInspections[index].latitude,
                                        widget.homeInspections[index].longitude,
                                      )
                                      ..zoomLevel = 18;
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
                        child: Card(
                          borderRadius: BorderRadius.circular(10),
                          padding: const EdgeInsets.all(10),
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
                        child: Card(
                          borderRadius: BorderRadius.circular(10),
                          padding: const EdgeInsets.all(5),
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
                                  ..zoomLevel = 8;
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
          BlocBuilder<InspectionMapCubit, InspectionMapState>(
            builder: (context, state) {
              if (state.selectedInspectionStatus.isLoading) {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 25, bottom: 25),
                    child: Card(
                      borderRadius: BorderRadius.circular(10),
                      child: Stack(
                        children: const [
                          SizedBox(
                            height: double.infinity,
                            child: Center(
                              child: ProgressRing(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              } else if (state.selectedInspectionStatus.isSuccess) {
                return HomeInspectionDetailsPanel(
                  isDarkMode: isDarkMode,
                  padRight: _padRight,
                  inspection: state.selectedInspection!,
                );
              } else if (state.selectedInspectionStatus.isFailure) {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 25, bottom: 25),
                    child: Card(
                      borderRadius: BorderRadius.circular(10),
                      child: Stack(
                        children: const [
                          SizedBox(
                            height: double.infinity,
                            child: Center(
                              child: Text('Error'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}

class HomeInspectionDetailsPanel extends StatelessWidget {
  const HomeInspectionDetailsPanel({
    super.key,
    required this.isDarkMode,
    required int padRight,
    required this.inspection,
  }) : _padRight = padRight;

  final bool isDarkMode;
  final int _padRight;
  final HomeInspectionDetailed inspection;

  @override
  Widget build(BuildContext context) {
    final inspectionCubit = context.read<InspectionMapCubit>();

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(right: 25, bottom: 25),
        child: Card(
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
                          content: inspection.dni,
                        ),
                      ),
                      Expander(
                        header: Text(
                          'Dirección',
                          style: FluentTheme.of(context).typography.bodyLarge,
                        ),
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextScrollDetails(
                              title: 'Código postal'.padRight(_padRight),
                              content: inspection.address.postalCode,
                            ),
                            const SizedBox(height: 2.5),
                            TextScrollDetails(
                              title: 'País'.padRight(_padRight),
                              content: inspection.address.country,
                            ),
                            const SizedBox(height: 2.5),
                            TextScrollDetails(
                              title: 'Departamento'.padRight(_padRight),
                              content: inspection.address.department,
                            ),
                            const SizedBox(height: 2.5),
                            TextScrollDetails(
                              title: 'Provincia'.padRight(_padRight),
                              content: inspection.address.province,
                            ),
                            const SizedBox(height: 2.5),
                            TextScrollDetails(
                              title: 'Distrito'.padRight(_padRight),
                              content: inspection.address.district,
                            ),
                            const SizedBox(height: 2.5),
                            TextScrollDetails(
                              title: 'Urbanización'.padRight(_padRight),
                              content: inspection.address.urbanization,
                            ),
                            const SizedBox(height: 2.5),
                            TextScrollDetails(
                              title: 'Calle'.padRight(_padRight),
                              content: inspection.address.street,
                            ),
                            const SizedBox(height: 2.5),
                            TextScrollDetails(
                              title: 'Número'.padRight(_padRight),
                              content:
                                  inspection.address.streetNumber.toString(),
                            ),
                            const SizedBox(height: 2.5),
                            TextScrollDetails(
                              title: 'Dirección'.padRight(_padRight),
                              content: inspection.address.formattedAddress,
                            ),
                            const SizedBox(height: 2.5),
                            TextScrollDetails(
                              title: 'Manzana'.padRight(_padRight),
                              content: inspection.address.block,
                            ),
                            const SizedBox(height: 2.5),
                            TextScrollDetails(
                              title: 'Lote'.padRight(_padRight),
                              content: inspection.address.lot.toString(),
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
                          content: inspection.numberInhabitants.toString(),
                        ),
                      ),
                      Expander(
                        header: Text(
                          'Condición de vivienda',
                          style: FluentTheme.of(context).typography.bodyLarge,
                        ),
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextScrollDetails(
                              title:
                                  'Vivienda inspecionada'.padRight(_padRight),
                              content: inspection.homeCondition.inspectedHome
                                  .toString(),
                            ),
                            const SizedBox(height: 2.5),
                            TextScrollDetails(
                              title: 'Vivienda renuente'.padRight(_padRight),
                              content: inspection
                                  .homeCondition.reluctantDwelling
                                  .toString(),
                            ),
                            const SizedBox(height: 2.5),
                            TextScrollDetails(
                              title: 'Vivienda cerrada'.padRight(_padRight),
                              content: inspection.homeCondition.closedHome
                                  .toString(),
                            ),
                            const SizedBox(height: 2.5),
                            TextScrollDetails(
                              title: 'Vivienda deshabitada'.padRight(_padRight),
                              content: inspection.homeCondition.uninhabitedHouse
                                  .toString(),
                            ),
                            const SizedBox(height: 2.5),
                            TextScrollDetails(
                              title: 'Vivienda focos'.padRight(_padRight),
                              content: inspection
                                  .homeCondition.housingSpotlights
                                  .toString(),
                            ),
                            const SizedBox(height: 2.5),
                            TextScrollDetails(
                              title: 'Vivienda tratada con abte'.padRight(
                                _padRight,
                              ),
                              content: inspection.homeCondition.treatedHousing
                                  .toString(),
                            ),
                          ],
                        ),
                      ),
                      Expander(
                        header: Text(
                          'Tipo de recipientes',
                          style: FluentTheme.of(context).typography.bodyLarge,
                        ),
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextScrollDetails(
                              title: 'Tanque elevado'.padRight(_padRight),
                              content:
                                  'I=${inspection.typeContainers.elevatedTank.i.toString().padLeft(2)}, P=${inspection.typeContainers.elevatedTank.p.toString().padLeft(2)}, T=${inspection.typeContainers.elevatedTank.t.toString().padLeft(2)}',
                            ),
                            const SizedBox(height: 2.5),
                            TextScrollDetails(
                              title: 'Tanque bajo, pozos'.padRight(
                                _padRight,
                              ),
                              content:
                                  'I=${inspection.typeContainers.lowTank.i.toString().padLeft(2)}, P=${inspection.typeContainers.lowTank.p.toString().padLeft(2)}, T=${inspection.typeContainers.lowTank.t.toString().padLeft(2)}',
                            ),
                            const SizedBox(height: 2.5),
                            TextScrollDetails(
                              title: 'Barril, cilindro sanson'.padRight(
                                _padRight,
                              ),
                              content:
                                  'I=${inspection.typeContainers.cylinderBarrel.i.toString().padLeft(2)}, P=${inspection.typeContainers.cylinderBarrel.p.toString().padLeft(2)}, T=${inspection.typeContainers.cylinderBarrel.t.toString().padLeft(2)}',
                            ),
                            const SizedBox(height: 2.5),
                            TextScrollDetails(
                              title: 'Balde, abtea, tina'.padRight(
                                _padRight,
                              ),
                              content:
                                  'I=${inspection.typeContainers.bucketTub.i.toString().padLeft(2)}, P=${inspection.typeContainers.bucketTub.p.toString().padLeft(2)}, T=${inspection.typeContainers.bucketTub.t.toString().padLeft(2)}',
                            ),
                            const SizedBox(height: 2.5),
                            TextScrollDetails(
                              title: 'Llanta'.padRight(_padRight),
                              content:
                                  'I=${inspection.typeContainers.tire.i.toString().padLeft(2)}, P=${inspection.typeContainers.tire.p.toString().padLeft(2)}, T=${inspection.typeContainers.tire.t.toString().padLeft(2)}',
                            ),
                            const SizedBox(height: 2.5),
                            TextScrollDetails(
                              title: 'Florero, maceta'.padRight(
                                _padRight,
                              ),
                              content:
                                  'I=${inspection.typeContainers.flower.i.toString().padLeft(2)}, P=${inspection.typeContainers.flower.p.toString().padLeft(2)}, T=${inspection.typeContainers.flower.t.toString().padLeft(2)}',
                            ),
                            const SizedBox(height: 2.5),
                            TextScrollDetails(
                              title: 'Inservibles'.padRight(_padRight),
                              content:
                                  'I=${inspection.typeContainers.useless.i.toString().padLeft(2)}, P=${inspection.typeContainers.useless.p.toString().padLeft(2)}, T=${inspection.typeContainers.useless.t.toString().padLeft(2)}',
                            ),
                            const SizedBox(height: 2.5),
                            TextScrollDetails(
                              title: 'Otros'.padRight(_padRight),
                              content:
                                  'I=${inspection.typeContainers.others.i.toString().padLeft(2)}, P=${inspection.typeContainers.others.p.toString().padLeft(2)}, T=${inspection.typeContainers.others.t.toString().padLeft(2)}',
                            ),
                          ],
                        ),
                      ),
                      Expander(
                        header: Text(
                          'Total de recipiente',
                          style: FluentTheme.of(context).typography.bodyLarge,
                        ),
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextScrollDetails(
                              title: 'Recipientes inspeccionados'
                                  .padRight(_padRight),
                              content: inspection
                                  .totalContainer.inspectedContainers
                                  .toString(),
                            ),
                            const SizedBox(height: 2.5),
                            TextScrollDetails(
                              title: 'Recipientes focos'.padRight(
                                _padRight,
                              ),
                              content: inspection
                                  .totalContainer.containersSpotlights
                                  .toString(),
                            ),
                            const SizedBox(height: 2.5),
                            TextScrollDetails(
                              title: 'Recipientes tratados'.padRight(
                                _padRight,
                              ),
                              content: inspection
                                  .totalContainer.treatedContainers
                                  .toString(),
                            ),
                            const SizedBox(height: 2.5),
                            TextScrollDetails(
                              title: 'Recipientes destruidos'.padRight(
                                _padRight,
                              ),
                              content: inspection
                                  .totalContainer.destroyedContainers
                                  .toString(),
                            ),
                          ],
                        ),
                      ),
                      Expander(
                        header: Text(
                          'Foco de A. aegypti',
                          style: FluentTheme.of(context).typography.bodyLarge,
                        ),
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextScrollDetails(
                              title: 'Larvas'.padRight(_padRight),
                              content:
                                  inspection.aegyptiFocus.larvae.toString(),
                            ),
                            const SizedBox(height: 2.5),
                            TextScrollDetails(
                              title: 'Pupas'.padRight(
                                _padRight,
                              ),
                              content: inspection.aegyptiFocus.pupae.toString(),
                            ),
                            const SizedBox(height: 2.5),
                            TextScrollDetails(
                              title: 'Adulto'.padRight(
                                _padRight,
                              ),
                              content: inspection.aegyptiFocus.adult.toString(),
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
                          content: inspection.larvicide.toStringAsFixed(3),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 10,
                        ),
                        child: TextScrollDetails(
                          title: 'Fecha y hora'.padRight(_padRight),
                          content:
                              '${inspection.dateTime.date} ${inspection.dateTime.time}',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 10,
                        ),
                        child: TextScrollDetails(
                          title: 'Latitud y longitud'.padRight(_padRight),
                          content:
                              '${inspection.latitude.toStringAsFixed(5)}, ${inspection.longitude.toStringAsFixed(5)}',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 10,
                        ),
                        child: TextScrollDetails(
                          title: 'Comentario'.padRight(_padRight),
                          content: inspection.comment,
                        ),
                      ),
                      Expander(
                        header: Text(
                          'Fotografía',
                          style: FluentTheme.of(context).typography.bodyLarge,
                        ),
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                inspection.photoUrl,
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
                          ],
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
                    onPressed: inspectionCubit.closeSelectedInspection,
                    child: const Icon(FluentIcons.chrome_close),
                  ),
                ),
              ),
            ],
          ),
        ),
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
    return DateFormat('hh:mm:ss a', 'en_US').format(this);
  }
}
