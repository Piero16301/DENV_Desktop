import 'package:denv_desktop/l10n/l10n.dart';
import 'package:fluent_ui/fluent_ui.dart';

class InspectionTableEmpty extends StatelessWidget {
  const InspectionTableEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Center(
      child: Text(
        l10n.inspectionTableNoDataText,
        style: FluentTheme.of(context).typography.subtitle,
      ),
    );
  }
}
