import 'package:fluent_ui/fluent_ui.dart';

class InspectionTableError extends StatelessWidget {
  const InspectionTableError({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Error al cargar las inspecciones de viviendas',
        style: FluentTheme.of(context).typography.subtitle,
      ),
    );
  }
}
