import 'package:fluent_ui/fluent_ui.dart';

class SuccessDialog extends StatelessWidget {
  const SuccessDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return ContentDialog(
      title: const Text('Exportación exitosa'),
      content: const Text('El archivo se exportó correctamente y se guardó en '
          'la carpeta de Descargas'),
      actions: [
        FilledButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Aceptar'),
        ),
      ],
    );
  }
}
