import 'package:denv_desktop/l10n/l10n.dart';
import 'package:fluent_ui/fluent_ui.dart';

class SuccessDialog extends StatelessWidget {
  const SuccessDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return ContentDialog(
      title: Text(l10n.inspectionTableExportSuccessTitleDialog),
      content: Text(l10n.inspectionTableExportSuccessContentDialog),
      actions: [
        FilledButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.inspectionTableExportSuccessAcceptButton),
        ),
      ],
    );
  }
}
