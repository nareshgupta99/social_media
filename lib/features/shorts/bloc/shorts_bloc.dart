import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'shorts_event.dart';
part 'shorts_state.dart';

class ShortsBloc extends Bloc<ShortsEvent, ShortsState> {
  ShortsBloc() : super(ShortsInitial()) {
    on<ShortsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
