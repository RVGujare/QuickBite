import 'package:quick_bite/shared/models.dart';

abstract class OutletsState {}

class OutletsLoadingState extends OutletsState {}

class OutletsLoadedState extends OutletsState {
  OutletsLoadedState(this.outlets);

  final List<Outlet> outlets;
}
