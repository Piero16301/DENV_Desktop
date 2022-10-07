import 'dart:async';

import 'package:denv_desktop/app/app.dart';
import 'package:denv_desktop/inspection_map/inspection_map.dart';
import 'package:denv_desktop/l10n/l10n.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inspection_api/inspection_api.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class InspectionMapWidget extends StatefulWidget {
  const InspectionMapWidget({
    super.key,
    required this.homeInspections,
    required this.isDarkMode,
  });

  final List<HomeInspectionSummarized> homeInspections;
  final bool isDarkMode;

  @override
  State<InspectionMapWidget> createState() => _InspectionMapWidgetState();
}

class _InspectionMapWidgetState extends State<InspectionMapWidget>
    with WidgetsBindingObserver {
  late StreamSubscription<void> _subscription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _subscription = Stream<void>.periodic(const Duration(seconds: 5)).listen(
      (_) => context.read<InspectionMapCubit>().getHomeInspections(
            isDarkMode: widget.isDarkMode,
          ),
    );
  }

  @override
  void dispose() {
    _subscription.cancel();
    WidgetsBinding.instance.removeObserver(this);
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
                          minZoomLevel: 6,
                          maxZoomLevel: 20,
                          zoomLevel: 12,
                          focalLatLng: const MapLatLng(
                            -12.135137224550256,
                            -77.02183252682232,
                          ),
                          showToolbar: false,
                          enableMouseWheelZooming: true,
                        ),
                        initialMarkersCount: widget.homeInspections.length,
                        markerBuilder: (context, index) {
                          return MapMarker(
                            latitude: widget.homeInspections[index].latitude,
                            longitude: widget.homeInspections[index].longitude,
                            alignment: Alignment.bottomCenter,
                            child: GestureDetector(
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 250),
                                height: 30,
                                width: 30,
                                child: FittedBox(
                                  child: Icon(
                                    FluentIcons.p_b_i_anomalies_marker,
                                    color: Colors.red,
                                    size: 30,
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
        ],
      ),
    );
  }
}
