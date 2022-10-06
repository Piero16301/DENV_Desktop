import 'package:fluent_ui/fluent_ui.dart';

class InspectionMapLoading extends StatelessWidget {
  const InspectionMapLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: ProgressRing(),
    );
  }
}
