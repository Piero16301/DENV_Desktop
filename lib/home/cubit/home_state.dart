part of 'home_cubit.dart';

class HomeState extends Equatable {
  const HomeState({
    this.paneIndex = 0,
  });

  final int paneIndex;

  @override
  List<Object> get props => [paneIndex];

  HomeState copyWith({
    int? paneIndex,
  }) {
    return HomeState(
      paneIndex: paneIndex ?? this.paneIndex,
    );
  }
}
