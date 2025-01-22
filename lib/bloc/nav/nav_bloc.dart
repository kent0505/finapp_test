import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'nav_event.dart';
part 'nav_state.dart';

class NavBloc extends Bloc<NavEvent, NavState> {
  NavBloc() : super(NavInitial()) {
    on<ChangePage>((event, emit) {
      if (event.id == 1) emit(NavInitial());
      if (event.id == 2) emit(NavIncome());
      if (event.id == 3) emit(NavNews());
    });
  }
}
