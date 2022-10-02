import 'package:fluent_ui/fluent_ui.dart';

class InspectionTableLoading extends StatelessWidget {
  const InspectionTableLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: ProgressRing(),
    );
  }
}
