import 'package:fluent_ui/fluent_ui.dart';

class InspectionMapEmpty extends StatelessWidget {
  const InspectionMapEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'No inspections found',
        style: FluentTheme.of(context).typography.subtitle,
      ),
    );
  }
}
