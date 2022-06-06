import 'package:fluent_ui/fluent_ui.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

import 'package:deteccion_zonas_dengue_desktop/theme/app_theme.dart';
import 'package:deteccion_zonas_dengue_desktop/providers/providers.dart';

class MapReportsPage extends StatefulWidget {
  const MapReportsPage({Key? key}) : super(key: key);

  @override
  State<MapReportsPage> createState() => _MapReportsPageState();
}

class _MapReportsPageState extends State<MapReportsPage> {
  @override
  Widget build(BuildContext context) {
    final pointsProvider = Provider.of<PointsProvider>(context);

    // Types of map layer:
    // Aerial, AerialWithLabels, AerialWithLabelsOnDemand
    // Road, CanvasDark, CanvasLight, CanvasGray
    const String mapType = 'Road';

    return FutureBuilder(
      future: getBingUrlTemplate(
          'https://dev.virtualearth.net/REST/V1/Imagery/Metadata/$mapType?output=json&uriScheme=https&include=ImageryProviders&key=gKFcszH8QtTWZm2GzcK5~yzuCkObRWRXGBYVgmFKSmg~Ap0qOUWHnFqU8zP5N2483-pbxSPK0mVvvqeYUi2t5EDf9Ao_QZEsh7eItuQ-fLdh'),
      builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            !pointsProvider.isLoading) {
          return _buildMap(snapshot, context);
        } else {
          return const Center(
            child: ProgressRing(activeColor: AppTheme.primary),
          );
        }
      },
    );
  }

  Stack _buildMap(AsyncSnapshot<String?> snapshot, BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final pointsProvider = Provider.of<PointsProvider>(context);

    MapZoomPanBehavior mapZoomPanBehavior = MapZoomPanBehavior(
      minZoomLevel: 6,
      maxZoomLevel: 20,
      zoomLevel: 12,
      focalLatLng: const MapLatLng(-12.135137224550256, -77.02183252682232),
      showToolbar: false,
    );

    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            (themeProvider.currentThemeName == 'light')
                ? 'assets/light_grid.png'
                : 'assets/dark_grid.png',
            repeat: ImageRepeat.repeat,
          ),
        ),
        SfMaps(
          layers: [
            MapTileLayer(
              // urlTemplate: snapshot.data!,
              urlTemplate:
                  'http://api.tomtom.com/map/1/tile/basic/main/{z}/{x}/{y}.png?key=2n6NZq9biOKkls94z6upyCSGGSpS9PGI&language=es-ES',
              zoomPanBehavior: mapZoomPanBehavior,
              initialMarkersCount: pointsProvider.points.length,
              tooltipSettings: const MapTooltipSettings(
                color: Colors.transparent,
              ),
              markerTooltipBuilder: (BuildContext context, int index) {
                return ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 150,
                        height: 112.5,
                        color: Colors.grey,
                        child: (pointsProvider.points[index].photoUrl ==
                                'Sin enlace')
                            ? Image.asset('assets/no-image.png',
                                fit: BoxFit.contain)
                            : Image.network(
                                pointsProvider.points[index].photoUrl,
                                fit: BoxFit.contain),
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                          left: 10.0,
                          top: 5.0,
                          bottom: 5.0,
                        ),
                        width: 150,
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Zona reportada ${index + 1}',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 2.5),
                              child: Text(
                                '${DateFormat('dd-MM-yyyy').format(pointsProvider.points[index].date)} | ${DateFormat('HH:mm').format(pointsProvider.points[index].date)}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: Text(
                                pointsProvider.points[index].comment,
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
              markerBuilder: (BuildContext context, int index) {
                return MapMarker(
                  latitude: pointsProvider.points[index].latitude,
                  longitude: pointsProvider.points[index].longitude,
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
    );
  }
}
