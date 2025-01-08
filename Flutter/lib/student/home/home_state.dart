import 'package:quick_bite/shared/models.dart';

abstract class HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedState extends HomeState {
  HomeLoadedState(this.user);

  final User user;
}
