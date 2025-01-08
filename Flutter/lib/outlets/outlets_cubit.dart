import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:quick_bite/outlets/outlets_state.dart';
import 'package:quick_bite/shared/models.dart';

class OutletsCubit extends Cubit<OutletsState> {
  OutletsCubit() : super(OutletsLoadingState());

  Future<void> getOutlets() async {
    emit(OutletsLoadingState());

    final url = Uri.parse('http://localhost:3000/outlets');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      List<dynamic> outletsJson = jsonResponse['outlets'];
      List<Outlet> outlets =
          outletsJson.map((outlet) => Outlet.fromJson(outlet)).toList();
      emit(OutletsLoadedState(outlets));
    } else if (response.statusCode == 404) {
      throw Exception('Outlets cannot be found');
    } else {
      throw Exception('Failed to load outlets');
    }
  }
}
