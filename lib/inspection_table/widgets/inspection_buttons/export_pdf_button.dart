import 'package:denv_desktop/app/app.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExportPdfButton extends StatelessWidget {
  const ExportPdfButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkThemeOn = context.select(
      (AppCubit cubit) => cubit.state.isDarkThemeOn,
    );

    return FilledButton(
      onPressed: () {},
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Row(
          children: [
            Icon(
              FluentIcons.pdf,
              size: 25,
              color: isDarkThemeOn
                  ? const Color.fromARGB(255, 39, 39, 39)
                  : Colors.white,
            ),
            const SizedBox(width: 10),
            Text(
              'Exportar a PDF',
              style: FluentTheme.of(context).typography.bodyStrong!.copyWith(
                    color: isDarkThemeOn
                        ? const Color.fromARGB(255, 39, 39, 39)
                        : Colors.white,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
