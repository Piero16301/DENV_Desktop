import 'package:deteccion_zonas_dengue_desktop/theme/app_theme.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class MapReportsPage extends StatefulWidget {
  const MapReportsPage({Key? key}) : super(key: key);

  @override
  State<MapReportsPage> createState() => _MapReportsPageState();
}

class _MapReportsPageState extends State<MapReportsPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getBingUrlTemplate('https://dev.virtualearth.net/REST/V1/Imagery/Metadata/RoadOnDemand?output=json&uriScheme=https&include=ImageryProviders&key=gKFcszH8QtTWZm2GzcK5~yzuCkObRWRXGBYVgmFKSmg~Ap0qOUWHnFqU8zP5N2483-pbxSPK0mVvvqeYUi2t5EDf9Ao_QZEsh7eItuQ-fLdh'),
      builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return SfMapsTheme(
            data: SfMapsThemeData(
              shapeHoverColor: Colors.orange,
            ),
            child: SfMaps(
              layers: [
                MapTileLayer(
                  urlTemplate: snapshot.data!,
                  zoomPanBehavior: MapZoomPanBehavior(
                    minZoomLevel: 3,
                    maxZoomLevel: 20,
                    zoomLevel: 10,
                    focalLatLng: const MapLatLng(-12.135137224550256, -77.02183252682232),
                    showToolbar: false,
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Center(
            child: ProgressRing(activeColor: AppTheme.primary),
          );
        }
      },
    );
  }
}
