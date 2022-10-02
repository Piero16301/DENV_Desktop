import 'package:fluent_ui/fluent_ui.dart';

class InspectionTableEmpty extends StatelessWidget {
  const InspectionTableEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'No hay inspeciones de viviendas',
        style: FluentTheme.of(context).typography.subtitle,
      ),
    );
  }
}
